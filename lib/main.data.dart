

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: directives_ordering, top_level_function_literal_block

import 'package:flutter_data/flutter_data.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flex_demo/widget/layout/provider/base/layout_setting.dart';
import 'package:flex_demo/widget/layout/provider/base/ui_setting.dart';
import 'package:flex_demo/widget/layout/provider/navigator/navigator_state.dart';

// ignore: prefer_function_declarations_over_variables
ConfigureRepositoryLocalStorage configureRepositoryLocalStorage = ({FutureFn<String>? baseDirFn, List<int>? encryptionKey, bool? clear}) {
  if (!kIsWeb) {
    baseDirFn ??= () => getApplicationDocumentsDirectory().then((dir) => dir.path);
  } else {
    baseDirFn ??= () => '';
  }
  
  return hiveLocalStorageProvider
    .overrideWithProvider(Provider((ref) => HiveLocalStorage(
            hive: ref.read(hiveProvider),
            baseDirFn: baseDirFn,
            encryptionKey: encryptionKey,
            clear: clear,
          )));
};

final repositoryProviders = <String, Provider<Repository<DataModel>>>{
  'layoutSettings': layoutSettingsRepositoryProvider,
'menuItemStates': menuItemStatesRepositoryProvider,
'menuStates': menuStatesRepositoryProvider,
'navigatorIconStates': navigatorIconStatesRepositoryProvider,
'railStates': railStatesRepositoryProvider,
'uISettings': uISettingsRepositoryProvider
};

final repositoryInitializerProvider =
  FutureProvider<RepositoryInitializer>((ref) async {
    final adapters = <String, RemoteAdapter>{'layoutSettings': ref.watch(internalLayoutSettingsRemoteAdapterProvider), 'menuItemStates': ref.watch(internalMenuItemStatesRemoteAdapterProvider), 'menuStates': ref.watch(internalMenuStatesRemoteAdapterProvider), 'navigatorIconStates': ref.watch(internalNavigatorIconStatesRemoteAdapterProvider), 'railStates': ref.watch(internalRailStatesRemoteAdapterProvider), 'uISettings': ref.watch(internalUISettingsRemoteAdapterProvider)};
    final remotes = <String, bool>{'layoutSettings': true, 'menuItemStates': true, 'menuStates': true, 'navigatorIconStates': true, 'railStates': true, 'uISettings': true};

    await ref.watch(graphNotifierProvider).initialize();

    // initialize and register
    for (final type in repositoryProviders.keys) {
      final repository = ref.read(repositoryProviders[type]!);
      repository.dispose();
      await repository.initialize(
        remote: remotes[type],
        adapters: adapters,
      );
      internalRepositories[type] = repository;
    }

    // deferred model initialization
    for (final repository in internalRepositories.values) {
      await repository.remoteAdapter.internalInitializeModels();
    }

    ref.onDispose(() {
      for (final repository in internalRepositories.values) {
        repository.dispose();
      }
    });

    return RepositoryInitializer();
});
extension RepositoryWidgetRefX on WidgetRef {
  Repository<LayoutSetting> get layoutSettings => watch(layoutSettingsRepositoryProvider)..remoteAdapter.internalWatch = watch;
  Repository<MenuItemState> get menuItemStates => watch(menuItemStatesRepositoryProvider)..remoteAdapter.internalWatch = watch;
  Repository<MenuState> get menuStates => watch(menuStatesRepositoryProvider)..remoteAdapter.internalWatch = watch;
  Repository<NavigatorIconState> get navigatorIconStates => watch(navigatorIconStatesRepositoryProvider)..remoteAdapter.internalWatch = watch;
  Repository<RailState> get railStates => watch(railStatesRepositoryProvider)..remoteAdapter.internalWatch = watch;
  Repository<UISetting> get uISettings => watch(uISettingsRepositoryProvider)..remoteAdapter.internalWatch = watch;
}

extension RepositoryRefX on Ref {

  Repository<LayoutSetting> get layoutSettings => watch(layoutSettingsRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
  Repository<MenuItemState> get menuItemStates => watch(menuItemStatesRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
  Repository<MenuState> get menuStates => watch(menuStatesRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
  Repository<NavigatorIconState> get navigatorIconStates => watch(navigatorIconStatesRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
  Repository<RailState> get railStates => watch(railStatesRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
  Repository<UISetting> get uISettings => watch(uISettingsRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
}