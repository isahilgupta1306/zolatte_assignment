import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:zolatte_assignment/providers/firebase_operations.dart';
import 'package:zolatte_assignment/providers/google_signin.dart';
import 'package:zolatte_assignment/screens/home.dart';
import 'package:zolatte_assignment/utils/themes/named_colors.dart';
import 'package:zolatte_assignment/utils/themes/palette.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) => FirebaseOperationsProvider()),
      ],
      child: MaterialApp(
        title: 'Zolatte Assignment',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // iconTheme: const IconThemeData(color: Palette.brandColor),
            scaffoldBackgroundColor: NamedColors.dimWhite,
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            primarySwatch: Palette.brandColor),
        home: const Home(),
      ),
    );
  }
}
