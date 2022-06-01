import 'dart:ui';

import 'package:flex_demo/flex_widget.dart';
import 'package:flex_demo/shared/controllers/controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flex_demo/flex_theme_controller.dart';

// You can try this app as a web app from:
// https://rydmike.com/flexcolorscheme/themesplayground-v5
// -----------------------------------------------------------------------------

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  window.onSemanticsEnabledChanged = () {};
  RendererBinding.instance.setSemanticsEnabled(true);

  // Run the app and pass in the ThemeController. The app listens to the
  // ThemeController for changes. The same ThemeController as used in example 4
  // controls all the myriad of Theme settings and the ThemeService also
  // persists the settings with the injected ThemeServiceHive.
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeControllerProvider(
      (controller) => MaterialApp(
        key: Key(
          '${controller.schemeIndex}'
          '${controller.useFlexColorScheme}'
          '${controller.useSubThemes}',
        ),
        // showSemanticsDebugger: true,
        debugShowCheckedModeBanner: false,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
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
        home: const HomePage(),
      ).toThemeSwitchBuilder(controller),
    );
  }
}
