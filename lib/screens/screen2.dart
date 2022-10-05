import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zolatte_assignment/providers/firebase_operations.dart';
import 'package:zolatte_assignment/utils/themes/named_colors.dart';

import '../utils/themes/app_text_styles.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Screen 2",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        elevation: 0,
      ),
      // backgroundColor: NamedColors.shinyPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/delete_illustration.svg',
              fit: BoxFit.fitHeight,
              height: deviceSize.width * 0.35,
              width: deviceSize.width * 0.45,
            ),
            customButton1(context, deviceSize, "Delete Your Data")
          ],
        ),
      ),
    );
  }
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
          shadowColor: Colors.red,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () {
          // have a check for deleting pre-deleted object
          // String docId =
          //     Provider.of<FirebaseOperationsProvider>(context, listen: false)
          //         .documentId;
          // print(docId + "  -< from screen2");
          // Provider.of<FirebaseOperationsProvider>(context, listen: false)
          //     .deleteData(docId);
        },
        icon: const Icon(
          Icons.delete_outline,
          color: Colors.red,
        ),
        label: Text(
          buttonTitle,
          style: AppTextStyles.SolidInverseButttonTextStyle.copyWith(
              color: Colors.red),
        )),
  );
}

void deleteData(BuildContext context) {
  String docId = Provider.of<FirebaseOperationsProvider>(context, listen: false)
      .documentId;
  print(docId + "  -< from screen2");
  Provider.of<FirebaseOperationsProvider>(context, listen: false)
      .deleteData(docId);
}
