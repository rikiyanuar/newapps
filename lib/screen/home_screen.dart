// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newapps/screen/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _time = "";
  String _email = "";

  @override
  void initState() {
    _setTime();
    _getData();
    Timer.periodic(const Duration(seconds: 1), (timer) => _setTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.purple,
          height: 180,
          width: double.infinity,
        ),
        Column(children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 16),
          _buildNameWidget(),
          _buildCardWidget(),
          const SizedBox(height: 20),
          _buildGridView(),
          const SizedBox(height: 30),
          const Text(
            "Menara Standard Chartered",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              fontSize: 18,
            ),
          ),
        ])
      ]),
    );
  }

  GridView _buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      childAspectRatio: 1.2,
      children: [
        _buildMenuWidget(
          icon: Icons.newspaper_outlined,
          title: "Berita",
        ),
        _buildMenuWidget(
          icon: Icons.monetization_on_rounded,
          title: "Gaji",
        ),
        _buildMenuWidget(
          icon: Icons.people,
          title: "Monitoring",
        ),
        _buildMenuWidget(
          icon: Icons.track_changes,
          title: "Nilai",
        ),
        _buildMenuWidget(
          icon: Icons.note_add_sharp,
          title: "Presensi",
        ),
        _buildMenuWidget(
          icon: Icons.bar_chart_outlined,
          title: "Statistik",
        ),
        _buildMenuWidget(
          icon: Icons.person,
          title: "Profil",
        ),
        _buildMenuWidget(
          icon: Icons.calendar_month,
          title: "Cuti",
        ),
      ],
    );
  }

  _buildMenuWidget({
    required IconData icon,
    required String title,
  }) {
    return Column(children: [
      CircleAvatar(child: Icon(icon)),
      const SizedBox(height: 6),
      Text(title, style: const TextStyle(fontSize: 16)),
    ]);
  }

  Container _buildCardWidget() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 4,
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(children: [
        Text(_format("EEEE, dd MMM yyyy")),
        const SizedBox(height: 12),
        Text(
          _time,
          style: const TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.w600,
          ),
        ),
      ]),
    );
  }

  _format(String pattern) {
    final dateTime = DateTime.now();

    return DateFormat(pattern).format(dateTime);
  }

  _setTime() {
    setState(() {
      _time = _format("HH:mm:ss");
    });
  }

  Padding _buildNameWidget() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.person),
        ),
        const SizedBox(width: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            _email,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            "PT Bank Amar Indonesia",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          )
        ])
      ]),
    );
  }

  _getData() {
    final auth = FirebaseAuth.instance.currentUser;
    setState(() {
      _email = auth!.email!;
    });
  }

  _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
      (route) => false,
    );
  }
}
