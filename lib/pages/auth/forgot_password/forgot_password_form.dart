// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_getx_todo/pages/auth/forgot_password/forgot_pass_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final forgotPasswordCont = Get.put(ForgotPasswordController());

  forgotPassword() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    EasyLoading.show(status: 'loading...');
    forgotPasswordCont.resetEmail(emailController.text);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.73,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(24),
            bottomLeft: Radius.circular(20),
          )),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 9),
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Center(
                child: Container(
                    child: Lottie.asset("images/forgot_password.json",
                        repeat: false)),
              ),
              Container(
                child: Text(
                  "Enter your email below to\n reset password",
                  style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.80,
                child: TextFormField(
                  controller: emailController,
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
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextButton(
                      onPressed: forgotPassword,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Reset email",
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
                padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Note: ",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Text(
                        "Check spam or junk if you didn't\n receive an email",
                        overflow: TextOverflow.ellipsis,
                        // maxLines: 1,
                      )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
