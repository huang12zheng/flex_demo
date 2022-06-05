<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Color Scheme source from [flex_color_scheme](https://github.com/rydmike/flex_color_scheme)'s example5.


## Features

* [ThemeController](https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/shared/controllers/theme_controller.dart)
* Database
  * [ThemeModeAdapter](https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/shared/services/theme_service_hive_adapters.dart)
  > 
  * [ThemeServiceHive](https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/shared/services/theme_service_hive.dart)
  > registerHiveAdapters,load(key,default),
* const
  * [Store](https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/shared/const/store.dart)
  > storage theme's props as keys and default value
  * [AppData](https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/shared/const/app_data.dart)
  > responsive breakpoints,responsiveInsets,visualDensity,TextTheme
  * [AppColor](https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/shared/const/app_color.dart)
* [widget panel view](https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/example5/widgets/pages/panel_view.dart)
* [Responsive]
  * getValueForDeviceAndOrintation and DeviceAndOrintation
  * getValueForScreenType
## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
