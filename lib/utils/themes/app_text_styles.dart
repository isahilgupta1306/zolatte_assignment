import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'named_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const heading = TextStyle(
    color: Color.fromARGB(255, 93, 52, 168),
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  // static const labelStyle = TextStyle(color: )

  //  static final altHeading = GoogleFonts.poppins(
  //     textStyle: const TextStyle(
  //   color: Color.fromARGB(255, 93, 52, 168),
  //   fontSize: 22,
  //   fontWeight: FontWeight.w700,
  // ));
  static const SolidInverseButttonTextStyle =
      TextStyle(color: NamedColors.shinyPurple, fontWeight: FontWeight.bold);

  static const solidButttonTextStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  static const subHeading = TextStyle(
    color: NamedColors.grey,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  // static final smallHeading = TextStyle(
  //   color: NamedColors.goldenDream,
  //   fontSize: 16.sp,
  //   fontWeight: FontWeight.bold,
  //   letterSpacing: 1.sp,
  // );
  // static final description = TextStyle(
  //   color: AppColors.description,
  //   fontSize: 14.sp,
  //   fontWeight: FontWeight.w400,
  //   letterSpacing: 1.8.sp,
  // );
  // static final textFieldHeading = TextStyle(
  //   color: AppColors.textFieldTitle,
  //   fontSize: 14.sp,
  //   letterSpacing: 1.8.sp,
  //   fontWeight: FontWeight.w700,
  // );
  // static final code = TextStyle(
  //   color: AppColors.body,
  //   fontSize: 16.sp,
  //   fontWeight: FontWeight.w900,
  //   letterSpacing: 4.sp,
  // );
  // static const body = TextStyle(
  //   color: AppColors.body,
  // );
  // static final button = TextStyle(
  //   color: NamedColors.codGrey,
  //   fontSize: 15.sp,
  //   fontWeight: FontWeight.bold,
  //   letterSpacing: 1.2.sp,
  // );
  // static final htmlTextStyle = {
  //   "*": Style(
  //     fontFamily: 'Open Sans',
  //     letterSpacing: 0.5.sp,
  //   ),
  // };
  // static final smallTitle = TextStyle(
  //   color: Colors.white.withOpacity(0.65),
  //   fontSize: 13.sp,
  //   letterSpacing: 2.sp,
  // );
  // static final errorStyle =
  //     TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp);

  // static final dialogBoxTitle = TextStyle(
  //     fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white);

  // static const dialogBoxActionStyle =
  //     TextStyle(fontWeight: FontWeight.bold, color: NamedColors.goldenDream);

  // static final descriptionStyle = TextStyle(
  //   color: Colors.white.withOpacity(0.8),
  //   fontStyle: FontStyle.italic,
  //   fontSize: 14.sp,
  // );

  // static final textFieldStyle =
  //     TextStyle(fontSize: 14.sp, color: NamedColors.codGrey);
}
