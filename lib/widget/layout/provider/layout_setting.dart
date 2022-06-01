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
