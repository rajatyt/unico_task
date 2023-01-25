import 'package:go_router/go_router.dart';
import 'package:unico_task/consts/route.const.dart';
import 'package:unico_task/screens/home/home.ui.dart';
import 'package:unico_task/utils/go_router.utils.dart';

final homeRoute = GoRoute(
    path: Routes.home,
    name: Routes.home,
    pageBuilder: (context, state) {
      return createRoutePage(state.pageKey, const HomePage());
    });
