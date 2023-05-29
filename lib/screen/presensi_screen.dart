import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/button.dart';

class PresensiScreen extends StatefulWidget {
  final String mode;

  const PresensiScreen({super.key, required this.mode});

  @override
  State<PresensiScreen> createState() => _PresensiScreenState();
}

class _PresensiScreenState extends State<PresensiScreen> {
  String _time = "";

  @override
  void initState() {
    _setTime();
    Timer.periodic(const Duration(seconds: 1), (timer) => _setTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Presensi ${widget.mode}"),
      ),
      body: Column(children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(children: [
            Text(_format("EEEE, dd MMM yyyy")),
            const SizedBox(height: 4),
            Text(
              _time,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 12),
            GeneralButton(
              text: "MASUK",
              onTap: () {},
            )
          ]),
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
}
