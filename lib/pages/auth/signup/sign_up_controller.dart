// ignore_for_file: invalid_return_type_for_catch_error, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_getx_todo/pages/home/home.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  createUser(String firstName, String lastName, String email, String password,
      String confirmPassword) async {
    try {
      Map<String, dynamic> userData = {
        "first name": firstName,
        "last name": lastName,
        "email": email,
      };

      final UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await db.collection("users").doc(user.user!.uid).set(userData);
      firstNameController.clear();
      lastNameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      print("Your registration has been completed !");
      Get.off(Home());
      EasyLoading.showSuccess('Successful');
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.message.toString());
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }
}
