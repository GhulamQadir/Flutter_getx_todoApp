// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, sized_box_for_whitespace
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/pages/add_task/add_task_form.dart';
import 'package:flutter_getx_todo/pages/auth/signup/sign_up.dart';
import 'package:flutter_getx_todo/pages/edit_task/edit_task_form.dart';
import 'package:flutter_getx_todo/pages/home/home_controller.dart';
import 'package:flutter_getx_todo/pages/profile/user_profile.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController searchController = TextEditingController();
  String searchTitle = "";

  final homeController = Get.put(HomeController());

  bool value = false;

  final firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;
  Stream<QuerySnapshot>? cartStream;

  addTask() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
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
  }

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
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextFormField(
              onChanged: (val) {
                setState(() {
                  searchTitle = val;
                });
              },
              style: TextStyle(color: Colors.white),
              controller: searchController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Search Task",
                labelStyle: TextStyle(color: Colors.white),
                suffixIcon: Icon(Icons.search, color: Colors.white),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.lightBlue[600],
        actions: [
          // Padding(
          //     padding: const EdgeInsets.only(top: 5),
          //     child: IconButton(
          //         onPressed: () {
          //           Get.to(UserProfileScreen());
          //         },
          //         icon: Icon(Icons.person))),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 5),
            child: IconButton(
                onPressed: homeController.logOut, icon: Icon(Icons.logout)),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: homeController.deleteAllTodos,
            backgroundColor: Colors.white,
            label: Text(
              'Clear all',
              style: TextStyle(color: Color(0xff092f82)),
            ),
            icon: Icon(Icons.clear_rounded, color: Color(0xff092f82)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: FloatingActionButton(
              onPressed: addTask,
              child: Icon(
                Icons.add,
                color: Color(0xff092f82),
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Drawer(),
      ),
      backgroundColor: Colors.lightBlue[600],
      body: Column(
        children: [
          FutureBuilder(
              future: homeController.currentUserProfile(),
              builder: (context, snapshot) {
                return Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 16, bottom: 13, left: 18),
                      child: Text(
                        "What's up, ${homeController.firstName} ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            fontWeight: FontWeight.w600),
                      ),
                    ));
              }),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: (searchTitle == "" || searchTitle.trim() == '')
                  ? cartStream
                  : db
                      .collection("users")
                      .doc(firebaseUser!.uid)
                      .collection("myTodos")
                      .where("title", isGreaterThanOrEqualTo: searchTitle)
                      .where("title",
                          isLessThanOrEqualTo: "${searchTitle}\uf7ff")
                      .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.data == null) {
                  return CircularProgressIndicator();
                }
                if (snapshot.data!.docs.isEmpty) {
                  return searchTitle.length == 0
                      ? Center(
                          child: Container(
                            child: Text(
                              "No tasks added yet",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      : Center(
                          child: Container(
                            child: Text(
                              "No matches found",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        );
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    String id = document.id;
                    data["id"] = id;

                    var title = data["title"];
                    var date = data["date"];
                    var checkBoxVal = data["is Checked"] == true;

                    editTask() {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.70,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    EditTaskForm(
                                      data: data,
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }

                    var todos = db
                        .collection("users")
                        .doc(firebaseUser!.uid)
                        .collection("myTodos");

                    deleteTask() {
                      homeController.deleteTodo(id);
                    }

                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 13),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff092f82),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: ListTile(
                          title: Text(data['title'],
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Color(0xffe6e6e8),
                                  decoration: data['is Checked'] == true
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none)),
                          subtitle: Text(
                            data['date'],
                            style: TextStyle(
                              color: Color(0xffe6e6e8),
                            ),
                          ),
                          leading: Checkbox(
                              value: data['is Checked'],
                              shape: CircleBorder(),
                              side: BorderSide(color: Colors.white),
                              checkColor: Colors.white,
                              activeColor: Colors.lightBlue[700],
                              splashRadius: 40,
                              onChanged: (value) {
                                setState(() {
                                  this.value = value!;
                                });

                                db
                                    .collection("users")
                                    .doc(firebaseUser!.uid)
                                    .collection("myTodos")
                                    .doc(id)
                                    .update({"is Checked": value});
                                print(value);
                              }),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                onPressed: checkBoxVal ? null : editTask,
                                icon: Icon(
                                  Icons.edit,
                                  color: checkBoxVal
                                      ? Colors.grey
                                      : Color(0xffe6e6e8),
                                ),
                              ),
                              IconButton(
                                  onPressed: deleteTask,
                                  icon: Icon(
                                    Icons.delete,
                                    color: Color(0xffe6e6e8),
                                  ))
                            ],
                          ),
                        ),
                      ),
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
