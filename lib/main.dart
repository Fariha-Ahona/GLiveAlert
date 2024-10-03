// Importing dart:ui for ImageFilter
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:glivealert/screens/home_page.dart';
import 'package:glivealert/screens/sign_in_page.dart';
import 'package:glivealert/screens/sign_up_page.dart';
import 'package:glivealert/screens/discover.dart'; // Ensure this path is correct
import 'package:glivealert/screens/user_selection.dart'; // Ensure this path is correct
import 'package:glivealert/screens/GMS.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for web and other platforms
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBLKEv0e3Y59f01D0Q1szyezZSolYh_DjY',
      appId: '1:180777525526:web:61fe3dddb8b9d601fe3037',
      projectId: 'glivealert',
      storageBucket: 'glivealert.appspot.com',
      messagingSenderId: '180777525526',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GLiveAlert',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),  // Adjust HomePage if needed
        '/signup': (context) => const SignUpPage(),
        '/signin': (context) => const SignInPage(),
        '/user_selection': (context) => const LoginScreen(), // Ensure LoginScreen is defined correctly
        '/discover': (context) => const DiscoverPage(), // Ensure DiscoverPage is accessible
        '/gms': (context) => const GMSDetails(), // Ensure GMSPage is accessible
      },
    );
  }
}
