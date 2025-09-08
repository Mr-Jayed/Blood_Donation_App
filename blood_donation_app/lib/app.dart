import 'package:flutter/material.dart';
import 'package:blood_donation_app/screens/Welcome_page.dart';
import 'package:blood_donation_app/screens/auth/login_page.dart';
import 'package:blood_donation_app/screens/auth/signup_page.dart';
import 'package:blood_donation_app/screens/home_page.dart';
import 'package:blood_donation_app/screens/lists/donor_list_page.dart';
import 'package:blood_donation_app/screens/lists/requests_page.dart';
import 'package:blood_donation_app/screens/profile_page.dart';
import 'package:blood_donation_app/screens/request_page.dart';

class BloodConnectApp extends StatelessWidget {
  const BloodConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BloodConnect',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/profile': (context) => const ProfilePage(),
        '/home': (context) => const HomePage(),
        '/request': (context) => const RequestPage(),
        '/requests': (context) => const RequestsPage(),
        '/donors': (context) => const DonorListPage(),
      },
    );
  }
}
