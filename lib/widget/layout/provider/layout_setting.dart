import 'package:flex_demo/main.data.dart';
import 'package:flex_demo/widget/layout/provider/layout_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'layout_setting.g.dart';

enum ActivityVisibility {
  visible,
  hidden,
}

enum PrimaryVisibility {
  visible,
  hidden,
}

enum SecondVisibility {
  visible,
  hidden,
}

enum PanelVisibility {
  visible,
  hidden,
}

enum PrimaryPosition {
  left,
  right,
}

enum PanelAlignment { left, right, center, justify }

@JsonSerializable()
@DataRepository([])
class LayoutSetting extends DataModel<LayoutSetting> {
  final ActivityVisibility activityVisibility;
  final PrimaryVisibility primaryVisibility;
  final SecondVisibility secondVisibility;
  final PanelVisibility panelVisibility;
  final PrimaryPosition primaryPosition;
  final PanelAlignment panelAlignment;

  LayoutSetting({
    this.activityVisibility = ActivityVisibility.visible,
    this.primaryVisibility = PrimaryVisibility.visible,
    this.secondVisibility = SecondVisibility.hidden,
    this.panelVisibility = PanelVisibility.hidden,
    this.primaryPosition = PrimaryPosition.left,
    this.panelAlignment = PanelAlignment.center,
  });

  @override
  int get id => 0;
}

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
