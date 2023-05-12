import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                "Create your Account",
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
                    border: InputBorder.none,
                    hintText: "Email",
                  ),
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
                  controller: _passwordConfirmInput,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Confirm Password",
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => register(),
                  child: const Text("Sign Up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  register() async {
    if (_passwordInput.text == _passwordConfirmInput.text) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailInput.text,
          password: _passwordInput.text,
        );
        print(credential.user!);
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
