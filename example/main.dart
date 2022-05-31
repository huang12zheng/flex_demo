import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flex_demo/flex_theme_controller.dart';

// You can try this app as a web app from:
// https://rydmike.com/flexcolorscheme/themesplayground-v5
// -----------------------------------------------------------------------------

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RendererBinding.instance.setSemanticsEnabled(true);
  window.onSemanticsEnabledChanged = () {};
  RendererBinding.instance.setSemanticsEnabled(true);

  // The ThemeServiceHive constructor requires a box name, the others do not.
  // The box name is just a file name for the file that stores the settings.
  final ThemeService themeService = ThemeServiceHive('flex_color_scheme');
  // Initialize the theme service.
  await themeService.init();
  // Create a ThemeController that uses the ThemeService.
  final ThemeController themeController = ThemeController(themeService);
  // Load preferred theme settings, while the app is loading, before MaterialApp
  // is created, this prevents a theme change when the app is first displayed.
  await themeController.loadAll();
  // Run the app and pass in the ThemeController. The app listens to the
  // ThemeController for changes. The same ThemeController as used in example 4
  // controls all the myriad of Theme settings and the ThemeService also
  // persists the settings with the injected ThemeServiceHive.
  runApp(DemoApp(controller: themeController));
}

class DemoApp extends StatelessWidget {
  const DemoApp({Key? key, required this.controller}) : super(key: key);
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    // Whenever the theme controller notifies the animation listener in the
    // AnimatedBuilder, the MaterialApp is rebuilt.
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            // showSemanticsDebugger: true,
            debugShowCheckedModeBanner: false,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch
                }),
            title: 'Themes Playground',
            // The Theme controller controls if we use FlexColorScheme made
            // ThemeData or standard SDK ThemeData.from a ColorScheme. It also
            // controls all the configuration parameters used to define the
            // FlexColorScheme object that produces the ThemeData object.
            theme: controller.useFlexColorScheme
                ? flexThemeLight(controller)
                : themeDataFromLight(controller),
            darkTheme: controller.useFlexColorScheme
                ? flexThemeDark(controller)
                : themeDataFromDark(controller),
            // Use the dark or light theme based on controller setting.
            themeMode: controller.themeMode,
            // Pass the controller to the HomePage where we use it to change
            // the theme settings that will cause themes above to change and
            // rebuild the entire look of the app based on modified theme.
            home: HomePage(controller: controller),
          );
        });
  }
}
