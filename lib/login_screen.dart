import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Center(
              child: Text(
                "New Apps",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Login to your Account",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      spreadRadius: 1,
                    )
                  ]),
              child: TextField(
                controller: _emailInput,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Email"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      spreadRadius: 1,
                    )
                  ]),
              child: TextField(
                controller: _passwordInput,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => login(),
                child: const Text("Sign In"),
              ),
            ),
            const SizedBox(height: 48),
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
            )
          ],
        ),
      ),
    );
  }

  login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailInput.text, password: _passwordInput.text);
      print(credential.user!.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
