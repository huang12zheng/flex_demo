import 'package:flex_demo/widget/layout/provider/base/ui_setting.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';

import '../navigator/navigator_state.dart';

part 'layout_setting.g.dart';

enum LayoutPosition { activity, second, panel }

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
class LayoutSetting extends UIDataModel<LayoutSetting> {
  final ActivityVisibility activityVisibility;
  final PrimaryVisibility primaryVisibility;
  final SecondVisibility secondVisibility;
  final PanelVisibility panelVisibility;
  final PrimaryPosition primaryPosition;
  final PanelAlignment panelAlignment;

  final bool isShowMenuIconOnRail;

  LayoutSetting(
      {this.activityVisibility = ActivityVisibility.visible,
      this.primaryVisibility = PrimaryVisibility.visible,
      this.secondVisibility = SecondVisibility.hidden,
      this.panelVisibility = PanelVisibility.hidden,
      this.primaryPosition = PrimaryPosition.left,
      this.panelAlignment = PanelAlignment.center,
      this.isShowMenuIconOnRail = false});

  factory LayoutSetting.mobile() {
    return LayoutSetting(
      activityVisibility: ActivityVisibility.hidden,
      primaryVisibility: PrimaryVisibility.hidden,
      secondVisibility: SecondVisibility.hidden,
      panelVisibility: PanelVisibility.hidden,
      primaryPosition: PrimaryPosition.left,
      panelAlignment: PanelAlignment.center,
    );
  }

  factory LayoutSetting.tablet() {
    return LayoutSetting(
      activityVisibility: ActivityVisibility.visible,
      primaryVisibility: PrimaryVisibility.hidden,
      secondVisibility: SecondVisibility.hidden,
      panelVisibility: PanelVisibility.hidden,
      primaryPosition: PrimaryPosition.left,
      panelAlignment: PanelAlignment.center,
    );
  }

  factory LayoutSetting.windowTablet() {
    return LayoutSetting(
      activityVisibility: ActivityVisibility.visible,
      primaryVisibility: PrimaryVisibility.hidden,
      secondVisibility: SecondVisibility.hidden,
      panelVisibility: PanelVisibility.hidden,
      primaryPosition: PrimaryPosition.right,
      panelAlignment: PanelAlignment.center,
    );
  }

  factory LayoutSetting.desktop() {
    return LayoutSetting(
      activityVisibility: ActivityVisibility.visible,
      primaryVisibility: PrimaryVisibility.visible,
      secondVisibility: SecondVisibility.hidden,
      panelVisibility: PanelVisibility.hidden,
      primaryPosition: PrimaryPosition.left,
      panelAlignment: PanelAlignment.center,
    );
  }

  factory LayoutSetting.windowDesktop() {
    return LayoutSetting(
      activityVisibility: ActivityVisibility.visible,
      primaryVisibility: PrimaryVisibility.visible,
      secondVisibility: SecondVisibility.hidden,
      panelVisibility: PanelVisibility.hidden,
      primaryPosition: PrimaryPosition.right,
      panelAlignment: PanelAlignment.center,
    );
  }

  @override
  int get id => 0;
}

class NavigationState {
  final NavigationDestionationEnum? activitySelected;
  final NavigationDestionationEnum? secondSelected;
  final NavigationDestionationEnum? panelSelected;

  final List<NavigationDestionationEnum> activities;
  final List<NavigationDestionationEnum> seconds;
  final List<NavigationDestionationEnum> panels;

  NavigationState({
    this.activities = const [NavigationDestionationEnum.home],
    this.seconds = const [],
    this.panels = const [],
    this.activitySelected = NavigationDestionationEnum.home,
    this.secondSelected,
    this.panelSelected,
  });

  int get activitySelectedIndex =>
      activitySelected == null ? -1 : activities.indexOf(activitySelected!);
  int get secondSelectedIndex =>
      secondSelected == null ? -1 : seconds.indexOf(secondSelected!);
  int get panelSelectedIndex =>
      panelSelected == null ? -1 : panels.indexOf(panelSelected!);
}

final navigationStateProvider = StateProvider<NavigationState>((ref) {
  return NavigationState();
});
