# PROMPT: Implement Backup and Restore (Google Drive + local file) in my LoanWise Flutter app

You are a senior Flutter engineer. Implement a complete, working **encrypted Backup and Restore** feature in my existing Flutter app **LoanWise** (package `loan_management_app`, offline-first, **sqflite** database, Riverpod, go_router, Android first, I develop on Windows with PowerShell and VS Code). Read the existing project first and reuse its database helper, providers, theme and routing. Do not rewrite unrelated code, and do not break existing screens.

Return complete files (not snippets), the exact `flutter pub add` commands, and the exact changes needed in existing files. Then run `flutter pub get`, `flutter analyze` (must be 0 issues) and `flutter test` and show the real output. If you cannot run something, say so clearly.

---

## 1. Menu entry
The dashboard's three-line (hamburger) drawer has the item **"Backup and restore"**. It must open the new screen `BackupRestoreScreen` (add a route such as `/backup`).

## 2. Packages
`google_sign_in` (version 7.x, API: `GoogleSignIn.instance.initialize(serverClientId: ...)`, `authenticate(scopeHint: ...)`, `attemptLightweightAuthentication()`, `account.authorizationClient.authorizationForScopes / authorizeScopes`), `googleapis`, `http`, `cryptography`, `archive`, `crypto`, `file_picker`, `intl`, `path`, `path_provider`, `shared_preferences`, `sqflite`. Do not use Firebase for this feature. Do not use packages that need ClangCL on Windows.

## 3. Google settings (already created by me; use exactly these)
- **Web client ID (use as `serverClientId`):**
  `781715972528-25h3rdgnv86n8bg8f4p9t1scne72scjg.apps.googleusercontent.com`
- **OAuth scope: only** `https://www.googleapis.com/auth/drive.appdata` (`drive.DriveApi.driveAppdataScope`). No other Drive scope.
- Backups are stored only in Drive's hidden **`appDataFolder`** (`parents: ['appDataFolder']`, `spaces: 'appDataFolder'`).
- Google Cloud needs: Drive API enabled, an Android OAuth client with the app's package name + SHA-1. Tell me every step I must do manually (including the PowerShell command `cd android; .\gradlew signingReport` to read SHA-1) and the common error causes (DEVELOPER_ERROR / wrong SHA-1 / test users not added).
- Request a fresh access token for each Drive operation (tokens expire). Use a small `http.BaseClient` that adds `Authorization: Bearer <token>`.
- `google_sign_in` does **not** support Windows/Linux/macOS desktop: on those platforms hide the Drive section, show a short message, and keep the local-file backup working so I can test on Windows.

## 4. Files to create (exact paths)
```
lib/services/backup/backup_exceptions.dart
lib/services/backup/backup_crypto.dart
lib/services/backup/backup_archive.dart
lib/services/backup/drive_service.dart
lib/services/backup/backup_service.dart
lib/presentation/screens/backup/backup_restore_screen.dart
test/backup_crypto_test.dart
test/backup_service_test.dart
```
Use `package:loan_management_app/...` imports (lint `always_use_package_imports`), `require_trailing_commas`, no `print`.

## 5. Encryption (backup_crypto.dart)
- Cipher: **AES-256-GCM**. Key: **PBKDF2-HMAC-SHA256, 200,000 iterations, 256 bit**, random 16-byte salt. Run PBKDF2 in `Isolate.run` so the UI does not freeze.
- File format (`.lmbk`), exact bytes: `"LMBK"` (4) + version byte `1` + salt (16) + IV/nonce (12) + ciphertext + GCM tag (16). Authenticate the 33-byte header as AAD so header tampering is detected.
- Random salt and IV from `Random.secure()`, new for every backup.
- Decrypt: check magic and minimum size (-> `CorruptBackupException`), version greater than 1 (-> `IncompatibleBackupException`), authentication failure (-> `WrongPasswordException`: "Wrong password, or the backup file is damaged.").
- Minimum password length 8.

## 6. Archive (backup_archive.dart)
- The plaintext is a zip made in memory containing: `manifest.json`, `db/loanwise.db`, and each data folder (`documents/...` for generated PDFs, `photos/...` for the profile picture).
- Manifest fields: `formatVersion`, `dbSchemaVersion` (sqflite `PRAGMA user_version`), `appVersion`, `createdAtUtc`, `dbSha256`, `counts` (customers, loans, documents), `dataDirs`.
- Unpack must be **zip-slip safe**: reject absolute paths and `..`, and verify every output path stays inside the target folder.

## 7. Backup flow (backup_service.dart)
1. Ask the user for a password (with confirmation) in a dialog; show the warning: "If you forget this password the backup cannot be recovered."
2. `PRAGMA wal_checkpoint(TRUNCATE)` (use `rawQuery`), read counts and `getVersion()`.
3. Copy the DB file to a temp snapshot, zip it with the data folders and manifest, encrypt, name it `loanwise_backup_yyyyMMdd_HHmmss.lmbk`. Delete the temp snapshot in `finally`.
4. **Drive:** upload to `appDataFolder`, then **keep only the newest 5** backups (delete older ones). **Local:** save through the file picker (`saveFile`; on Android/iOS pass `bytes`, on desktop write the bytes to the returned path).
5. Save "last backup time" in `shared_preferences` and show it on the screen.
6. Progress callback with step text and a fraction (Preparing database, Packing files, Encrypting, Uploading, Cleaning old backups, Done).

## 8. Restore flow (must be safe)
1. User picks a Drive backup (or a local `.lmbk`), confirms a destructive dialog ("This replaces ALL current customers, loans, EMIs and documents. It cannot be undone."), then enters the password.
2. Download (Drive) or read (file), **decrypt**, unzip to a temp stage folder, then **validate** before touching real data: manifest present, `dbSha256` matches, open the DB read-only, `PRAGMA integrity_check` is `ok`, required tables exist (`users`, `customers`, `loans`, `emis`), and the backup's schema version is not greater than the app's current one.
3. Close the live database. Move the current DB (+ `-wal`, `-shm`, `-journal`) and data folders into a timestamped `restore_backup_<ts>` folder (use rename with a copy-then-delete fallback).
4. Copy the restored DB and folders into place, reopen the database, **rewrite absolute paths** (`documents.file_path`, `users.photo_path`) to this device's folders using the file names, and run a sanity `SELECT COUNT(*)` on the required tables.
5. If **anything** fails after step 3: close the DB, delete the partial new files, move the old data back, reopen, and throw `RestoreFailedException(rolledBack: true)` with a clear message. If the rollback itself fails, say where the safety copy is.
6. On success delete the safety copy and the stage folder, call an `onRestored` callback that **invalidates all Riverpod providers** (customers, loans, EMIs, documents, profile, dashboard stats) or navigates to splash, and show "Restore complete".
7. Never log passwords or decrypted data.

## 9. Database integration
My database helper currently opens one global sqflite database. Add: `close()` (closes and clears the cached instance), `reopen()`, and an exposed `File dbFile` in `getApplicationSupportDirectory()` (file name `loanwise.db`). Make `BackupConfig` take `dbFile`, `dataDirs` (`{'documents': pdfDir, 'photos': photoDir}`), `openDb`, `closeDb`, `reopenDb`, `appVersion`. Make sure the generated PDFs and profile photos are saved inside those two flat folders (change my PDF/photo saving code if needed) so they are part of backups. Provide a `backupServiceProvider` (Riverpod) that builds `BackupService`.

## 10. Screen UI (backup_restore_screen.dart)
Material 3, works in light and dark, `SafeArea`, scrollable, no overflow at 320/360/412 dp and font scale 1.5.
- Card "Last backup" (date/time or "Never").
- Card "Google Drive": Sign in with Google button -> after sign-in shows the account email with Sign out, a **"Back up to Google Drive"** button, and the list of Drive backups (date, size) each with a three-dot menu: **Restore**, **Delete** (confirm). Empty state "No backups on Google Drive yet."
- Card "This device": **Save backup file** and **Restore from file** buttons (accept `.lmbk` only).
- Busy overlay with progress bar and step text; disable buttons while busy.
- Show the "forgotten password cannot be recovered" note.
- Specific, readable error messages for: cancelled sign-in, no internet, 401 expired session, 403 (Drive API not enabled / scope missing), 404 backup missing, wrong password, corrupt file, newer version, rollback result.
- All user-visible text must go through my ARB localization (13 languages); add every new key to all 13 ARB files (real translation for English, Hindi and Tamil; best effort for the others and tell me which need native review). Do not hard-code strings.
- Semantic labels on icon-only buttons, 48 dp touch targets.

## 11. Tests (must pass)
- Crypto: round trip, wrong password, tampered ciphertext, tampered header, non-backup file, new salt/IV each time, header bytes start with `LMBK` and version 1.
- Archive: pack then unpack restores identical bytes; a zip with `../evil.txt` is rejected.
- Service (with `sqflite_common_ffi` in-memory/temp DB and temp folders): create backup -> change data -> restore -> data equals the original; restore with a wrong password leaves current data unchanged; a corrupt backup leaves current data unchanged; a forced failure after the swap triggers a rollback and the original data is back; document paths are rewritten.
- Widget: screen shows the sections, hides the Drive card on desktop, password dialog validates (min 8, confirmation match).

## 12. Deliverables and report
1. All new files in full + exact edits to existing files (database helper, drawer, router, providers, ARB files, PDF/photo save paths, `AndroidManifest.xml` `INTERNET` permission).
2. The pub commands.
3. A short manual-setup checklist for Google Cloud (Drive API, consent screen scope `drive.appdata`, Android OAuth client + SHA-1, test users) and for testing on an Android device or emulator with Google Play services.
4. Real output of `flutter analyze` and `flutter test`.
5. A list of anything not verified (for example Drive upload/download needs a real device and my Google account).
