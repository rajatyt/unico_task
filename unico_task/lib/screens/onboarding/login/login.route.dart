import 'package:go_router/go_router.dart';
import 'package:unico_task/consts/route.const.dart';
import 'package:unico_task/screens/onboarding/login/login.ui.dart';
import 'package:unico_task/utils/go_router.utils.dart';

final loginRoute = GoRoute(
    path: Routes.login,
    name: Routes.login,
    pageBuilder: (context, state) {
      return createRoutePage(state.pageKey, const LoginUser());
    });
