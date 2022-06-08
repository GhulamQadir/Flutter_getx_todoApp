import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_getx_todo/pages/auth/signup/sign_up_controller.dart';
import 'package:get/get.dart';

import '../login/login.dart';

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

Widget signUpForm() {
  return Form(
    key: _formKey,
    child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
          child: TextFormField(
            controller: sign_up_controller.firstNameController,
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
            controller: sign_up_controller.lastNameController,
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
            controller: sign_up_controller.passwordController,
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
            controller: sign_up_controller.confirmPasswordController,
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your confirm password";
              } else if (value.length < 6) {
                return "Your password is too short";
              } else if (value != sign_up_controller.passwordController.text) {
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple[500]!),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    )))),
        ElevatedButton(
            onPressed: () {
              Get.to(LoginScreen());
            },
            child: Text("go to login"))
      ],
    ),
  );
}
