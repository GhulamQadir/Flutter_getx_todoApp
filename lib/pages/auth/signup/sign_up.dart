// ignore_for_file: prefer_const_constructors, nullable_type_in_catch_clause, empty_catches

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_getx_todo/pages/auth/signup/sign_up_controller.dart';
import 'package:flutter_getx_todo/pages/home/home.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final TextEditingController firstName = TextEditingController();
    final TextEditingController lastName = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    final TextEditingController confirmPassword = TextEditingController();

    final sign_up_controller = Get.put(SignUpController());

    signUp() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      EasyLoading.show(status: 'loading...');
      sign_up_controller.createUser(firstName.text, lastName.text, email.text,
          password.text, confirmPassword.text);
    }

    return Scaffold(
      appBar: AppBar(title: Text("Sign up screen")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextFormField(
                  controller: firstName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    } else if (value.length < 3) {
                      return "Your first name is too short";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "First Name",
                    prefixIcon: Icon(
                      Icons.person,
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
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextFormField(
                  controller: lastName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    } else if (value.length < 3) {
                      return "Your last name is too short";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Last Name",
                    prefixIcon: Icon(
                      Icons.person,
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
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextFormField(
                  controller: email,
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
                      Icons.person,
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
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextFormField(
                  controller: password,
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
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: TextFormField(
                  controller: confirmPassword,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your confirm password";
                    } else if (value.length < 6) {
                      return "Your password is too short";
                    } else if (value != password.text) {
                      return "Your password and confirmation password are not same";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
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
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 150,
                  child: TextButton(
                      onPressed: signUp,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "SignUp",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.purple[500]!),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          )))),
            ],
          ),
        ),
      ),
    );
  }
}
