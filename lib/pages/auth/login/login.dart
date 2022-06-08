// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/pages/auth/login/login_form.dart';
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
        appBar: AppBar(
          title: Text("Login screen"),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 150,
                  width: 200,
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.purple[500],
                    size: 150,
                  ),
                ),
              ),
              loginForm()
            ]))));
  }
}
