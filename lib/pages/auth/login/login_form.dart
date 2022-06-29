// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_getx_todo/pages/auth/forgot_password/forgot_password.dart';
import 'package:flutter_getx_todo/pages/auth/login/login_controller.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final loginController = Get.put(LoginController());
  loginUser() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // loginController.loading.isTrue;
    // EasyLoading.show(status: 'loading...');
    loginController.login(loginController.emailController.text,
        loginController.passwordController.text);
  }

  bool _isHidden = true;
  togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  forgotPassword() {
    Get.to(ForgotPassword());
    // showModalBottomSheet(
    //     context: context,
    //     isScrollControlled: true,
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    //     builder: (context) {
    //       return Container(
    //         height: MediaQuery.of(context).size.height * 0.45,
    //         child: SingleChildScrollView(
    //           child: Column(
    //             children: [ForgotPassword()],
    //           ),
    //         ),
    //       );
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.73,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(20))),
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 9),
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.04,
                      fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.80,
                child: TextFormField(
                  controller: loginController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isNotEmpty && value.length > 7) {
                      return null;
                    } else if (value.length < 7 && value.isNotEmpty) {
                      return "Your email address is too short";
                    } else {
                      return "Please enter your email address";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xff092f82),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.80,
                child: TextFormField(
                  controller: loginController.passwordController,
                  obscureText: _isHidden,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 6) {
                      return "Your password is too short";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xff092f82),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: togglePasswordView,
                      child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                        color: Color(0xff092f82),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextButton(
                      onPressed: loginUser,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff092f82)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          )))),
              Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 14),
                child: GestureDetector(
                  onTap: forgotPassword,
                  child: Text(
                    "forgot password?",
                    style: TextStyle(
                        color: Color(0xff092f82), fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextButton(
                      onPressed: loginController.goToSignUp,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "Sign up",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xffF3F3F3)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          )))),
              Padding(
                padding: const EdgeInsets.only(top: 13, bottom: 13),
                child: Text(
                  "Or",
                  style: TextStyle(
                      color: Color(0xff092f82), fontWeight: FontWeight.w500),
                ),
              ),
              GestureDetector(
                onTap: loginController.loginWithGoogle,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xff092f82),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                          "https://freesvg.org/img/1534129544.png"),
                    ),
                  ),
                ),
              )
            ])),
      ),
    );
  }
}
