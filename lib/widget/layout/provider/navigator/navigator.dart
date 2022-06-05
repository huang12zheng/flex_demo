import 'package:flex_demo/main.data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'navigator_state.dart';

class MenuIconWidget extends ConsumerWidget {
  const MenuIconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.navigatorIconStates.watch(NavigatorIconState());
    if (model.position == DrawerPosition.none) {
      return const SizedBox.shrink();
    } else if (model.position == DrawerPosition.appBar) {
      return IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          ref.navigatorIconStates.save(NavigatorIconState(
            position: DrawerPosition.appBar,
            isClosed: !model.isClosed,
            destinationHashCode: model.destinationHashCode,
            drawerRole: DrawerRole.controlDrawer,
          ));
        },
      );
    }
    return Drawer();
  }
}
