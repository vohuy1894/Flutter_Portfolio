import 'package:flutter/foundation.dart';
import 'package:portfolio/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider extends ChangeNotifier{
  static void addUserData({
    required User currentUser,
    required String userName,
    required String userEmail,
    required String userImage,
  }) async {
    await FirebaseFirestore.instance.collection("userData").doc(currentUser.uid).set(
      {
        "userName" : userName,
        "userEmail" : userEmail,
        "userImage": userImage,
        "userUID": currentUser.uid
      }
    ); 
  }


  static void getUserData() async {
    UserModel currentData;
    UserModel userModel;
    var value = await FirebaseFirestore.instance
        .collection("usersData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
        userEmail: value.get("userEmail"),
        userImage: value.get("userImage"),
        userName: value.get("userName"),
        userUid: value.get("userUid"),
      );
      currentData = userModel;
      //notifyListeners();
    }
  }

  // UserModel get currentUserData {
  //   return currentData;
  // }
}