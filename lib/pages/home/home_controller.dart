import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_getx_todo/pages/auth/login/login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeController extends GetxController {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;

  deleteTodo(String id) async {
    try {
      await db
          .collection("users")
          .doc(firebaseUser!.uid)
          .collection("myTodos")
          .doc(id)
          .delete();
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  deleteAllTodos() {
    try {
      db
          .collection("users")
          .doc(firebaseUser!.uid)
          .collection("myTodos")
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  logOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn();

    await auth.signOut();
    googleSignIn.disconnect();

    print("user diconnected");
    Get.off(LoginScreen());
  }

  String? firstName;

  currentUserProfile() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        firstName = ds.data()!['first name'];
      }).catchError((e) {
        print(e);
      });
    }
  }
}
