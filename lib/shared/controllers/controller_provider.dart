import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_demo/flex_theme_controller.dart';

final themeControllerProvider = FutureProvider((ref) async {
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
  return themeController;
});

class ThemeControllerProvider extends ConsumerWidget {
  final Widget Function(ThemeController controller) builder;

  const ThemeControllerProvider(this.builder, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(themeControllerProvider);
    return controller.when(
      data: builder,
      error: (err, stack) => Text('Error: $err'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
