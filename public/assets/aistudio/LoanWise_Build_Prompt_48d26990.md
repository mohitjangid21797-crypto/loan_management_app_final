# MASTER PROMPT: Build the LoanWise Flutter app (stage by stage)

You are a senior Flutter engineer. Build **LoanWise**, an offline-first Flutter app for ONE small private lender per device (customers, loans, EMI schedules, ledger, PDF documents, optional encrypted backup).

The repository already exists (`loan_management_app`, package name `loan_management_app`, branch `main`). `lib/main.dart` is still the default Flutter counter demo, so replace it. Read `Docs/PRD.md`, `Docs/ARCHITECTURE.md`, `Docs/DESIGN.md`, `Docs/MEMORY.md` and `Docs/TASKS.md` first. If anything in this prompt conflicts with those docs, **this prompt wins** (see "Decisions that override the docs").

---

## 0. How to work

1. Work in **stages** (section 12). Finish one stage fully, then stop and report. Do not start the next stage until I say so.
2. Before each stage: list the files you will create or change.
3. After each stage run, and paste the real output of:
   ```
   flutter pub get
   dart run build_runner build --delete-conflicting-outputs
   flutter gen-l10n
   flutter analyze
   flutter test
   ```
   `flutter analyze` must show **0 issues** and all tests must pass. Never claim a build passes if you did not run it. If you cannot run something, say so.
4. I use **Windows + PowerShell + VS Code**. Give commands in PowerShell, never bash.
5. Create a git branch per stage (e.g. `stage-1-foundation`). Small, clear commits.
6. Do not change the package name, database schema versioning approach, or encryption format without asking me.
7. Never put passwords, keystores or `key.properties` in code or git.

---

## 1. Product summary

LoanWise lets a lender:
- Sign in with name, mobile and email (no PIN, see section 2).
- Add customers (the **mobile number is the unique customer ID**).
- Create loans (simple or compound interest) with an automatically generated monthly EMI schedule.
- Mark EMIs paid one by one or all pending at once; when a loan is fully paid, a **Loan Agreement PDF** is generated automatically.
- Manage generated PDFs (view, share, delete, edit and regenerate) in any of **13 languages**.
- Switch light/dark theme and app language, and back up/restore.

Platforms: Android first (iOS later). Offline-first: no network calls except Google sign-in/Drive backup (stage 6).

---

## 2. Decisions that override the docs

| Topic | Decision |
|---|---|
| Login | **Name + mobile (10 digits) + email + "Sign in" button only. No M-PIN, no biometrics, no auto-lock.** Details are saved as the lender profile; on later launches, if a profile exists the app goes straight to the dashboard (user stays signed in). Sign out is in Profile. |
| Interest rate | Entered **per month** (percent per month). Store `monthly_rate_percent` (not annual). |
| Customer ID | The customer's **mobile number** (10 digits, starts with 6 to 9, unique among non-deleted customers). |
| PDF engine | **HTML to PDF** via `Printing.convertHtml` (shapes Indic/Urdu text correctly), for all 13 languages including English, so layout is one code path. |
| PDF page rows | **Page 1: first 60 installments. Every later page: 70 installments.** |
| Edit PDF | Edits change the **document's own snapshot data**, not the original loan, EMI rows or ledger. "Regenerate" replaces the existing PDF file and record. |

Keep all other rules from `Docs/MEMORY.md` section 2 (money in integer paise, dates at UTC midnight, overdue computed never stored, append-only ledger, atomic transactions, ARB localization, no overflow).

---

## 3. Tech stack

Flutter (Dart) with Material 3; `flutter_riverpod` (Notifier / AsyncNotifier / StreamProvider); `go_router`; `drift` + `sqlite3_flutter_libs` (+ `drift_dev`, `build_runner`); `shared_preferences` (theme, language, signed-in flag); `intl` + `flutter_localizations` (gen-l10n); `printing` (+ `pdf` only if needed); `share_plus`; `path_provider`; `image_picker`; `url_launcher`; `uuid`; `equatable`; `logger`; `mocktail` (tests). Stage 6 only: `google_sign_in`, `googleapis`, `encrypt`, `pointycastle`, `crypto`.

Do NOT add: Syncfusion, cached_network_image, any sync engine, analytics, Firebase (only behind `--dart-define=ENABLE_FIREBASE=true`, not now).

Lints: `flutter_lints` + prefer_const_constructors, avoid_print, always_use_package_imports, require_trailing_commas.

---

## 4. Architecture

Clean architecture:
```
lib/
  core/{constants,error,extensions,router,theme,utils}
  data/{local/{database.dart,daos,tables},mappers,repositories}
  domain/{entities,enums,repositories,usecases}
  presentation/{providers,screens,widgets}
  services/   (pdf, backup, share, notifications later)
  l10n/       (ARB files, generated/ never hand-edited)
  app.dart, main.dart
```
- `domain`: pure Dart, no Flutter/Drift imports.
- `data`: Drift, DAOs, mappers, repository implementations; convert exceptions to typed failures.
- `presentation`: screens, widgets, Riverpod providers; read state, call use cases.
- Errors: `Result<T>` (`Success`/`Err`), typed `Failure`s (database, notFound, duplicateMobile, activeLoan, validation, pdf), `ExceptionHandler.guard`. Show specific, localized error messages.
- Navigation only through `redirectFor(status, location)` in `app_router.dart`: unknown -> `/splash`; no profile -> `/login`; profile exists -> `/dashboard`.

---

## 5. Data model (Drift, schemaVersion 1)

Money = integer **paise**. Dates stored at UTC midnight. IDs = uuid strings unless noted.

- `lender_profile`: id (single row), name, mobile, email, photo_path (nullable), created_at, updated_at.
- `customers`: id, name, email, mobile (unique among rows where deleted_at is null), location, created_at, updated_at, deleted_at (soft delete).
- `loans`: id, customer_id (FK), principal_paise, monthly_rate_percent (real, e.g. 2.5), tenure_months, type (`simple`|`compound`), start_date, status (`active`|`completed`), total_payable_paise, total_interest_paise, created_at.
- `emi_schedules`: id, loan_id (FK), installment_no, due_date, emi_paise, principal_part_paise, interest_part_paise, remaining_balance_paise, status (`pending`|`paid`), paid_date (nullable).
- `ledger_entries` (append-only): id, customer_id, loan_id, kind (`disbursement`|`payment`|`adjustment`), debit_paise, credit_paise, balance_after_paise, created_at.
- `documents`: id, loan_id (FK), customer_mobile (grouping key), file_path, language_code, title, snapshot_json (borrower + loan + schedule snapshot used to render the PDF), page_count, created_at, updated_at.

`PRAGMA foreign_keys = ON`. Add indexes on `customers(mobile)`, `loans(customer_id,status)`, `emi_schedules(loan_id,due_date,status)`, `ledger_entries(customer_id,created_at)`, `documents(customer_mobile)`.

### Transactions (each is ONE Drift transaction)
1. **Create loan**: verify customer exists -> insert loan -> insert all EMI rows -> write disbursement ledger entry.
2. **Mark one EMI paid**: reject not found / already paid / out of order (earlier pending installment exists) -> mark paid with date -> credit ledger entry -> if no pending remain set loan `completed`.
3. **Pay all pending**: in one transaction mark every pending EMI paid (same date, in order) -> one credit ledger entry per EMI -> set loan `completed`. After commit, trigger PDF generation (outside the DB transaction; if PDF fails, the payments stay saved and the user sees a "Retry PDF" action).

### Interest formulas (monthly rate)
- `r = monthly_rate_percent / 100`.
- **Simple**: `interest = P * r * n`; `EMI = (P + interest) / n`; interest spread evenly across installments.
- **Compound (reducing balance)**: `EMI = P*r*(1+r)^n / ((1+r)^n - 1)` (if r = 0, `EMI = P/n`); each month `interest = round(balance * r)`, `principalPart = EMI - interest`.
- Round each EMI to the paisa; put the rounding leftover in the **last** installment so the schedule sums exactly to `total_payable_paise`.
- Installment i is due i months after start date, same day of month, clamped to month end (`addMonthsClamped`).
- Ledger: disbursement is a debit of total owed (principal + interest); each payment is a credit; balance is exactly 0 when fully paid.
- Validation: principal > 0, rate 0 to 100 per month, tenure 1 to 600.

---

## 6. Screens and behavior (exactly as specified)

### 6.1 Splash (3D animated)
- Widget `LoanWiseLogoAnimation` built with built-in Flutter only (Transform with perspective, CustomPainter), 3.4 s, then hold ~0.4 s and fade to next screen in 300 ms.
- Logo: navy rounded square, green zig-zag trend arrow rising right, two gold coin stacks, bold green "LW", white wordmark "LoanWise".
- Timeline: tile tilt-in 0.00 to 0.35 (rotateY -0.9 rad, rotateX 0.5 rad to flat, scale 0.6 to 1); arrow draws 0.10 to 0.55; big coins drop and spin 1.5 turns 0.20 to 0.58 (bounceOut); small coins 0.30 to 0.66; "LW" flips up 0.55 to 0.80; wordmark fades/slides 0.75 to 1.00. Then a slow 4 s idle sway.
- Layout fractions of tile size S: big coin stack left 0.43 top 0.19 width 0.22 (3 coins); small stack left 0.29 top 0.33 width 0.17 (2 coins); LW box left 0.28 top 0.56 w 0.46 h 0.17; wordmark top 0.80 size 0.13 S. Arrow points: (0.13,0.69), (0.31,0.47), (0.37,0.53), (0.55,0.35), (0.62,0.43), (0.80,0.18), line width 0.07 S.
- Respect system "remove animations" (show finished logo immediately). `RepaintBoundary`. Semantics label "LoanWise". Navigate only after BOTH the animation and the profile check finish.

### 6.2 Login (3D animated)
- Fields: **Name**, **Mobile number** (10 digits), **Email**. Button **Sign in**.
- 3D feel: card with perspective tilt on entry and a subtle pointer/idle parallax, floating coins, same brand colors. Keep it light (60 fps).
- Inline validation (name required; mobile `^[6-9]\d{9}$`; email format). On success: save lender profile, go to **Dashboard**.
- Scrollable, keyboard never hides fields, `SafeArea`.

### 6.3 Dashboard
- App bar: **three-line (hamburger) icon at top-left** opening the menu (see 6.9); greeting "Good Morning/Afternoon/Evening, <name>".
- Bottom navigation (4 tabs): **Home, Customers, Loans, Profile**. Documents is reachable from a Home card and from the menu/quick actions.
- Home shows: Loan Overview cards (Total Loans amount with active/closed counts, EMI Due this month with pending count, Total Customers, Documents count), quick actions (**Add Customer**, **Create Loan**, **Documents**), Recent Loans (View All), Overdue installments list (tap opens loan overview).
- Stat cards must never overflow at font scale 1.5 (Expanded/Flexible + ellipsis, or Wrap).

### 6.4 A. Add Customer
- Fields: customer name, email, mobile number (this is the unique ID), location.
- Validation incl. duplicate mobile among non-deleted customers (show specific error).
- On save: dialog **"Customer added successfully"** that suggests **Create Loan** (buttons: "Create Loan" navigates to Create Loan with this customer preselected; "Later" closes).
- The same screen is reused for **Edit customer** (mobile editable only if the customer has no loans).

### 6.5 B. Create Loan
- Top: **search bar for customer mobile number**. When 10 digits match an existing customer, **auto-select** that customer and show a small customer card; if not found, show "No customer with this mobile" with an "Add customer" shortcut.
- Loan details: Principal amount, Interest rate **per month** (%), Tenure (months), Type (Simple / Compound), Start date (default today).
- **Live preview** of EMI, total interest and total payable before saving.
- **Create Loan** button: one transaction (section 5). Then dialog **"Loan created successfully"**; all EMIs are generated and listed in the **Loan Overview** screen (navigate there).
- When opened from a customer card's menu, the customer is preselected and the search bar shows their mobile.

### 6.6 C. Loan Overview
- Header summary: customer, principal, rate per month, tenure, type, total interest, total payable, progress bar (paid/total), status chip.
- List of **every EMI** (installment no, due date, amount, status chip Pending/Paid/Overdue + text, never color alone). Each pending EMI has a **Pay** button (confirm dialog + date picker) that marks only that EMI paid (in-order rule).
- A prominent **"Pay all pending EMIs"** button: confirm dialog -> all pending EMIs marked paid at once -> loan completed -> **PDF is generated automatically** and saved to Documents. Show progress while generating, then a snackbar with "View PDF" and "Open Documents". Handle failures with a specific message and Retry.
- The list is lazy (`ListView.builder`); schedules can reach 600 rows.

### 6.7 PDF: "Loan Agreement" (HTML to PDF)
Layout (A4):
1. **Headline: "Loan Agreement"** (translated), generated date/time, document ID.
2. Below it, two columns: **LEFT = Lender details** (name, mobile, email), **RIGHT = Borrower details** (name, mobile, email, location).
3. Loan details table (principal, rate per month, tenure, type, start date, EMI, total interest, total payable, status, loan ID).
4. Heading **"Installment Schedule"**, then the table (installment no, due date, EMI, principal part, interest part, balance, status, paid date).
   - **Page 1: first 60 installments.**
   - **Then remaining installments on the next pages, 70 per page.**
   - Repeat the table header on each page; never split a row; footer with page numbers and signature area on the last page.
5. Enforce pagination **explicitly**: build the HTML as separate fixed `<section class="page">` blocks (page 1 = 60 rows, others = 70 rows) with `page-break-after: always`, rather than trusting automatic breaks. Size rows so 70 rows fit on A4 (compact font, small row height). Verify with a 200-installment sample: expect pages of 60, 70, 70.
6. Indian number format (1,23,456.00), rupee symbol, **full month names in the PDF language**.
7. Fonts: bundle Noto fonts as assets and embed them in the HTML via `@font-face` (base64 or asset URL) so output does not depend on device fonts: Noto Sans (en), Noto Sans Devanagari (hi, mr), Noto Sans Tamil, Telugu, Bengali (bn, as), Gujarati, Kannada, Malayalam, Gurmukhi (pa), Oriya (or), **Noto Naskh Arabic (ur)**. Urdu pages use `dir="rtl"` and right-to-left table column order.
8. Known risks to handle: `convertHtml` can time out and behaves differently per platform. Add a timeout, one retry, and a fallback that renders each page as an image (RepaintBoundary) if HTML conversion fails. Report which path was used.
9. Never use placeholder data ("John Doe"); use the real lender profile and borrower.

### 6.8 D. Documents
- All generated PDFs listed as **cards**. PDFs sharing the same `customer_mobile` are **grouped together** under a group header (customer name + mobile, count).
- Each card: title, loan id, language, date, page count; **three-dots menu at the card's top-right** with exactly four options:
  1. **View PDF** (in-app viewer via `Printing`/preview)
  2. **Share PDF** (`share_plus`, WhatsApp or any app)
  3. **Delete PDF** (confirm; deletes file and record)
  4. **Edit PDF** (navigates to Edit PDF screen)
- Empty state with explanation.

### 6.9 E. Edit PDF
- Editable fields: **borrower details** (name, mobile, email, location) and **loan details** (principal, rate per month, tenure, type, start date, status text). Changes alter only the document snapshot.
- Recompute the EMI schedule in the snapshot when loan details change (same formulas), keeping paid dates for installments that were already paid where installment numbers match.
- **Language selector** with all 13 languages shown in their own script (below).
- Buttons: **Preview** and **Regenerate PDF**. Regenerate **replaces** the current PDF file and updates the same document record (no duplicate), then returns to Documents with a success message.

### 6.10 F. Profile
- Shows lender **name, mobile number, email address** and **edit profile picture** (camera/gallery via `image_picker`, copied into app storage). Save Changes. Statistics (customers, loans, active loans, documents). **Sign out** button (confirm).

### 6.11 G. All Customers
- Cards for every customer (name, mobile, email, location, active loans count). Search by name or mobile (300 ms debounce), newest first.
- Each card has a **three-dots menu** with three options: **Edit customer details**, **Delete customer** (confirm; soft delete; blocked with a clear message if the customer has an active loan), **Create loan** (navigates to Create Loan with this customer auto-selected and ready to fill loan details).
- Tap card -> customer detail (call, SMS, list of loans).
- FAB "+" opens Add Customer.

### 6.12 H. Menu (three-line icon, top-left of Dashboard)
Opens a drawer/menu with exactly three items:
1. **Backup and restore** (stage 6; until then show the screen with a "coming soon" state)
2. **Change theme**: Light / Dark (also System). Applies immediately, persisted.
3. **Choose language**: list all 13 languages (native script names + "System default"). Selecting one converts **every string in the app** immediately (persisted). Names are never translated.

---

## 7. The 13 languages (app UI and PDF)

| # | Language | Code | Script | Font to bundle |
|---|---|---|---|---|
| 1 | English | en | Latin | Noto Sans |
| 2 | हिन्दी (Hindi) | hi | Devanagari | Noto Sans Devanagari |
| 3 | தமிழ் (Tamil) | ta | Tamil | Noto Sans Tamil |
| 4 | తెలుగు (Telugu) | te | Telugu | Noto Sans Telugu |
| 5 | বাংলা (Bengali) | bn | Bengali | Noto Sans Bengali |
| 6 | मराठी (Marathi) | mr | Devanagari | Noto Sans Devanagari |
| 7 | ગુજરાતી (Gujarati) | gu | Gujarati | Noto Sans Gujarati |
| 8 | ಕನ್ನಡ (Kannada) | kn | Kannada | Noto Sans Kannada |
| 9 | മലയാളം (Malayalam) | ml | Malayalam | Noto Sans Malayalam |
| 10 | ਪੰਜਾਬੀ (Punjabi) | pa | Gurmukhi | Noto Sans Gurmukhi |
| 11 | ଓଡ଼ିଆ (Odia) | or | Odia (Oriya) | Noto Sans Oriya |
| 12 | اردو (Urdu, right to left) | ur | Arabic script | Noto Naskh Arabic |
| 13 | অসমীয়া (Assamese) | as | Bengali script | Noto Sans Bengali |

Rules:
- **Every user-visible string** comes from ARB files (`lib/l10n/app_<code>.arb`); zero hard-coded strings. 13 ARB files with identical keys. Provide real translations for en, hi, ta; for the others provide best-effort translations and clearly list which files need native review (do not silently fall back to English without telling me).
- PDF strings (headings, labels, status words, month names) also come from the same translations or a dedicated PDF string set for each language.
- Numbers, dates and money are formatted with `intl`, never stored in translated strings. Urdu uses RTL layout app-wide and in the PDF.
- Add a test that all 13 ARB files have the same keys.
- Assamese uses the Bengali font (with Assamese letters); Marathi uses the Devanagari font.

---

## 8. Design system

- Colors: primary `#1E3A8A`, primaryDeep `#0B1650`, primaryMid `#14246B`, accentGreen `#34D399`, gold `#FFD34E`, danger `#EF4444`, surface `#FFFFFF`, background `#F8FAFC`, textPrimary `#111827`, textMuted `#6B7280`. Dark: surfaces `#0F172A` / `#1E293B`, same accents, contrast >= 4.5:1.
- Typography: Inter (or Noto Sans) for Latin; Noto fonts as fallbacks for other scripts. Scale: display 32 bold (amounts), title 22, section 20, body 16, caption 13.
- Spacing 4/8/12/16/24/32; card radius 20 to 24; buttons radius 16 to 28; touch targets >= 48 dp.
- Status chips: Paid green, Pending grey/blue, Overdue red, Completed grey, Active blue; always with text.
- Components: StatCard, LoanCard, EmiRow, EmptyState, ErrorView (with Retry), confirm dialogs (cancel left, confirm right, destructive in red), specific snackbars.
- Layout rules: every `Text` inside a `Row` is in `Expanded`/`Flexible` with `maxLines` + ellipsis; buttons in rows use `Expanded` or `Wrap`; `SafeArea` everywhere; scrollable forms; no "RIGHT OVERFLOWED" at 320, 360, 393, 412 dp and font scale 1.0, 1.3, 1.5.
- Accessibility: semantic labels on icon-only buttons, honor reduce-motion.

---

## 9. Android and build settings

- Min SDK 24 (Android 7+).
- Keep `applicationId` as is for now but note it must change to `com.mohit.loanwise` before publishing (do not change it without asking).
- Add `android.permission.INTERNET` only if needed (Drive backup in stage 6) and required intents for `url_launcher` (tel, sms) in `<queries>`.
- Remove any Google Services Gradle plugin usage; do not require `google-services.json`.
- Release signing must **fail** if `key.properties` values are missing (no silent fallback to the debug key).

---

## 10. Testing requirements

- Unit: EMI calculator (simple and compound, rate 0, rounding leftover sums exactly, month-end clamping, 600-month schedule), validators (mobile, email, amounts), currency (Indian grouping) and date helpers, repositories with fakes, use cases (create loan, mark paid, pay all, out-of-order rejection, duplicate mobile, delete with active loan).
- Drift: in-memory database tests for the transactions (atomic rollback on failure).
- PDF: pagination test for 200 installments -> pages of 60, 70, 70; 25 installments -> one page; HTML generation contains lender left / borrower right; RTL attribute for Urdu.
- Widget: launch flow (splash -> login -> dashboard; second launch skips login), add customer dialog, create loan auto-select by mobile, overflow checks at 320/360/412 dp with font scale 1.5, language switch changes strings, theme switch.
- Integration (later stage): create customer -> create loan -> pay all -> PDF appears in Documents.

---

## 11. Quality gates (every stage)

- `flutter analyze`: 0 issues. `flutter test`: all green.
- Run `flutter run --release` on a real device when possible and check for jank on splash and login.
- No analytics, no tracking, no network except Google sign-in/Drive (stage 6).
- Report: what was built, files changed, commands run with real output, known gaps, and decisions you had to assume.

---

## 12. Stages (do one at a time)

**Stage 1: Foundation and entry flow**
Dependencies, theme (light/dark), router with `redirectFor`, Drift database + tables + migrations scaffold, core utils (money, dates, validators, EMI calculator), localization scaffold with 13 ARB files (en/hi/ta translated), animated splash, animated login (name, mobile, email) saving the profile, dashboard shell with hamburger menu (theme + language working, backup placeholder), bottom navigation, Profile screen (name, mobile, email, photo, sign out). Tests for utils, login flow, theme and language switching.

**Stage 2: Customers**
Add customer (+ success dialog suggesting Create Loan), All Customers cards with three-dot menu (edit, delete, create loan), search, customer detail.

**Stage 3: Loans and EMIs**
Create Loan (mobile search auto-select, live preview), schedule generation, Loan Overview with per-EMI Pay and "Pay all pending EMIs", ledger writes, dashboard aggregates and overdue list, loans list (Active/Completed).

**Stage 4: PDF and Documents**
HTML-to-PDF Loan Agreement for all 13 languages with the 60/70 pagination, auto-generation after the last EMI, Documents screen grouped by mobile, card menu (View, Share, Delete, Edit), Edit PDF screen with language selector and Regenerate (replace). Image-based fallback.

**Stage 5: Localization completion and polish**
Complete translations/review list, RTL for Urdu everywhere, overflow fixes at all sizes, performance pass (const widgets, `select()` in providers, dispose controllers), accessibility pass.

**Stage 6: Backup and restore**
Encrypted Google Drive backup in `appDataFolder` (scope `drive.appdata`): AES-256-GCM, PBKDF2-HMAC-SHA256 200,000 iterations, file format `LMBK` + version byte + 16-byte salt + 12-byte IV + ciphertext/tag, keep latest 5, restore with atomic swap and rollback, per-step readable errors, warning that a forgotten backup password cannot be recovered. One Google Cloud project for the web and Android clients.

**Stage 7: Release**
Package name change, release signing (fail if missing), app icon/splash, README, CI (analyze + test), Play Store assets.

---

## 13. Start now

Begin with **Stage 1 only**. First reply with: (a) the list of files you will create or change, (b) any assumption you are making, (c) any question that blocks you (ask at most three). Then implement Stage 1, run the quality gates, and report with real command output.
