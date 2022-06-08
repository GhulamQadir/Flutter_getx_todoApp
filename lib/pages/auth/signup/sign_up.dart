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
        appBar: AppBar(title: Text("Sign up screen")),
        body: SingleChildScrollView(
          child: Column(
            children: [signUpForm()],
          ),
        ));
  }
}
