import 'package:flex_demo/widget/layout/provider/base/media_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flex_demo/main.data.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'ui_setting.dart';

/// [UISetting.useIosModeOnMobile]
/// [UISetting.useDrawerOnTablet]
final useMenuIconProvider = Provider.family<bool, BuildContext>((ref, arg) {
  final setting = ref.uISettings.watch(UISetting());
  final dev = ref.watch(deviceTypeProivder(arg));
  if (dev == DeviceScreenType.mobile && !setting.useIosModeOnMobile) {
    return true;
  }

  if (dev == DeviceScreenType.desktop && setting.useDrawerOnTablet) {
    return true;
  }
  return false;
});
