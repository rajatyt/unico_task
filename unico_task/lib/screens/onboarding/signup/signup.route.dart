import 'package:go_router/go_router.dart';
import 'package:unico_task/consts/route.const.dart';
import 'package:unico_task/screens/onboarding/signup/signup.ui.dart';
import 'package:unico_task/utils/go_router.utils.dart';

final signUpRoute = GoRoute(
    path: Routes.signUp,
    name: Routes.signUp,
    pageBuilder: (context, state) {
      return createRoutePage(state.pageKey, const SignupUser());
    });
