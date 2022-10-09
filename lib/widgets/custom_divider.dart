import 'package:flutter/material.dart';

import '../utils/themes/app_text_styles.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 2,
          width: deviceSize.width * 0.35,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.45)),
        ),
        Text(
          " O R ",
          style: AppTextStyles.heading
              .copyWith(color: Colors.white.withOpacity(0.8)),
        ),
        Container(
          height: 2,
          width: deviceSize.width * 0.35,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.45)),
        ),
      ],
    );
  }
}
