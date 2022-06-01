import 'package:flex_demo/shared/controllers/theme_controller.dart';
import 'package:flutter/material.dart';

Key getKey(ThemeController controller) => Key('${controller.schemeIndex}'
    '${controller.useFlexColorScheme}'
    '${controller.useSubThemes}');

Widget _themeSwitchBuilder(ThemeController controller, Widget child) =>
    // Whenever the theme controller notifies the animation listener in the
    // AnimatedBuilder, the MaterialApp is rebuilt.
    AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            child: child,
          );
        });

extension SwitcherBuilder on Widget {
  toThemeSwitchBuilder(ThemeController controller) =>
      _themeSwitchBuilder(controller, this);
}
