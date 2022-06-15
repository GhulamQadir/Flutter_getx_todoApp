// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_getx_todo/pages/auth/signup/sign_up_controller.dart';
import 'package:get/get.dart';

import '../login/login.dart';

class SignUpForm extends StatefulWidget {
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final sign_up_controller = Get.put(SignUpController());
  signUp() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    EasyLoading.show(status: 'loading...');
    sign_up_controller.createUser(
        sign_up_controller.firstNameController.text,
        sign_up_controller.lastNameController.text,
        sign_up_controller.emailController.text,
        sign_up_controller.passwordController.text,
        sign_up_controller.confirmPasswordController.text);
  }

  bool _isHiddenPassword = true;
  togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  bool _isHiddenConfirmPassword = true;
  toggleConfirmPasswordView() {
    setState(() {
      _isHiddenConfirmPassword = !_isHiddenConfirmPassword;
    });
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
                  "Create Account",
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
                  controller: sign_up_controller.firstNameController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    } else if (value.length < 3) {
                      return "Your first name is too short";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "First name",
                    prefixIcon: Icon(
                      Icons.person,
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
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.80,
                child: TextFormField(
                  controller: sign_up_controller.lastNameController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    } else if (value.length < 3) {
                      return "Your last name is too short";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Last name",
                    prefixIcon: Icon(
                      Icons.person,
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
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.80,
                child: TextFormField(
                  controller: sign_up_controller.emailController,
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
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.80,
                child: TextFormField(
                  controller: sign_up_controller.passwordController,
                  obscureText: _isHiddenPassword,
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
                        _isHiddenPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
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
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.80,
                child: TextFormField(
                  controller: sign_up_controller.confirmPasswordController,
                  obscureText: _isHiddenConfirmPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your confirm password";
                    } else if (value.length < 6) {
                      return "Your password is too short";
                    } else if (value !=
                        sign_up_controller.passwordController.text) {
                      return "Password and confirm password should match";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Confirm password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xff092f82),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: toggleConfirmPasswordView,
                      child: Icon(
                        _isHiddenConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
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
                      onPressed: signUp,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Sign Up",
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
                padding: const EdgeInsets.only(top: 16, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                          color: Color(0xff092f82),
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: sign_up_controller.goToLogin,
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
