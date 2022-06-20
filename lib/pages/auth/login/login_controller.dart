import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_getx_todo/pages/auth/signup/sign_up.dart';
import 'package:flutter_getx_todo/pages/home/home.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // bool loading = false.obs;

  login(String email, String password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      final UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      emailController.clear();
      passwordController.clear();
      Get.off(Home());

      EasyLoading.showSuccess('Successful');
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.message.toString());
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();
  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var signCre =
          await FirebaseAuth.instance.signInWithCredential(credential);

      String? fullName = googleUser.displayName;

      var names = fullName!.split(' ');
      var firstName = names[0];
      var lastName = fullName.replaceAll(firstName, "");

      db
          .collection('users')
          .where('email', isEqualTo: signCre.user!.email)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          db.collection("users").doc(signCre.user!.uid).set({
            "first name": firstName,
            "last name": lastName,
            "email": googleUser.email,
            "image": googleUser.photoUrl
          });
        }
      });
      EasyLoading.showSuccess('Successful');

      Get.off(Home());
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  goToSignUp() {
    Get.to(SignUp());
  }
}


 class LoadingVariable extends GetxController{
    
  }