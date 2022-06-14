import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  resetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      print(email);
      print("Password reset email sent");
      EasyLoading.showSuccess('Successful');
      Get.back();
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.message.toString());
    }
  }
}
