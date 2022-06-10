import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  String? firstName;
  String? lastName;
  String? email;
  String? image;

  currentUserProfile() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        firstName = ds.data()!['first name'];
        lastName = ds.data()!['last name'];
        email = ds.data()!['email'];
        image = ds.data()!['image'] ??
            "https://www.freeiconspng.com/thumbs/profile-icon-png/profile-icon-9.png";
      }).catchError((e) {
        print(e);
      });
    }
  }
}
