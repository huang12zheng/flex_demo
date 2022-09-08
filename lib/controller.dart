import 'dart:convert';

import 'package:flutter/material.dart';

import '../shared/controllers/theme_controller.dart';
import '../shared/services/theme_service.dart';
import '../shared/services/theme_service_hive.dart';
import 'enum_convert.dart';
export '../shared/services/theme_service_hive.dart' show ThemeServiceHive;

Future<ThemeController> getController() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Use a ThemeController, which glues our theme settings to Flutter Widgets.
  // The controller uses an abstract ThemeService interface to get and save the
  // settings. There are 3 implementations available to choose from:
  //
  // 0. ThemeService      - Abstract interface base class.
  // 1. ThemeServiceMem   - Only keeps settings in memory.
  // 2. ThemeServicePrefs - Persist settings locally using SharedPreferences.
  // 3. ThemeServiceHive  - Persist settings locally using Hive.
  //
  // Here we use Hive. The examples are all built using same
  // "example" app. If we use SharedPreferences in more than one of the apps
  // they would use the same storage container and share the settings when you
  // build them locally. By using Hive for most examples, we can change
  // the storage container name for each example. In these demos the
  // SharedPreferences service is only used for example 3, but you can swap in
  // the Hive based one for it as well.

  // The ThemeServiceHive constructor requires a box name, the others do not.
  // The box name is just a file name for the file that stores the settings.
  final ThemeService themeService =
      ThemeServiceHive('flex_color_scheme_v5_box_5');
  // Initialize the theme service.
  await themeService.init();
  // Create a ThemeController that uses the ThemeService.
  final ThemeController themeController = ThemeController(themeService);
  // Load preferred theme settings, while the app is loading, before MaterialApp
  // is created, this prevents a theme change when the app is first displayed.
  await themeController.loadAll();

  return themeController;
}

extension ThemeServiceX on ThemeController {
  String get getJson => encodeWithController(this);
  Future<void> setHive(String input) async {
    final converter = getConverter();
    await (themeService as ThemeServiceHive)
        .hiveBox
        .putAll(converter.decode(input));
  }
}

String encodeWithController(ThemeController themeController) {
  final converter = getConverter();
  final obj =
      (themeController.themeService as ThemeServiceHive).hiveBox.toMap();
  final str = converter.encode(obj);
  return str;
}
