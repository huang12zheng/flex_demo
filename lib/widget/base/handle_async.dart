import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension HandleAsync<T> on AsyncValue<T> {
  Widget handleAsync(Widget Function(T) builder) => when(
        data: builder,
        error: (err, stack) => Text('Error: $err'),
        loading: () => const CircularProgressIndicator(),
      );
}
