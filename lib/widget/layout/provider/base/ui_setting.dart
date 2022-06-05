import 'dart:math';

import 'package:flex_demo/widget/layout/provider/base/layout_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flex_demo/main.data.dart';
import 'package:responsive_builder/responsive_builder.dart';

part 'ui_setting.g.dart';

class UIDataModel<T extends DataModel<T>> extends DataModel<T> {
  @override
  int get id => 0;
}

@JsonSerializable()
@DataRepository([])
class UISetting extends UIDataModel<UISetting> {
  /// Navigation is [Drawer] or [BottomNavigationBar]
  final bool useIosModeOnMobile;

  /// use menuIcon to toggle size of Rail
  final bool useDrawerOnTablet;

  /// Maximum number of items to display in [bottomNavigationBar]
  final int bottomNavigationOverflow;

  /// Weather the overflow menu defaults to include overflow destinations and
  /// the overflow destinations.
  final bool includeBaseDestinationsInMenu;

  /// Whether the [floatingActionButton] is inside or the rail or in the regular
  /// spot.
  ///
  /// If true, then [floatingActionButtonLocation] and
  /// [floatingActionButtonAnimation] are ignored.
  final bool fabInRail;

  UISetting({
    this.useIosModeOnMobile = false,
    this.useDrawerOnTablet = false,
    this.bottomNavigationOverflow = 5,
    this.includeBaseDestinationsInMenu = true,
    this.fabInRail = true,
  });
}

@JsonSerializable()
@DataRepository([])
class MenuItemState extends UIDataModel<MenuItemState> {
  // final ListTile tile;
  // final
  final NavigationDestionationEnum e;
  final bool isShow;
  final LayoutPosition layoutPosition;

  MenuItemState(this.e, this.isShow, this.layoutPosition);

  NavigationDestination get destination => e.destination;

  ListTile toListTile() {
    return ListTile();
  }

  // ListTile toNavigationDestination() {
  //   return NavigationDestination();
  // }
}

extension ListMenuItemX on List<MenuItemState> {
  Iterable<ListTile> toListTile() {
    return map((e) => e.toListTile());
  }

  Iterable<NavigationDestination> toDestination() {
    return map((e) => e.destination);
  }
}

// @JsonSerializable()
// @DataRepository([])
// class NavigationDestionation extends UIDataModel<NavigationDestionation> {
//   final int moduleId;
//   final IconData icon;

//   final IconData selectedIcon;
//   final String label;
//   final String tooltip;

//   NavigationDestionation(
//       this.moduleId, this.icon, this.selectedIcon, this.label, this.tooltip);
// }

// final navigationDestionationMap = <String, NavigationDestination>{};
h() {}

enum NavigationDestionationEnum {
  home(NavigationDestination(icon: Icon(Icons.home), label: 'home'), h);

  final NavigationDestination destination;
  final VoidCallback onTap;
  const NavigationDestionationEnum(this.destination, this.onTap);
}
// final navigationDestionationMap = <String, NavigationDestionation>{};

// final getMenuModuleProvider = FutureProvider<>((ref) async {

//   return <String,ListTile>{

//   };
// });

final uiSettingsProvider = FutureProvider((ref) async {
  var setting = await ref.uISettings.findOne(0, remote: false);
  if (setting == null) {
    await UISetting().save(remote: false);
  }
});

final bottomDestinationsProvider = Provider((ref) {
  final menuItems = ref.menuItemStates.watchAll().model ?? [];
  return (ref.watch(bottomDestinationsFamily(menuItems)) as List<MenuItemState>)
      .toDestination();
});
final bottomDestinationsFamily =
    Provider.family<List, List>((ref, destinations) {
  // var setting = ref.uISettings.watchOne(0, remote: false).model!;
  final bottomNavigationOverflow = ref.watch(navigationOverflowProvider);
  return destinations.sublist(
      0, min(destinations.length, bottomNavigationOverflow));
});

final drawerDestinationsProvider = Provider((ref) {
  final menuItems = ref.menuItemStates.watchAll().model ?? [];
  return ref.watch(drawerDestinationsFamily(menuItems)) as List<MenuItemState>;
});
final drawerDestinationsFamily =
    Provider.family<List, List>((ref, destinations) {
  final bottomNavigationOverflow = ref.watch(navigationOverflowProvider);
  var setting = ref.uISettings.watchOne(0, remote: false).model!;
  destinations.length > bottomNavigationOverflow
      ? destinations.sublist(setting.includeBaseDestinationsInMenu
          ? 0
          : setting.bottomNavigationOverflow)
      : [];
  return destinations.sublist(
      0, min(destinations.length, bottomNavigationOverflow));
});

final navigationOverflowProvider = Provider((ref) {
  var setting = ref.uISettings.watchOne(0, remote: false).model!;
  return setting.bottomNavigationOverflow;
});

class AdaptiveNavigationScaffold extends StatelessWidget {
  const AdaptiveNavigationScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (ctx) => Container());
  }
}

class AdaptiveMenu extends StatelessWidget {
  const AdaptiveMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
