// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/pages/add_task/add_task_form.dart';
import 'package:flutter_getx_todo/pages/auth/signup/sign_up.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  logOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();
    setState(() {});
    print("user diconnected");
    Get.off(SignUp());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home screen"),
        backgroundColor: Color.fromARGB(255, 135, 188, 212),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Daily Task",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        builder: (context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.70,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [AddTaskForm()],
                              ),
                            ),
                          );
                        });
                  },
                  icon: Icon(Icons.add))
            ],
          ),
        ],
      ),
    );
  }
}
