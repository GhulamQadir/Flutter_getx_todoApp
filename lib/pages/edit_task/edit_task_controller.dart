import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditTaskController extends GetxController {
  // final TextEditingController editTitle = TextEditingController();
  // final TextEditingController editDate = TextEditingController();

  editTask(String title, String date, String id) async {
    Map<String, dynamic> updateTask = {"title": title, "date": date};

    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection("users")
        .doc(currentUser)
        .collection("myTodos")
        .doc(id)
        .update(updateTask);
    Get.back();
  }
}
