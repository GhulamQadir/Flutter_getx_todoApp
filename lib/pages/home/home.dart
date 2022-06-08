import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      ),
      body: Column(
        children: [ElevatedButton(onPressed: logOut, child: Text("data"))],
      ),
    );
  }
}
