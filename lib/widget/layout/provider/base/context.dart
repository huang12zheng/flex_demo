import 'package:flex_demo/flex_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

final contextProvider =
    Provider<BuildContext>((_) => throw UnimplementedError());
final mediaStateFamily = Provider.family<MediaQueryData, BuildContext>(
    (ref, ctx) => MediaQuery.of(ctx));
final isPhoneProvider = Provider((ref) {
  final ctx = ref.watch(contextProvider);
  final media = ref.watch(mediaStateFamily(ctx));
  final bool isPhone = media.size.width < AppData.phoneWidthBreakpoint ||
      media.size.height < AppData.phoneHeightBreakpoint;
  return isPhone;
});

const double _kBreakpointShowFullMenu = 900;
final isDesktopProvider = Provider((ref) {
  final ctx = ref.watch(contextProvider);

  final media = ref.watch(mediaStateFamily(ctx));
  final bool isDesktop = media.size.width >= _kBreakpointShowFullMenu;
  // OrientationBuilder

  return isDesktop;
});
final themeFamily =
    Provider.family<ThemeData, BuildContext>((ref, ctx) => Theme.of(ctx));
final themeProvider = Provider((ref) {
  final ctx = ref.watch(contextProvider);
  return Theme.of(ctx);
});
final isDark =
    Provider((ref) => ref.watch(themeProvider).brightness == Brightness.dark);

final colorSchemeProvider =
    Provider((ref) => ref.watch(themeProvider).colorScheme);
final textThemeProvider = Provider((ref) => ref.watch(themeProvider).textTheme);

final railWidthProivder =
    Provider((ref) => ref.watch(isPhoneProvider) ? 52 : 66);

final title = Provider.family<String, Tuple2<String, String>>(
  (ref, args) =>
      ref.watch(isPhoneProvider) ? args.item2 : '${args.item1} - ${args.item2}',
);
