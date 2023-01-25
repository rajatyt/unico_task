import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unico_task/models/products.model.dart';
import 'package:unico_task/screens/home/home.state.dart';
import 'package:unico_task/utils/riverpod.utils.dart';
import 'package:http/http.dart' as http;

final homePageNotifierProvider =
    StateNotifierProvider.autoDispose<HomePageNotifier, HomePageState>((ref) {
  return HomePageNotifier(ref, const HomePageState());
});

class HomePageNotifier extends CustomStateNotifier<HomePageState> {
  HomePageNotifier(super.ref, super.state);


  saveUserData(String name) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username",name);
    userInfo();
  }
  userInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username").toString();
    String email = prefs.getString("email").toString();
    String profilePic = prefs.getString("profilePic").toString();
    state = state.copyWith(username:username);
    state = state.copyWith(email:email);
    state = state.copyWith(profilePic:profilePic);
    print(profilePic);
  }
  Future<void> fetchData() async {

    state = state.copyWith(isLoading: true);
    // Fetch Data here
    const url = "https://dummyjson.com/products";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Parse data
      // final data = jsonDecode(response.body);
      final products = productModelFromJson(response.body);
      state = state.copyWith(products: products);
    } else {
      // Show error message
    }

    state = state.copyWith(isLoading: false);
  }

  Future<void> googleSignOut() async {
    await GoogleSignIn().signOut();

  }
}
