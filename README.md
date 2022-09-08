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
  > **ThemeService get themeService => _themeService;**
  `getController()`
* Database
  * [ThemeModeAdapter](https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/shared/services/theme_service_hive_adapters.dart)
  > 
  * [ThemeServiceHive](https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/shared/services/theme_service_hive.dart)
  > registerHiveAdapters,load(key,default),
  **replace _hiveBox to hiveBox**
  and
  **extension EnDe on ThemeServiceHive {**
* const
  * [Store](https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/shared/const/store.dart)
  > storage theme's props as keys and default value
  
  >> replace to simple prop with ctrl+F
  ```
  //.*
  .* String.*
  .* int.*
  .* bool.*
  .* double.*
  \n\s*\n\s* \n

  default.*
  '.*

  // use python set.add('prop')
  ```
  * [AppData](https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/shared/const/app_data.dart)
  > responsive breakpoints,responsiveInsets,visualDensity,TextTheme
  * [AppColor](https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/shared/const/app_color.dart)
* [widget panel view](https://github.com/rydmike/flex_color_scheme/blob/master/example/lib/example5/widgets/pages/panel_view.dart)
<!-- * [Responsive]
  * getValueForDeviceAndOrintation and DeviceAndOrintation
  * getValueForScreenType -->
* DemoApp
* ShowWidget,ShowController
## Getting started


## Usage


```dart
class Test extends StatelessWidget {
  Test({Key? key, required this.themeController}) : super(key: key);

  final ThemeController themeController;

  final ShowController showController = ShowController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: AnimatedBuilder(
            animation: showController,
            builder: (context, child) {
              if (showController.value == false) {
                debugPrint('Before change or Change');
                debugPrint(themeController.getJson);
                return TextButton(
                  onPressed: () => showController.toggle(),
                  child: const Text('nav'),
                );
              } else {
                return DemoApp(
                    controller: themeController,
                    showController: showController);
              }
          ),
        ),
      ),
    );
  }
}
// backup
encodeWithController(themeController); // return se about ThemeController
// or
// themeController.getJson
// recover
// themeController.setHive(String input)
await themeController.setHive(themeController.getJson);
<!-- await themeController.loadAll(); -->
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
