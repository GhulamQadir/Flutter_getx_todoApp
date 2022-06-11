// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_getx_todo/pages/auth/login/login_controller.dart';
import 'package:get/get.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

final loginController = Get.put(LoginController());

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  loginUser() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    EasyLoading.show(status: 'loading...');
    loginController.login(loginController.emailController.text,
        loginController.passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.66,
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
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.85,
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
                        color: Colors.purple[500],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextFormField(
                    controller: loginController.passwordController,
                    obscureText: true,
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
                        color: Colors.purple[500],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                    width: 150,
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
                                Colors.purple[500]!),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            )))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text("Or"),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: loginController.loginWithGoogle,
                child: CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.transparent,
                  child:
                      Image.network("https://freesvg.org/img/1534129544.png"),
                ),
              )
            ])),
      ),
    );
  }
}
