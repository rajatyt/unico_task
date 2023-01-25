import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unico_task/consts/route.const.dart';
import 'package:unico_task/screens/home/home.route.dart';
import 'package:unico_task/screens/onboarding/login/login.route.dart';
import 'package:unico_task/screens/onboarding/signup/signup.route.dart';

final routerProvider = Provider((ref) => GoRouter(
    debugLogDiagnostics: true,
    initialLocation: Routes.login,
    routes: [loginRoute, signUpRoute, homeRoute]));

Page createRoutePage(
  ValueKey<String> key,
  Widget child, {
  bool opaque = true,
}) {
  return CustomTransitionPage(
    opaque: opaque,
    child: child,
    restorationId: key.value,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

// final contextProvider =
//     Provider((ref) => ref.watch(routerProvider).);
