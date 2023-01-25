import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unico_task/consts/color.const.dart';
import 'package:unico_task/consts/route.const.dart';
import 'package:unico_task/screens/onboarding/login/login.notifier.dart';

class LoginUser extends StatefulHookConsumerWidget {
  const LoginUser({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginUserState();
}

class _LoginUserState extends ConsumerState<LoginUser> {
  final emailController = TextEditingController();

  final passController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoad = false;


  @override
  Widget build(BuildContext context) {
    final googleState = ref.watch(loginPageNotifierProvider);
    final notifier = ref.watch(loginPageNotifierProvider.notifier);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.themeColor,
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/login_client.png",
                        fit: BoxFit.fill,
                        height: 250,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                fillColor: AppColors.textfieldbgColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Email",
                                hintStyle: const TextStyle(
                                    color: AppColors.subTitleColor),
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Field is empty!"),
                                EmailValidator(
                                    errorText:
                                        "Please enter valid email address"),
                              ]),
                              enabled: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              enabled: false,
                              controller: passController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                fillColor: AppColors.textfieldbgColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                    color: AppColors.subTitleColor),
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Field is empty!"),
                              ]),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: AppColors.activeButtonColor,
                              minimumSize: const Size.fromHeight(50),
                            ),
                            onPressed: () {
                              context.goNamed(Routes.home);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? "),
                              InkWell(
                                onTap: () {
                                  context.pushNamed(Routes.signUp);
                                },
                                child: const Text(
                                  "Signup",
                                  style: TextStyle(
                                    color: AppColors.activeButtonColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.red,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          notifier.googleSignIn();

                        },
                        child: googleState.isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Google SignUp",
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.indigo,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                        },
                        child:  const Text(
                          "Facebook SignUp",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isLoad,
          child: Container(
            alignment: Alignment.center,
            color: Colors.white70,
            child: const CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
