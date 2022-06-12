// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/pages/auth/login/login_form.dart';
import 'package:flutter_getx_todo/pages/auth/signup/sign_up.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Login screen"),
        // ),
        body: SafeArea(
            child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff092f82),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.25,
              right: MediaQuery.of(context).size.width * 0.25,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 17,
                    child: Icon(
                      Icons.check,
                      color: Color(0xffDAA520),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Todo List",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffDAA520)),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
          // SizedBox(
          //   height: 20,
          // ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.23,
              child: LoginForm()),
          // ElevatedButton(
          //     onPressed: () {
          //       Get.to(SignUp());
          //     },
          //     child: Text("go to signup"))
        ])));
  }
}
