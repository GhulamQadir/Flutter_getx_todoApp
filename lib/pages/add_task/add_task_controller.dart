import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  addTask(String title, String date) {
    try {
      Map<String, dynamic> addTodo = {"title": title, "date": date};
      db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("myTodos")
          .add(addTodo);
    } catch (e) {
      print(e.toString());
    }
  }
}
