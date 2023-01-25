
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unico_task/consts/route.const.dart';
import 'package:unico_task/screens/onboarding/login/login.state.dart';
import 'package:unico_task/utils/riverpod.utils.dart';

final loginPageNotifierProvider =
    StateNotifierProvider.autoDispose<LoginPageNotifier, LoginPageState>((ref) {
  return LoginPageNotifier(ref, const LoginPageState());
});

class LoginPageNotifier extends CustomStateNotifier<LoginPageState> {
  LoginPageNotifier(super.ref, super.state);

  var googleAccount = GoogleSignInAccount;

  GoogleSignInAccount? user;

  Future<void> googleSignIn() async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    state = state.copyWith(isLoading: true);
    try {
      // Google sign in logic here
      var response = await GoogleSignIn().signIn();
      if (response?.id != null) {
        prefs.setString("username", response!.displayName.toString());
        prefs.setString("email", response!.email.toString());
        prefs.setString("id", response!.id.toString());
        prefs.setString("profilePic", response!.photoUrl.toString());
        router.goNamed(Routes.home);
      } else {
        // Show error message
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      // Show e excepion
      state = state.copyWith(isLoading: false);
    }
  }
}
