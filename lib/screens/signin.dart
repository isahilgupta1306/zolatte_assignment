import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:zolatte_assignment/screens/verify_otp.dart';
import 'package:zolatte_assignment/utils/themes/app_text_styles.dart';
import 'package:zolatte_assignment/utils/themes/named_colors.dart';
import 'package:zolatte_assignment/widgets/custom_divider.dart';
import 'package:zolatte_assignment/widgets/solid_inverse_button.dart';
import '../providers/google_signin.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static String verify = "";

  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  final numController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: NamedColors.shinyPurple,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    'assets/zolatte_logo.png',
                    fit: BoxFit.fitHeight,
                    height: deviceSize.height * 0.18,
                  ),
                  const Divider(
                    endIndent: 35,
                    indent: 35,
                    color: Colors.white,
                    thickness: 2,
                    height: 40,
                  ),
                  Text(
                    "Z O L A T T E's Assignment",
                    style: AppTextStyles.heading.copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SolidInverseButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogIn();
                    },
                    label: "Sign In with Google",
                    deviceSize: deviceSize,
                    labelTextStyle: AppTextStyles.SolidInverseButttonTextStyle,
                    icon: Icons.people,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const CustomDivider(),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: formKey,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Container(
                        width: deviceSize.width * 0.87,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: const []),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (!isPhoneNoValid(value)) {
                              return "Please enter appropriate number";
                            }
                          },
                          controller: numController,
                          decoration: InputDecoration(
                              hintText: "Enter your number",
                              suffixIcon: const Icon(Icons.phone),
                              prefix: const Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Text(
                                  '+91',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: NamedColors.shinyPurple),
                                ),
                              ),
                              isDense: true,
                              counterText: "",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SolidInverseButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // method
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: "+91${numController.text}",
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent:
                                (String verificationId, int? resendToken) {
                              SignUp.verify = verificationId;
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const MyVerify(),
                              ));
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                          );
                        }
                      },
                      label: "Sign in Using Phone Number",
                      deviceSize: deviceSize,
                      labelTextStyle:
                          AppTextStyles.SolidInverseButttonTextStyle,
                      icon: Icons.phone_android),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )),
        ));
  }
}

bool isPhoneNoValid(String? phoneNo) {
  if (phoneNo == null) return false;
  final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  return regExp.hasMatch(phoneNo);
}
