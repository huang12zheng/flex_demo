import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget defaultWidgetBuilder(BuildContext ctx) => const SizedBox();

class LayoutWarp {
  final WidgetBuilder activity;
  final WidgetBuilder primary;
  final WidgetBuilder second;
  final WidgetBuilder panel;

  LayoutWarp({
    this.activity = defaultWidgetBuilder,
    this.primary = defaultWidgetBuilder,
    this.second = defaultWidgetBuilder,
    this.panel = defaultWidgetBuilder,
  });
}

final layoutWarpProvider = Provider<LayoutWarp>((ref) {
  return LayoutWarp();
});
