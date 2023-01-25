import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unico_task/utils/go_router.utils.dart';

class CustomStateNotifier<T> extends StateNotifier<T> {
  final Ref ref;

  GoRouter get router => ref.read(routerProvider);
  BuildContext get context {
    final context = ref.read(contextProvider);

    if (context != null) {
      return context;
    }

    throw Exception('No context found');
  }

  CustomStateNotifier(this.ref, T state) : super(state);
}

final contextProvider = Provider<BuildContext?>((ref) {
  final context = ref
      .watch(routerProvider)
      .routerDelegate
      .navigatorKey
      .currentState
      ?.context;

  return context;
});
