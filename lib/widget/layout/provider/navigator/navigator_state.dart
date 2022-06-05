import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base/ui_setting.dart';

part 'navigator_state.g.dart';

// class UIDataModel<T extends DataModel<T>> extends DataModel<T> {
//   @override
//   int get id => 0;
// }

@JsonSerializable()
@DataRepository([])
class MenuState extends UIDataModel<MenuState> {
  final bool isClosed;
  final int selectedIndex;

  MenuState({this.isClosed = false, this.selectedIndex = 0});
}

@JsonSerializable()
@DataRepository([])
class RailState extends UIDataModel<RailState> {
  final bool isClosed;
  final bool isVisible;
  final int selectedIndex;

  RailState({
    this.isVisible = true,
    this.isClosed = false,
    this.selectedIndex = 0,
  });
}

enum DrawerPosition { rail, appBar, none }

enum DrawerRole { controlDrawer, controlRail, controlPrimary, controlSecond }

final destinationMap = <int, NavigationRailDestination>{};

@JsonSerializable()
@DataRepository([])
class NavigatorIconState extends UIDataModel<NavigatorIconState> {
  final DrawerPosition position;
  final bool isClosed;
  final List<int> destinationHashCode;
  final DrawerRole drawerRole;

  /// [isClosed] controls the visibility of the drawer.
  NavigatorIconState({
    this.position = DrawerPosition.appBar,
    this.isClosed = true,
    this.destinationHashCode = const [],
    this.drawerRole = DrawerRole.controlDrawer,
  });

  factory NavigatorIconState.mobile() => NavigatorIconState();
  factory NavigatorIconState.tablet() => NavigatorIconState(
        position: DrawerPosition.none,
      );

  /// [isClosed] controls the size of the rail. 72 or 256
  /// And close of PrimaryPanel would control by RailButtons
  factory NavigatorIconState.tabletWithDrawer() => NavigatorIconState(
        position: DrawerPosition.rail,
        drawerRole: DrawerRole.controlRail,
      );
}
