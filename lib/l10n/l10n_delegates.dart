import 'package:cupertino_ui/cupertino_ui.dart' as cui;
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:material_ui/material_ui.dart' as mui;
import 'package:loan_management_app/l10n/app_localizations.dart';

const List<LocalizationsDelegate<dynamic>> loanWiseLocalizationsDelegates =
    <LocalizationsDelegate<dynamic>>[
  AppLocalizations.delegate,
  mui.GlobalMaterialLocalizations.delegate,
  cui.GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
