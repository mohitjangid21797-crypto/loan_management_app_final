import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:loan_management_app/core/constants/app_constants.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AppDatabase {
  AppDatabase._(this._db);

  final Database _db;
  static bool _ffiInitialized = false;

  Database get database => _db;

  static void initializeFfiIfNeeded() {
    if (_ffiInitialized || kIsWeb) return;
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    _ffiInitialized = true;
  }

  static Future<AppDatabase> openDefault() async {
    if (kIsWeb) {
      throw UnsupportedError('SQLite openDefault is not supported on web.');
    }
    initializeFfiIfNeeded();
    final supportDir = await getApplicationSupportDirectory();
    if (!supportDir.existsSync()) {
      await supportDir.create(recursive: true);
    }
    final dbPath = p.join(supportDir.path, AppConstants.databaseFileName);
    return openAtPath(dbPath);
  }

  static Future<AppDatabase> openAtPath(
    String dbPath, {
    bool noIsolate = false,
  }) async {
    initializeFfiIfNeeded();
    final factory = noIsolate ? databaseFactoryFfiNoIsolate : databaseFactory;
    final db = await factory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: AppConstants.databaseVersion,
        onConfigure: _onConfigure,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      ),
    );
    return AppDatabase._(db);
  }

  static Future<AppDatabase> openInMemory() async {
    sqfliteFfiInit();
    final db = await databaseFactoryFfiNoIsolate.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: AppConstants.databaseVersion,
        onConfigure: _onConfigure,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      ),
    );
    return AppDatabase._(db);
  }

  static Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON;');
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        mobile TEXT NOT NULL UNIQUE,
        email TEXT NOT NULL,
        photo_path TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE customers(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        mobile TEXT NOT NULL,
        location TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        deleted_at TEXT
      );
    ''');

    await db.execute('''
      CREATE UNIQUE INDEX ux_customers_mobile
      ON customers(mobile)
      WHERE deleted_at IS NULL;
    ''');

    await db.execute('''
      CREATE TABLE loans(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer_id INTEGER NOT NULL REFERENCES customers(id),
        principal_paise INTEGER NOT NULL,
        monthly_rate_percent REAL NOT NULL,
        tenure_months INTEGER NOT NULL,
        type TEXT NOT NULL,
        start_date TEXT NOT NULL,
        status TEXT NOT NULL,
        total_payable_paise INTEGER NOT NULL,
        total_interest_paise INTEGER NOT NULL,
        monthly_emi_paise INTEGER NOT NULL,
        created_at TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE INDEX ix_loans_customer_status
      ON loans(customer_id, status);
    ''');

    await db.execute('''
      CREATE TABLE emis(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        loan_id INTEGER NOT NULL REFERENCES loans(id),
        installment_no INTEGER NOT NULL,
        due_date TEXT NOT NULL,
        emi_paise INTEGER NOT NULL,
        principal_part_paise INTEGER NOT NULL,
        interest_part_paise INTEGER NOT NULL,
        remaining_balance_paise INTEGER NOT NULL,
        status TEXT NOT NULL,
        paid_date TEXT
      );
    ''');

    await db.execute('''
      CREATE INDEX ix_emis_loan_due_status
      ON emis(loan_id, due_date, status);
    ''');

    await db.execute('''
      CREATE TABLE ledger(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer_id INTEGER NOT NULL REFERENCES customers(id),
        loan_id INTEGER NOT NULL REFERENCES loans(id),
        kind TEXT NOT NULL,
        debit_paise INTEGER NOT NULL,
        credit_paise INTEGER NOT NULL,
        balance_after_paise INTEGER NOT NULL,
        created_at TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE INDEX ix_ledger_customer_created
      ON ledger(customer_id, created_at);
    ''');

    await db.execute('''
      CREATE TABLE documents(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        loan_id INTEGER NOT NULL REFERENCES loans(id),
        customer_mobile TEXT NOT NULL,
        file_path TEXT NOT NULL,
        language_code TEXT NOT NULL,
        title TEXT NOT NULL,
        snapshot_json TEXT NOT NULL,
        page_count INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        emi_installment_no INTEGER,
        render_path TEXT NOT NULL DEFAULT '',
        html_content TEXT NOT NULL DEFAULT ''
      );
    ''');

    await db.execute('''
      CREATE INDEX ix_documents_customer_mobile
      ON documents(customer_mobile);
    ''');
  }

  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE documents ADD COLUMN emi_installment_no INTEGER;',
      );
      await db.execute(
        "ALTER TABLE documents ADD COLUMN render_path TEXT NOT NULL DEFAULT '';",
      );
      await db.execute(
        "ALTER TABLE documents ADD COLUMN html_content TEXT NOT NULL DEFAULT '';",
      );
    }
  }

  Future<void> close() async {
    await _db.close();
  }
}
