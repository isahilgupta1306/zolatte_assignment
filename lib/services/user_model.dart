class UserModel {
  final String userName;
  final String phoneNum;
  final String age;
  final String birthDate;
  final String address;

  final String emailId;

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
}
