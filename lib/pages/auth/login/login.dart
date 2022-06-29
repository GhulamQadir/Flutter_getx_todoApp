// ignore_for_file: prefer_const_constructors, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/pages/add_task/loading_screen.dart';
import 'package:flutter_getx_todo/pages/auth/login/login_form.dart';
import 'package:flutter_getx_todo/pages/auth/signup/sign_up.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return loginController.loading.isTrue
        ? LoadingScreen()
        : Scaffold(
            body: SafeArea(
                child: Stack(children: [
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
            Positioned(
                top: MediaQuery.of(context).size.height * 0.23,
                child: LoginForm()),
          ])));
  }
}
