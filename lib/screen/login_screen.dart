// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newapps/utils/app_constant.dart';

import '../widgets/button.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();

  final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 80),
          const Center(
            child: Text(
              AppConstant.titleApp,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 48),
          Text(
            "Login to your Account",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          _buildCard(
            child: TextField(
              controller: _emailInput,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Email",
              ),
            ),
          ),
          _buildCard(
            child: TextField(
              controller: _passwordInput,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Password",
              ),
              obscureText: true,
            ),
          ),
          const SizedBox(height: 48),
          GeneralButton(
            text: "Sign In",
            onTap: () => login(),
          ),
          const SizedBox(height: 32),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterScreen(),
                ),
              );
            },
            child: const Center(
              child: Text("Don't have an Account? Sign Up"),
            ),
          ),
          const SizedBox(height: 60),
          GeneralButton(
            text: "Sign In With Google",
            onTap: () => signInWithGoogle(),
            color: Colors.blue,
          ),
        ]),
      ),
    );
  }

  Container _buildCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 14,
            spreadRadius: 2,
          )
        ],
      ),
      child: child,
    );
  }

  signInWithGoogle() async {
    try {
      final googleSignIn = await _googleSignIn.signIn();

      final googleSignInAuthentication = await googleSignIn!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Future.delayed(const Duration(seconds: 3)).then(
        (value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailInput.text, password: _passwordInput.text);
      Future.delayed(const Duration(seconds: 3)).then(
        (value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
