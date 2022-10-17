import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zolatte_assignment/providers/firebase_operations.dart';
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
              DataCard(context, user.uid, user.photoURL),
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
              SolidButton(
                onPressed: () => logOut(context),
                label: 'LOG OUT for Google Auth',
                deviceSize: deviceSize,
                labelTextStyle: AppTextStyles.solidButttonTextStyle,
                icon: Icons.exit_to_app_outlined,
              ),
              const SizedBox(height: 20),
              SolidInverseButton(
                onPressed: () {
                  redirect(context);
                },
                label: "Go Back to Home",
                deviceSize: deviceSize,
                labelTextStyle: AppTextStyles.SolidInverseButttonTextStyle,
                icon: Icons.home_outlined,
              ),
              const SizedBox(height: 20),
              SolidButton(
                onPressed: () => logOutforPhoneAuth(context),
                label: 'LOG OUT for Phone Auth',
                deviceSize: deviceSize,
                labelTextStyle: AppTextStyles.solidButttonTextStyle,
                icon: Icons.exit_to_app_outlined,
              ),
              const SizedBox(height: 20),
            ],
          )),
        ),
      ),
    );
  }
}

void logOut(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
  provider.logout();
}

void logOutforPhoneAuth(BuildContext context) {
  Navigator.pop(context);
  Navigator.pop(context);
  Navigator.of(context).popUntil((route) => route.isFirst);
  FirebaseAuth.instance.signOut();
}

void redirect(BuildContext context) {
  Navigator.pop(context);
  Navigator.pop(context);
}

Widget DataCard(BuildContext context, String id, String? photoUrl) {
  bool imageCheck = false;
  if (photoUrl != null) {
    imageCheck = true;
  }
  return Consumer<FirebaseOperationsProvider>(
    builder: (context, value, child) {
      String docId = id;
      return FutureBuilder<Map<String, dynamic>>(
          future: value.getUserData(docId),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.active) {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 38,
                              backgroundColor:
                                  const Color.fromARGB(255, 169, 158, 190),
                              child: imageCheck
                                  ? CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(photoUrl!),
                                    )
                                  : Image.asset('assets/person_icon.jpg'),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data!['full_name'],
                                    style: AppTextStyles.heading.copyWith(
                                        color: NamedColors.codGrey,
                                        fontSize: 22)),
                                Text(
                                  snapshot.data!['email'],
                                  style: AppTextStyles.subHeading.copyWith(
                                      color: NamedColors.codGrey
                                          .withOpacity(0.75)),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          height: 25,
                          indent: 15,
                          endIndent: 15,
                          color: NamedColors.shinyPurple,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      size: 30,
                                      color: NamedColors.shinyPurple,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      snapshot.data!['number'],
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles
                                          .detailCardMetaDetaTextStyle,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.date_range,
                                      size: 30,
                                      color: NamedColors.shinyPurple,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      snapshot.data!['age'],
                                      style: AppTextStyles
                                          .detailCardMetaDetaTextStyle,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 30,
                                  color: NamedColors.shinyPurple,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    snapshot.data!['address'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: AppTextStyles.subHeading.copyWith(
                                        color: NamedColors.codGrey
                                            .withOpacity(0.7)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
              );
            }
            return const SizedBox(
              height: 8,
            );
          }));
    },
  );
}
