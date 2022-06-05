import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

enum DeviceAndOrintation {
  watchPortrait,
  // watchLandscape,
  mobilePortrait,
  mobileLandscape,
  tablePortrait,
  tableLandscape,
  // desktopPortrait,
  desktopLandscape,
}

/// used by [orientationBinaryProvider] to determine [DeviceAndOrintation]
class OrientationBinary {
  final Orientation o;
  final bool isPortrait;

  OrientationBinary(this.o, this.isPortrait);
}

final deviceTypeProivder = Provider.family<DeviceScreenType, BuildContext>(
  (ref, arg) => getDeviceType(MediaQuery.of(arg).size),
);

// final OrintationProvider =
//     Provider.family<Orientation, BuildContext>((ref, ctx) {
//   return MediaQuery.of(ctx).orientation;
// });
final orientationBinaryProvider =
    Provider.family<OrientationBinary, BuildContext>((ref, ctx) {
  final orientation = MediaQuery.of(ctx).orientation;
  return OrientationBinary(orientation, orientation == Orientation.portrait);
});

final deviceAndOrintationProvider =
    Provider.family<DeviceAndOrintation, BuildContext>((ref, ctx) {
  final binaryModel = ref.watch(orientationBinaryProvider(ctx));
  return getValueForScreenType(
      context: ctx,
      mobile: binaryModel.isPortrait
          ? DeviceAndOrintation.mobilePortrait
          : DeviceAndOrintation.mobileLandscape,
      tablet: binaryModel.isPortrait
          ? DeviceAndOrintation.tablePortrait
          : DeviceAndOrintation.tableLandscape,
      desktop:
          // binaryModel.isPortrait
          // ? DeviceAndOrintation.desktopPortrait :
          DeviceAndOrintation.desktopLandscape,
      watch:
          // binaryModel.isPortrait ?
          DeviceAndOrintation.watchPortrait
      // : DeviceAndOrintation.watchLandscape,
      );
});

/// Will return one of the values passed in for
/// the device and orintation it's running on
T getValueForDeviceAndOrintation<T>({
  required DeviceAndOrintation e,
  required T mobilePortrait,
  T? mobileLandscape,
  T? tabletPortrait,
  T? tabletLandscape,
  // T? desktopPortrait,
  T? desktopLandscape,
  T? watchPortrait,
}) {
  switch (e) {
    case DeviceAndOrintation.mobilePortrait:
      return mobilePortrait;
    case DeviceAndOrintation.mobileLandscape:
      return mobileLandscape ?? mobilePortrait;
    case DeviceAndOrintation.tablePortrait:
      return tabletPortrait ?? mobilePortrait;
    case DeviceAndOrintation.tableLandscape:
      return tabletLandscape ?? mobileLandscape ?? mobilePortrait;
    // case DeviceAndOrintation.desktopPortrait:
    // return desktopPortrait ?? tabletPortrait ?? mobilePortrait;
    case DeviceAndOrintation.desktopLandscape:
      return desktopLandscape ?? tabletLandscape ?? mobilePortrait;
    case DeviceAndOrintation.watchPortrait:
      return watchPortrait ?? mobilePortrait;
    // case DeviceAndOrintation.watchLandscape:
    //   return watchLandscape ?? mobilePortrait;
  }
}
