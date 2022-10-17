import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zolatte_assignment/services/user_model.dart';

class FirebaseOperationsProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  User user = FirebaseAuth.instance.currentUser!;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  late UserModel userModel;
  var documentId;
  bool isDeleted = false;
  bool isSubmitted = false;

  //    Method responsible for adding the User's Data to Firebase
  Future<void> addUser(String fullName, String emailAddress, String phoneNum,
      String age, String birthDate, String streetAddress) async {
    userModel = UserModel(
        fullName, phoneNum, age, streetAddress, birthDate, emailAddress);
    user = FirebaseAuth.instance.currentUser!;
    documentId = user.uid;
    if (!isSubmitted) {
      await userCollection.doc(documentId).set(userModel.toMap());
      isSubmitted = true;
    } else {
      updateUserData(
          fullName, emailAddress, phoneNum, age, birthDate, streetAddress);
    }
    isDeleted = false;
  }

  Future<void> updateUserData(
      String fullName,
      String emailAddress,
      String phoneNum,
      String age,
      String birthDate,
      String streetAddress) async {
    userModel = UserModel(
        fullName, phoneNum, age, streetAddress, birthDate, emailAddress);
    await userCollection.doc(documentId).update(userModel.toMap());
  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    var data;
    await FirebaseFirestore.instance.collection('users').doc(userId).get().then(
        (DocumentSnapshot doc) => data = doc.data() as Map<String, dynamic>);

    return data;
  }

  Future<void> deleteData(String userId) async {
    if (!isDeleted) {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      isDeleted = true;
      print("Data deleted");
    }
    isSubmitted = false;
    notifyListeners();
  }
}
