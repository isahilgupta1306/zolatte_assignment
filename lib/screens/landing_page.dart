import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zolatte_assignment/providers/firebase_operations.dart';
import 'package:zolatte_assignment/screens/screen1.dart';
import 'package:zolatte_assignment/screens/screen2.dart';

import 'package:zolatte_assignment/utils/themes/app_text_styles.dart';
import 'package:zolatte_assignment/utils/themes/named_colors.dart';
import 'package:zolatte_assignment/widgets/custom_solid_button.dart';
import 'package:zolatte_assignment/widgets/drawer.dart';
import '../providers/google_signin.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    super.key,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final TextEditingController dateinput = TextEditingController();
  final TextEditingController numberInputController = TextEditingController();
  final TextEditingController addressInputController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  int age = 0;

  @override
  void dispose() {
    dateinput.dispose();
    numberInputController.dispose();
    addressInputController.dispose();
    super.dispose();
  }

  late final String? uid;

  Future<String> inputData() async {
    final user = FirebaseAuth.instance.currentUser;

    final String uid = user!.uid.toString();
    return uid;
  }

  @override
  void initState() {
    uid = _firebaseAuth.currentUser!.uid;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    bool enteredAge = false;

    Future<User?> getCurrentUser() async {
      var _user = await FirebaseAuth.instance.currentUser;

      return _user;
    }

    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                handleClick(value, context);
              },
              itemBuilder: (BuildContext context) {
                return {'Screen 1', 'Screen 2'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        drawer: const DrawerWidget(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<User?>(
                  future: getCurrentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data?.email != null) {
                        String? photoUrl = snapshot.data?.photoURL;
                        return userDataWidget(context, snapshot.data, photoUrl);
                      } else {
                        return const SizedBox(
                          height: 8,
                        );
                      }
                    }
                    return const SizedBox(
                      height: 8,
                    );
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Hold On !",
                      style: TextStyle(
                          color: NamedColors.codGrey.withOpacity(0.7),
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      "We need some of your data , ",
                      style:
                          TextStyle(color: NamedColors.codGrey, fontSize: 14),
                    ),
                    userDataForm(context, deviceSize, enteredAge),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget userDataForm(BuildContext context, Size deviceSize, bool enteredAge) {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: deviceSize.width * 0.87,
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.person, color: Colors.grey[600]),
                  hintText: 'Name',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(28),
                    ),
                    borderSide: BorderSide(width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(28),
                    ),
                    borderSide: BorderSide(
                        width: 2, color: Theme.of(context).primaryColor),
                  ),
                ),
                keyboardType: TextInputType.name,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Enter Name";
                  }
                },
              ),
            ),
            const SizedBox(
              height: 13,
            ),

            SizedBox(
              width: deviceSize.width * 0.87,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.email, color: Colors.grey[600]),
                  hintText: 'E mail',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(28),
                    ),
                    borderSide: BorderSide(width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(28),
                    ),
                    borderSide: BorderSide(
                        width: 2, color: Theme.of(context).primaryColor),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Enter Your Email";
                  }
                  if (!value.contains('@')) {
                    return "Enter appropriate Email";
                  }
                },
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            SizedBox(
              width: deviceSize.width * 0.87,
              child: TextFormField(
                controller: numberInputController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.phone, color: Colors.grey[600]),
                  hintText: 'Phone Number',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(28),
                    ),
                    borderSide: BorderSide(width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(28),
                    ),
                    borderSide: BorderSide(
                        width: 2, color: Theme.of(context).primaryColor),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Enter Your Phone Number";
                  }
                  if (!isMobileNumberValid(value) || value.length < 10) {
                    return "Enter appropriate number";
                  }
                },
              ),
            ),
            const SizedBox(
              height: 13,
            ),

            SizedBox(
              width: deviceSize.width * 0.87,
              child: TextFormField(
                controller: dateinput,
                readOnly: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon:
                      Icon(Icons.calendar_month, color: Colors.grey[600]),
                  hintText: 'Birth Date',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(28),
                    ),
                    borderSide: BorderSide(width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(28),
                    ),
                    borderSide: BorderSide(
                        width: 2, color: Theme.of(context).primaryColor),
                  ),
                ),
                keyboardType: TextInputType.datetime,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Set BirthDate";
                  }
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2090));

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);

                    age = calculateAge(pickedDate);
                    setState(() {
                      dateinput.text = formattedDate;
                      enteredAge = true;
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
            // setting age
            enteredAge
                ? Text("Age : ${age.toString()}")
                : const SizedBox(
                    height: 2,
                  ),
            const SizedBox(
              height: 13,
            ),
            SizedBox(
              width: deviceSize.width * 0.87,
              child: TextFormField(
                controller: addressInputController,
                maxLines: 6,
                minLines: 4,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 20),
                    child: Icon(
                      Icons.location_city,
                      color: Colors.grey[600],
                    ),
                  ),
                  hintText: 'Address',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(28),
                    ),
                    borderSide: BorderSide(width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(28),
                    ),
                    borderSide: BorderSide(
                        width: 2, color: Theme.of(context).primaryColor),
                  ),
                ),
                keyboardType: TextInputType.streetAddress,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Enter Your Address";
                  }
                },
              ),
            ),
            const SizedBox(
              height: 13,
            ),

            SolidButton(
              onPressed: (() {
                if (formKey.currentState!.validate()) {
                  final provider = Provider.of<FirebaseOperationsProvider>(
                      context,
                      listen: false);
                  provider.addUser(
                    nameController.text,
                    emailController.text,
                    numberInputController.text,
                    age.toString(),
                    dateinput.text,
                    addressInputController.text,
                  );
                  nameController.clear();
                  emailController.clear();
                  numberInputController.clear();
                  dateinput.clear();
                  addressInputController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Form Submitted Successfully')));
                }
              }),
              label: "SUBMIT FORM",
              deviceSize: deviceSize,
              labelTextStyle: AppTextStyles.solidButttonTextStyle,
              icon: Icons.arrow_circle_right,
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ));
  }
}

// Holds the initial data who xhoose Google Authentication
Widget userDataWidget(BuildContext context, dynamic user, String? photoUrl) {
  bool imageCheck = false;
  if (photoUrl != null) {
    imageCheck = true;
  }
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Center(
          child: CircleAvatar(
            radius: 65,
            backgroundColor: NamedColors.shinyPurple.withOpacity(0.6),
            child: imageCheck
                ? CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(photoUrl!),
                  )
                : Image.asset('assets/person_icon.jpg'),
          ),
        ),
        Text(
          "Welcome, ${user.displayName}.",
          style: AppTextStyles.heading,
        ),
        RawChip(
          onPressed: () {},
          label: Text(
            user.email!,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: NamedColors.shinyPurple.withOpacity(0.8),
          elevation: 4,
          pressElevation: 10,
          avatar: const Icon(
            Icons.email,
            color: Colors.white,
            size: 18,
          ),
        ),
        const Divider(
          color: NamedColors.grey,
          endIndent: 40,
          indent: 40,
        ),
      ],
    ),
  );
}

// logic for calculating age out of Birth Date
int calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  print(age);
  return age;
}

// loggin the user out
void logOut(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
  provider.logout();
}

// handlinf clicks for menu
void handleClick(String value, BuildContext context) {
  switch (value) {
    case 'Screen 1':
      redirectToScreen1(context);
      break;
    case 'Screen 2':
      redirectToScreen2(context);
      break;
  }
}

// validating phone number
bool isMobileNumberValid(String phoneNumber) {
  String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
  var regExp = RegExp(regexPattern);

  if (phoneNumber.length == 0) {
    return false;
  } else if (regExp.hasMatch(phoneNumber)) {
    return true;
  }
  return false;
}

void redirectToScreen1(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Screen1()));
}

void redirectToScreen2(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Screen2()));
}
