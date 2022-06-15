// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/pages/auth/forgot_password/forgot_password_form.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
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
          top: MediaQuery.of(context).size.height * 0.17,
          child: ForgotPasswordForm()),
    ])));
  }
}
