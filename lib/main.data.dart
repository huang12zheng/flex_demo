// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: directives_ordering, top_level_function_literal_block

import 'package:flutter_data/flutter_data.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flex_demo/widget/layout/provider/layout_setting.dart';

// ignore: prefer_function_declarations_over_variables
ConfigureRepositoryLocalStorage configureRepositoryLocalStorage =
    ({FutureFn<String>? baseDirFn, List<int>? encryptionKey, bool? clear}) {
  if (!kIsWeb) {
    baseDirFn ??=
        () => getApplicationDocumentsDirectory().then((dir) => dir.path);
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
  'layoutSettings': layoutSettingsRepositoryProvider
};

final repositoryInitializerProvider =
    FutureProvider<RepositoryInitializer>((ref) async {
  final adapters = <String, RemoteAdapter>{
    'layoutSettings': ref.watch(internalLayoutSettingsRemoteAdapterProvider)
  };
  final remotes = <String, bool>{'layoutSettings': true};

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
  Repository<LayoutSetting> get layoutSettings =>
      watch(layoutSettingsRepositoryProvider)
        ..remoteAdapter.internalWatch = watch;
}

extension RepositoryRefX on Ref {
  Repository<LayoutSetting> get layoutSettings =>
      watch(layoutSettingsRepositoryProvider)
        ..remoteAdapter.internalWatch = watch as Watcher;
}
