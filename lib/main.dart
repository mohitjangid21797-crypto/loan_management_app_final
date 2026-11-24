import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:loan_management_app/app.dart';
import 'package:loan_management_app/data/db/app_database.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:loan_management_app/app.dart' show LoanWiseApp;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppDatabase? appDatabase;
  if (!kIsWeb) {
    AppDatabase.initializeFfiIfNeeded();
    appDatabase = await AppDatabase.openDefault();
  }
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    LoanWiseApp(
      appDatabase: appDatabase,
      sharedPreferences: sharedPreferences,
    ),
  );
}
