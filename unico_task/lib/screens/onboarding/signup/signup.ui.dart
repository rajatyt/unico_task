import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:unico_task/consts/color.const.dart';

class SignupUser extends StatefulWidget {
  const SignupUser({Key? key}) : super(key: key);

  @override
  State<SignupUser> createState() => _SignupUserState();
}

class _SignupUserState extends State<SignupUser> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passController = TextEditingController();

  final phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        children: const [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Welcome To Register Page!",
                              style: TextStyle(
                                  color: AppColors.activeButtonColor,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Create your new account now",
                              style: TextStyle(
                                color: AppColors.subTitleColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          enabled: false,
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: AppColors.textfieldbgColor,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Full Name",
                            hintStyle:
                                const TextStyle(color: AppColors.subTitleColor),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Field is empty!"),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          enabled: false,
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
                            hintStyle:
                                const TextStyle(color: AppColors.subTitleColor),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Field is empty!"),
                            EmailValidator(
                                errorText: "Please enter valid email address"),
                          ]),
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
                            hintStyle:
                                const TextStyle(color: AppColors.subTitleColor),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Field is empty!"),
                            MinLengthValidator(6,
                                errorText:
                                    "Password length should be atleast of 6 characters!"),
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
                        onPressed: () {},
                        child: const Text(
                          "Signup",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: AppColors.activeButtonColor,
                              ),
                            ),
                          ),
                        ],
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
