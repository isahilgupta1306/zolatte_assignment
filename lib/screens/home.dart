import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/signin.dart';
import '../screens/landing_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, value, child) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                return const LandingPage();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Something Went Wrong !"),
                );
              }

              return const SignUp();
            }),
          );
        },
      ),
    );
  }
}
