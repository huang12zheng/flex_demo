import 'package:flex_demo/main.data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'layout_setting.dart';

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

final bodyProvider = Provider.family<Widget, BuildContext>(
    (ref, arg) => throw UnimplementedError());

final layoutProvider = Provider.family<Widget, BuildContext>((ref, ctx) {
  final model = ref.layoutSettings.watch(LayoutSetting());
  final wrap = ref.watch(layoutWarpProvider);
  Widget body = ref.watch(bodyProvider(ctx));
  List<Widget> widgets = <Widget>[];

  if (model.panelAlignment == PanelAlignment.center) {
    body = Column(
      children: [
        body,
        wrap.panel(ctx),
      ],
    );
    widgets = [wrap.activity(ctx), wrap.primary(ctx), body, wrap.second(ctx)];
    if (model.primaryPosition == PrimaryPosition.right) {
      widgets = widgets.reversed.toList();
    }
    return Row(children: widgets);
  }

  if (model.panelAlignment == PanelAlignment.justify) {
    widgets = [wrap.primary(ctx), body, wrap.second(ctx)];
    if (model.primaryPosition == PrimaryPosition.right) {
      widgets = widgets.reversed.toList();
    }
    widgets = [
      wrap.activity(ctx),
      Column(
        children: [
          Row(children: widgets),
          wrap.panel(ctx),
        ],
      )
    ];
    if (model.primaryPosition == PrimaryPosition.right) {
      widgets = widgets.reversed.toList();
    }
    return Row(children: widgets);
  }

  if (model.panelAlignment == PanelAlignment.left) {
    if (model.primaryPosition == PrimaryPosition.left) {
      return Row(children: [
        wrap.activity(ctx),
        Column(
          children: [
            Row(children: [
              wrap.primary(ctx),
              body,
            ]),
            wrap.panel(ctx),
          ],
        ),
        wrap.second(ctx),
      ]);
    } else {
      return Row(children: [
        Column(
          children: [
            Row(children: [
              wrap.second(ctx),
              body,
            ]),
            wrap.panel(ctx),
          ],
        ),
        wrap.primary(ctx),
        wrap.activity(ctx),
      ]);
    }
  }

  if (model.panelAlignment == PanelAlignment.right) {
    if (model.primaryPosition == PrimaryPosition.left) {
      return Row(children: [
        wrap.activity(ctx),
        wrap.primary(ctx),
        Column(
          children: [
            Row(children: [
              body,
              wrap.second(ctx),
            ]),
            wrap.panel(ctx),
          ],
        ),
      ]);
    } else {
      return Row(children: [
        wrap.second(ctx),
        Column(
          children: [
            Row(children: [
              body,
              wrap.primary(ctx),
            ]),
            wrap.panel(ctx),
          ],
        ),
        wrap.activity(ctx),
      ]);
    }
  }
  throw 'There is wrong enum state!';
});
