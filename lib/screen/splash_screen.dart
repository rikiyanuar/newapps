import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapps/screen/login_screen.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  checkAuth() {
    final auth = FirebaseAuth.instance.currentUser;
    if (auth == null) {
      Future.delayed(const Duration(seconds: 3)).then(
        (value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        ),
      );
    } else {
      Future.delayed(const Duration(seconds: 3)).then(
        (value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.pink,
        child: const Center(
          child: Text(
            "New Apps",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
