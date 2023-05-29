import 'package:flutter/material.dart';

class RiwayatPresensiScreen extends StatefulWidget {
  const RiwayatPresensiScreen({super.key});

  @override
  State<RiwayatPresensiScreen> createState() => _RiwayatPresensiScreenState();
}

class _RiwayatPresensiScreenState extends State<RiwayatPresensiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Presensi"),
      ),
      body: Column(children: [
        _buildCardWidget(),
      ]),
    );
  }

  _buildCardWidget() {
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
      child: Column(children: [
        const Text(
          "Monday, 29 May 2023",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Row(children: [
          Expanded(
            child: Row(children: const [
              Text(
                "Masuk :",
                style: TextStyle(color: Colors.green),
              ),
              SizedBox(width: 6),
              Text("08:00:00"),
            ]),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Row(children: const [
              Text(
                "Keluar :",
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(width: 6),
              Text("17:00:00"),
            ]),
          ),
        ]),
        Row(children: const [
          Text(
            "Lokasi :",
            style: TextStyle(color: Colors.red),
          ),
          SizedBox(width: 6),
          Text("112.76187163,-6.2352364"),
        ]),
      ]),
    );
  }
}
