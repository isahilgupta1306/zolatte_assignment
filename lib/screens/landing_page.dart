import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zolatte_assignment/providers/firebase_operations.dart';
import 'package:zolatte_assignment/screens/screen1.dart';
import 'package:zolatte_assignment/screens/screen2.dart';
import 'package:zolatte_assignment/services/user_model.dart';
import 'package:zolatte_assignment/utils/themes/app_text_styles.dart';
import 'package:zolatte_assignment/utils/themes/named_colors.dart';
import 'package:zolatte_assignment/widgets/custom_solid_button.dart';
import '../providers/google_signin.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController dateinput = TextEditingController();
  final TextEditingController numberInputController = TextEditingController();
  final TextEditingController addressInputController = TextEditingController();
  int age = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    dateinput.dispose();
    numberInputController.dispose();
    addressInputController.dispose();
    super.dispose();
  }
  // int _selectedIndex = 0;

  // static const List<Widget> _widgetOptions = <Widget>[
  //   Screen1(),
  //   Screen2(),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final deviceSize = MediaQuery.of(context).size;
    late UserModel userModel;

    String birthDate;
    bool enteredAge = false;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  logOut(context);
                },
                icon: const Icon(Icons.exit_to_app)),
            PopupMenuButton<String>(
              onSelected: (value) {
                handleClick(value, context);
              },
              itemBuilder: (BuildContext context) {
                return {'Screen 1', 'Screen 2', 'Logout'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        drawer: drawerWidget(context),
        // bottomNavigationBar: BottomNavigationBar(
        //     items: const <BottomNavigationBarItem>[
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.home_outlined),
        //         label: 'Home',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.person_outline_outlined),
        //         label: "Profile",
        //       ),
        //     ],
        //     type: BottomNavigationBarType.shifting,
        //     currentIndex: _selectedIndex,
        //     selectedItemColor: NamedColors.shinyPurple,
        //     unselectedItemColor: NamedColors.shinyPurple.withOpacity(0.35),
        //     iconSize: 40,
        //     onTap: _onItemTapped,
        //     elevation: 5),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userDataWidget(context, user),
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
                    Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: deviceSize.width * 0.87,
                              // height: deviceSize.width * 0.14,
                              child: TextFormField(
                                controller: numberInputController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(Icons.phone,
                                      color: Colors.grey[600]),
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
                                        width: 2,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Enter Your Phone Number";
                                  }
                                  if (!isMobileNumberValid(value) ||
                                      value.length < 10) {
                                    return "Enter appropriate number";
                                  }
                                },
                                onSaved: (value) {
                                  //function
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 13,
                            ),

                            SizedBox(
                              width: deviceSize.width * 0.87,
                              // height: deviceSize.width * 0.14,
                              child: TextFormField(
                                controller: dateinput,
                                readOnly: true,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(Icons.calendar_month,
                                      color: Colors.grey[600]),
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
                                        width: 2,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                keyboardType: TextInputType.datetime,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return "Set BirthDate";
                                  }
                                },
                                onSaved: (value) {
                                  //function
                                },
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2090));

                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    print(formattedDate);
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
                              // height: deviceSize.width * 0.14,
                              child: TextFormField(
                                controller: addressInputController,
                                maxLines: 6,
                                minLines: 4,
                                textInputAction: TextInputAction.newline,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 20),
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
                                        width: 2,
                                        color: Theme.of(context).primaryColor),
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
                            // validationButton(
                            //     context,
                            //     formKey,
                            //     deviceSize,
                            //     "SUBMIT FORM",
                            //     user.displayName,
                            //     user.email,
                            //     numberInputController.text,
                            //     dateinput.text,
                            //     age.toString(),
                            //     addressInputController.text),
                            SolidButton(
                              onPressed: (() {
                                if (formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Form Submitted Successfully')));
                                  final provider =
                                      Provider.of<FirebaseOperationsProvider>(
                                          context,
                                          listen: false);
                                  provider.addUser(
                                      user.displayName!,
                                      user.email!,
                                      numberInputController.text,
                                      age.toString(),
                                      dateinput.text,
                                      addressInputController.text);
                                }
                              }),
                              label: "SUBMIT FORM",
                              deviceSize: deviceSize,
                              labelTextStyle:
                                  AppTextStyles.solidButttonTextStyle,
                              icon: Icons.arrow_circle_right,
                            )
                          ],
                        )),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget validationButton(
      BuildContext context,
      dynamic formKey,
      Size deviceSize,
      String buttonTitle,
      String? displayName,
      String? email,
      String phoneNum,
      String birthDate,
      String currAge,
      String address) {
    return SizedBox(
      width: deviceSize.width * 0.87,
      height: deviceSize.width * 0.14,
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Form Submitted Successfully')));
              final provider = Provider.of<FirebaseOperationsProvider>(context,
                  listen: false);
              provider.addUser(displayName!, email!, numberInputController.text,
                  currAge, dateinput.text, addressInputController.text);
            }
          },
          icon: const Icon(Icons.arrow_circle_right),
          label: Text(
            buttonTitle,
            style: AppTextStyles.SolidInverseButttonTextStyle,
          )),
    );
  }
}

// customButton2

Widget userDataWidget(BuildContext context, dynamic user) {
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
            child: CircleAvatar(
              backgroundImage: NetworkImage((user.photoURL!)),
              radius: 60,
            ),
          ),
        ),
        Text(
          "Welcome, ${user.displayName},",
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

Widget drawerWidget(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: NamedColors.shinyPurple,
          ),
          child: Text(
            'Drawer Header',
            style: AppTextStyles.heading.copyWith(color: Colors.white),
          ),
        ),
        ListTile(
          title: const Text('Screen 1'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => const Screen1()));
          },
        ),
        ListTile(
          title: const Text('Screen 2'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => const Screen2()));
          },
        ),
      ],
    ),
  );
}

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

void logOut(BuildContext context) {
  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
  provider.logout();
}

void handleClick(String value, BuildContext context) {
  switch (value) {
    case 'Screen 1':
      redirectToScreen1(context);
      break;
    case 'Screen 2':
      redirectToScreen2(context);
      break;
    case 'LogOut':
      {
        logOut(context);
        break;
      }
  }
}

// validating phone number
bool isMobileNumberValid(String phoneNumber) {
  String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
  var regExp = new RegExp(regexPattern);

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
