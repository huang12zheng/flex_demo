import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flex_demo/shared/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 修改状态栏
extension AnnotatedRegionX on Widget {
  toAnnotatedRegion(BuildContext context, ThemeController controller) =>
      AnnotatedRegion<SystemUiOverlayStyle>(
          value: FlexColorScheme.themedSystemNavigationBar(
            context,
            systemNavBarStyle: controller.sysNavBarStyle,
            useDivider: controller.useSysNavDivider,
            opacity: controller.sysNavBarOpacity,
          ),
          child: this);
}
