import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_3/helper/helper_function.dart';
import 'package:flutter_application_3/pages/auth/login_page.dart';
import 'package:flutter_application_3/pages/home_page.dart';
import 'package:flutter_application_3/shared/Constants.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  await HelperFunctions.getUserLoggedInStatus().then((value) {
    runApp(MyApp(isSignedIn: value ?? false));
  });
}

class MyApp extends StatelessWidget {
  final bool isSignedIn;

  const MyApp({Key? key, required this.isSignedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Constants().primaryColor,
        scaffoldBackgroundColor: const Color(0xFF040116),
      ),
      debugShowCheckedModeBanner: false,
      home: isSignedIn ? const HomePage() : const LoginPage(),
    );
  }
}
