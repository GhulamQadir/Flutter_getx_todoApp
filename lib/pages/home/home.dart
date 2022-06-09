// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
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
    bool isChecked = false;

  logOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();
    setState(() {});
    print("user diconnected");
    Get.off(SignUp());
  }

  final firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;
  Stream<QuerySnapshot>? cartStream;

  @override
  void initState() {
    cartStream = db
        .collection("users")
        .doc(firebaseUser!.uid)
        .collection("myTodos")
        .snapshots();
    super.initState();
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
                  icon: Icon(Icons.add)),
            ],
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: cartStream,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
          
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("waiting");
                }
                if (snapshot.data == null) {
                  return CircularProgressIndicator();
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Container(
                      child: Text(
                        "No items added yet",
                        style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }
          
                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    String id = document.id;
                    data["id"] = id;
                    return ListTile(
                      title: Text(data['title']),
                      subtitle: Text(data['date']),
                      leading: Checkbox(
      onChanged: (bool value) {
        widget.isChecked = value;
        setState(() {
          widget.isChecked = value;
        });
      },
      value: widget.isChecked,
    );,
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
