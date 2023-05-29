// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/button.dart';
import 'presensi_screen.dart';
import 'riwayat_presensi_screen.dart';
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
    Menu(Icons.newspaper_outlined, "Berita"),
    Menu(Icons.monetization_on_rounded, "Gaji"),
    Menu(Icons.people, "Monitoring"),
    Menu(Icons.track_changes, "Nilai"),
    Menu(Icons.timer_sharp, "Presensi"),
    Menu(Icons.bar_chart_outlined, "Statistik"),
    Menu(Icons.person, "Profil"),
    Menu(Icons.calendar_month, "Cuti"),
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
          height: 250,
          width: double.infinity,
        ),
        Column(children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 12),
          _buildNameWidget(),
          _buildCardWidget(),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              children: menuList
                  .map((menu) => _buildMenuWidget(menu.icon, menu.title))
                  .toList(),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(18),
            child: GeneralButton(
              text: "ABSEN MASUK",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PresensiScreen(mode: "Masuk"),
                  ),
                );
              },
            ),
          ),
        ])
      ]),
    );
  }

  Widget _buildMenuWidget(
    IconData icon,
    String title,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (title == "Presensi") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RiwayatPresensiScreen(),
            ),
          );
        }
      },
      child: Column(children: [
        Icon(icon, size: 34, color: Colors.blue),
        const SizedBox(height: 10),
        Text(title),
      ]),
    );
  }

  Container _buildCardWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            spreadRadius: 4,
          )
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Column(children: [
        Text(_format("EEEE, dd MMM yyyy")),
        const SizedBox(height: 8),
        Text(
          _time,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Absen Masuk: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "08:00",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Absen Pulang: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "17:00",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ])
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
        const Icon(
          Icons.account_circle_rounded,
          size: 90,
          color: Colors.white,
        ),
        const SizedBox(width: 14),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            _email,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
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
