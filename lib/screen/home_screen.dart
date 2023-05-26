// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Menu {
  final IconData icon;
  final String title;

  Menu(this.icon, this.title);
}

class _HomeScreenState extends State<HomeScreen> {
  String _email = "";
  String _time = "";
  final menuList = [
    Menu(Icons.newspaper_rounded, "Berita"),
    Menu(Icons.monetization_on_rounded, "Gaji"),
    Menu(Icons.desktop_mac_rounded, "Monitoring"),
    Menu(Icons.track_changes, "Nilai"),
  ];

  @override
  void initState() {
    _getEmail();
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
          height: 180,
          width: double.infinity,
        ),
        Column(children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 12),
          _buildNameWidget(),
          _buildCardWidget(),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            children: menuList
                .map((menu) => _buildMenuWidget(menu.icon, menu.title))
                .toList(),
          ),
        ])
      ]),
    );
  }

  Column _buildMenuWidget(
    IconData icon,
    String title,
  ) {
    return Column(children: [
      Icon(
        icon,
        size: 32,
        color: Colors.blue,
      ),
      const SizedBox(height: 10),
      Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    ]);
  }

  Container _buildCardWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 6,
            blurRadius: 4,
          )
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Column(children: [
        Text(_format("EEEE, dd MMM yyyy")),
        const SizedBox(height: 12),
        Text(
          _time,
          style: const TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.w700,
          ),
        ),
      ]),
    );
  }

  String _format(String pattern) {
    final format = DateFormat(pattern);
    return format.format(DateTime.now());
  }

  _setTime() {
    setState(() {
      _time = _format("HH:mm:ss");
    });
  }

  Widget _buildNameWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [
        const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.person),
        ),
        const SizedBox(width: 14),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            _email,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "PT Bank Amar Indonesia",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ]),
      ]),
    );
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
      (route) => false,
    );
  }

  _getEmail() {
    final auth = FirebaseAuth.instance.currentUser;
    _email = auth!.email!;
  }
}
