import 'package:flutter/material.dart';
import '../screens/screen1.dart';
import '../screens/screen2.dart';
import '../utils/themes/named_colors.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: NamedColors.shinyPurple,
              ),
              child: Image.asset('assets/zolatte_logo.png')),
          ListTile(
            title: const Text('Screen 1'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const Screen1()));
            },
          ),
          ListTile(
            title: const Text('Screen 2'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const Screen2()));
            },
          ),
        ],
      ),
    );
  }
}
