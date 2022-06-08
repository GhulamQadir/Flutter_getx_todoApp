import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_getx_todo/pages/home/home.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  login(String email, String password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      final UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.to(Home());
      EasyLoading.showSuccess('Successful');
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.message.toString());
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }
}
