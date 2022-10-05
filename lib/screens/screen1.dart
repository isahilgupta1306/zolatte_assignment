import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zolatte_assignment/screens/landing_page.dart';
import 'package:zolatte_assignment/screens/signin.dart';
import 'package:zolatte_assignment/utils/themes/app_text_styles.dart';
import 'package:zolatte_assignment/utils/themes/named_colors.dart';
import 'package:zolatte_assignment/widgets/custom_solid_button.dart';
import 'package:zolatte_assignment/widgets/solid_inverse_button.dart';

import '../providers/google_signin.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Screen 1",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Center(
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
                  "Welcome ${user.displayName},",
                  style: AppTextStyles.heading,
                ),
                RawChip(
                  onPressed: () {},
                  label: Text(user.email!),
                  backgroundColor: NamedColors.shinyPurple.withOpacity(0.25),
                  avatar: const Icon(
                    Icons.email_outlined,
                    size: 18,
                  ),
                ),
                const Divider(
                  color: NamedColors.grey,
                  endIndent: 40,
                  indent: 40,
                ),
                SvgPicture.asset(
                  "assets/logout_illustration.svg",
                  fit: BoxFit.fitHeight,
                  height: deviceSize.height * 0.28,
                  width: deviceSize.height * 0.28,
                ),
                const SizedBox(
                  height: 25,
                ),
                // customButton2(
                //   context,
                //   deviceSize,
                //   "LOG OUT",
                // ),
                SolidButton(
                  onPressed: () => logOut(context),
                  label: 'LOG OUT',
                  deviceSize: deviceSize,
                  labelTextStyle: AppTextStyles.solidButttonTextStyle,
                  icon: Icons.exit_to_app_outlined,
                ),
                const SizedBox(height: 20),
                SolidInverseButton(
                  onPressed: () {
                    redirect(context);
                    print("redirected ->>");
                  },
                  label: "Go Back to Home",
                  deviceSize: deviceSize,
                  labelTextStyle: AppTextStyles.SolidInverseButttonTextStyle,
                  icon: Icons.home_max_outlined,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void logOut(BuildContext context) {
  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
  provider.logout();
  Navigator.push(context, MaterialPageRoute(builder: (ctx) => const SignUp()));
}

void redirect(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (ctx) => const LandingPage()));
}

Widget customButton2(
  BuildContext context,
  Size deviceSize,
  String buttonTitle,
) {
  return SizedBox(
    width: deviceSize.width * 0.87,
    height: deviceSize.width * 0.14,
    child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () => logOut(context),
        icon: const Icon(Icons.exit_to_app_outlined),
        label: Text(
          buttonTitle,
          style: AppTextStyles.solidButttonTextStyle,
        )),
  );
}

Widget customButton1(
  BuildContext context,
  Size deviceSize,
  String buttonTitle,
) {
  return SizedBox(
    width: deviceSize.width * 0.87,
    height: deviceSize.width * 0.14,
    child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () => redirect(context),
        icon: const Icon(
          Icons.home_outlined,
          color: NamedColors.shinyPurple,
        ),
        label: Text(
          buttonTitle,
          style: AppTextStyles.SolidInverseButttonTextStyle,
        )),
  );
}
