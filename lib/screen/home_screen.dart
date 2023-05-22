import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _email = "";
  String _time = "";

  @override
  void initState() {
    _getUserData();
    _setTime();
    Timer.periodic(const Duration(seconds: 1), (timer) => _setTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.pink,
          height: 200,
          width: double.infinity,
        ),
        Column(children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
              const SizedBox(width: 16),
              _buildNameWidget(),
            ]),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 4,
                  blurRadius: 6,
                )
              ],
            ),
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.symmetric(vertical: 16),
            width: double.infinity,
            child: Column(children: [
              Text(_format('EEEE, dd MMM yyyy')),
              const SizedBox(height: 12),
              Text(
                _time,
                style:
                    const TextStyle(fontSize: 60, fontWeight: FontWeight.w600),
              ),
            ]),
          ),
        ]),
      ]),
    );
  }

  Column _buildNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _email,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "PT Bank Amar Indonesia",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    );
  }

  _format(String pattern) {
    final f = DateFormat(pattern);
    return f.format(DateTime.now());
  }

  _getUserData() {
    final auth = FirebaseAuth.instance.currentUser;
    setState(() {
      _email = auth!.email!;
    });
  }

  _setTime() {
    final time = _format("HH:mm:ss");
    setState(() {
      _time = time;
    });
  }

  // _logout() async {
  //   await FirebaseAuth.instance.signOut();
  //   // ignore: use_build_context_synchronously
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const SplashScreen(),
  //     ),
  //     (route) => false,
  //   );
  // }
}
