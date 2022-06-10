// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_getx_todo/pages/profile/user_profile_controller.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final loginController = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("My Profile")),
        body: FutureBuilder(
            future: loginController.currentUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.purple,
                ));

              return SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 8),
                    child: Column(children: [
                      Center(
                        child: Container(
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                NetworkImage(loginController.image ?? ''),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListTile(
                          title: Text(
                            "First name: ${loginController.firstName}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          // trailing: IconButton(
                          //     onPressed: editFirstName,
                          //     icon: Icon(Icons.edit)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListTile(
                          title: Text(
                            "Last name: ${loginController.lastName}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          // trailing: IconButton(
                          //     onPressed: editLastName,
                          //     icon: Icon(Icons.edit)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Email: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              loginController.email!,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ])),
              );
            }));
  }
}
