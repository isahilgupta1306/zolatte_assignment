import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zolatte_assignment/services/user_model.dart';

class FirebaseOperationsProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  // GoogleSignInAccount? _googleUser;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  late UserModel userModel;
  var documentId;
  bool isDeleted = false;
  bool isSubmitted = false;

  Future<void> addUser(String fullName, String emailAddress, String phoneNum,
      String age, String birthDate, String streetAddress) async {
    //    Method responsible for adding the User's Data to Firebase
    userModel = UserModel(
        fullName, phoneNum, age, streetAddress, birthDate, emailAddress);

    if (!isSubmitted) {
      var docRef = await userCollection.add(userModel.toMap()).then((value) {
        print("User Added");
        documentId = value.id;
        print(documentId + " <- document id"); //stored the coument Id
      }).catchError((error) => print("Failed to add user: $error"));
      isSubmitted = true;
    } else {
      updateUserData(
          fullName, emailAddress, phoneNum, age, birthDate, streetAddress);
    }
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

  Future<DocumentSnapshot> getUserData(dynamic userId) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    return documentSnapshot;
  }

  Future<void> deleteData(String userId) async {
    if (!isDeleted) {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      isDeleted = true;
      print("Data deleted");
    }
    notifyListeners();
  }
}
