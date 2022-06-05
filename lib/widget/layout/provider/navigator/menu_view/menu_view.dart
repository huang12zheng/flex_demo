// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flex_demo/widget/layout/provider/base/layout_setting.dart';
import 'package:flex_demo/widget/layout/provider/base/ui_setting.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flex_demo/main.data.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final drawerHeaderProvider = Provider<Widget?>((ref) => null);

extension ScaffoldX on Scaffold {
  void destinationTapped(MenuItemState item) {
    item.e.onTap();
  }

  /// count of drawer is controlled by [navigationOverflowProvider]
  Widget buildDrawer() {
    // if (destinations.isEmpty) return null;
    return Consumer(
      builder: (context, ref, _) {
        final drawerHeader = ref.watch(drawerHeaderProvider);
        // final destinationTiles =
        //     ref.menuItemStates.watchAll().model!;
        final drawerDestinations = ref.watch(drawerDestinationsProvider);
        return Drawer(
          child: ListView(
            children: [
              if (drawerHeader != null) drawerHeader,
              // ...destinationTiles.toListTile(),
              // ...drawerDestinations.toListTile(),
              for (final destination in drawerDestinations)
                ListTile(
                  leading: destination.destination.icon,
                  title: Text(destination.destination.label),
                  selected: destinations.indexOf(destination) == selectedIndex,
                  onTap: () => _destinationTapped(destination),
                ),
            ],
          ),
        );
      },
    );
  }

  // getBottomDestinationItems(WidgetRef ref)=> ref
  //           .watch(bottomDestinationsFamily(getMenuItems(ref))) as List<MenuItemState>;
  // getMenuItems(WidgetRef ref) => ref.menuItemStates.watchAll().model!;

  buildBottomNavigationScaffold() {
    Consumer(
      builder: (context, ref, child) {
        final menuItems = ref.menuItemStates.watchAll().model!;
        final bottomDestinationItems = ref
            .watch(bottomDestinationsFamily(menuItems)) as List<MenuItemState>;
        return Scaffold(
          body: body,
          appBar: appBar,
          drawer: buildDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              for (final destination in bottomDestinationItems.toDestination())
                BottomNavigationBarItem(
                  icon: destination.icon,
                  label: destination.label,
                ),
            ],
            // currentIndex: bottomDestinationItems.indexOf(element),
            onTap: (idx) => bottomDestinationItems.elementAt(idx).e.onTap(),
            type: BottomNavigationBarType.fixed,
          ),
          floatingActionButton: floatingActionButton,
        );
      },
    );
  }

  Widget buildNavigationRailScaffold() {
    const int railDestinationsOverflow = 7;
    return ProviderScope(
        overrides: [
          navigationOverflowProvider.overrideWithValue(railDestinationsOverflow)
        ],
        child: Consumer(builder: (context, ref, child) {
          final setting = ref.uISettings.watchOne(0).model!;
          final menuItems = ref.menuItemStates.watchAll().model!;
          final railDestinationItems =
              ref.watch(bottomDestinationsFamily(menuItems))
                  as List<MenuItemState>;
          final selectIndex = ref.watch(navigationStateProvider);
          return Scaffold(
            key: key,
            appBar: appBar,
            drawer: buildDrawer(),
            body: Row(
              children: [
                NavigationRail(
                  leading: setting.fabInRail ? floatingActionButton : null,
                  destinations: [
                    for (final destination
                        in railDestinationItems.toDestination())
                      NavigationRailDestination(
                        icon: destination.icon,
                        label: Text(destination.label),
                      ),
                  ],
                  selectedIndex: selectIndex.activitySelectedIndex <
                          railDestinationsOverflow
                      ? null
                      : selectIndex.activitySelectedIndex,
                  onDestinationSelected: (idx) =>
                      railDestinationItems[idx].e.onTap,
                ),
                const VerticalDivider(
                    // width: 1,
                    // thickness: 1,
                    ),
                if (body != null)
                  Expanded(
                    child: body!,
                  ),
              ],
            ),
            floatingActionButton:
                setting.fabInRail ? null : floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            floatingActionButtonAnimator: floatingActionButtonAnimator,
            persistentFooterButtons: persistentFooterButtons,
            endDrawer: endDrawer,
            bottomSheet: bottomSheet,
            backgroundColor: backgroundColor,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            primary: true,
            drawerDragStartBehavior: drawerDragStartBehavior,
            extendBody: extendBody,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            drawerScrimColor: drawerScrimColor,
            drawerEdgeDragWidth: drawerEdgeDragWidth,
            drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
            endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
          );
        }));
  }

  Widget buildNavigationDrawerScaffold() {
    return Scaffold(
      key: key,
      body: body,
      appBar: appBar,
      drawer: Drawer(child: buildDrawer()),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      endDrawer: endDrawer,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: true,
      drawerDragStartBehavior: drawerDragStartBehavior,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
    );
  }

  Widget buildPermanentDrawerScaffold() {
    return Row(
      children: [
        buildDrawer(),
        const VerticalDivider(
          width: 1,
          thickness: 1,
        ),
        Expanded(
          child: Scaffold(
            key: key,
            appBar: appBar,
            body: body,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            floatingActionButtonAnimator: floatingActionButtonAnimator,
            persistentFooterButtons: persistentFooterButtons,
            endDrawer: endDrawer,
            bottomSheet: bottomSheet,
            backgroundColor: backgroundColor,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            primary: true,
            drawerDragStartBehavior: drawerDragStartBehavior,
            extendBody: extendBody,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            drawerScrimColor: drawerScrimColor,
            drawerEdgeDragWidth: drawerEdgeDragWidth,
            drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
            endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
          ),
        ),
      ],
    );
  }
}

// // The navigation mechanism to configure the [Scaffold] with.
// enum NavigationType {
//   // Used to configure a [Scaffold] with a [BottomNavigationBar].
//   bottom,

//   // Used to configure a [Scaffold] with a [NavigationRail].
//   rail,

//   // Used to configure a [Scaffold] with a modal [Drawer].
//   drawer,

//   // Used to configure a [Scaffold] with an always open [Drawer].
//   permanentDrawer,
// }

