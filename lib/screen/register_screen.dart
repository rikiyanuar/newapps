// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/button.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();
  final _passwordConfirmInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.pink,
        ),
        title: const Text(
          "Create your Account",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            _buildCard(
              child: TextField(
                controller: _passwordConfirmInput,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Confirm Password",
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 48),
            GeneralButton(
              text: "Sign Up",
              onTap: () => register(),
            ),
          ]),
        ),
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

  register() async {
    if (_passwordInput.text == _passwordConfirmInput.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailInput.text,
          password: _passwordInput.text,
        );
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
    } else {
      print("Password and confirmation password not match");
    }
  }
}
