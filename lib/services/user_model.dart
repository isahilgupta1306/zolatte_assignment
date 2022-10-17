import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String userName;
  late String phoneNum;
  late String age;
  late String birthDate;
  late String address;

  late String emailId;

  UserModel(this.userName, this.phoneNum, this.age, this.address,
      this.birthDate, this.emailId);

  Map<String, dynamic> toMap() {
    return {
      'full_name': userName,
      'email': emailId,
      'number': phoneNum,
      'age': age,
      'birthDate': birthDate,
      'address': address,
    };
  }

  Map<String, dynamic> toJSON() {
    return {
      'full_name': userName,
      'email': emailId,
      'number': phoneNum,
      'age': age,
      'birthDate': birthDate,
      'address': address,
    };
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    address = json['address'];
    age = json['age'];
    birthDate = json['birthDate'];
    emailId = json['email'];
    phoneNum = json['number'];
  }
  // userName: json['user_name'],
  // address: json['address'],
  // age: json['age'],
  // birthDate: json['birthDate'],
  // emailId: json['email'],
  // phoneNum: ['number'],

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    String userName;
    String phoneNum;
    String age;
    String birthDate;
    String address;
    String emailId;
    userName = doc.get('full_name');
    phoneNum = doc.get('number');
    age = doc.get('age');
    address = doc.get('address');
    birthDate = doc.get('birthDate');
    emailId = doc.get('emailId');
    return UserModel(userName, phoneNum, age, address, birthDate, emailId);
  }
}
