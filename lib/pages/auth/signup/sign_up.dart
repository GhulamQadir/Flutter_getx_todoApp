// ignore_for_file: prefer_const_constructors, nullable_type_in_catch_clause, empty_catches

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_getx_todo/pages/auth/login/login.dart';
import 'package:flutter_getx_todo/pages/auth/signup/sign_up_controller.dart';
import 'package:flutter_getx_todo/pages/auth/signup/sign_up_form.dart';
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
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff092f82),
      ),
      Positioned(
          top: MediaQuery.of(context).size.height * 0.07,
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
          top: MediaQuery.of(context).size.height * 0.23, child: SignUpForm()),
    ])));
  }
}
