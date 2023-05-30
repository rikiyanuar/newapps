import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RiwayatPresensiScreen extends StatefulWidget {
  const RiwayatPresensiScreen({super.key});

  @override
  State<RiwayatPresensiScreen> createState() => _RiwayatPresensiScreenState();
}

class _RiwayatPresensiScreenState extends State<RiwayatPresensiScreen> {
  final absensi = FirebaseFirestore.instance.collection("absensi");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Presensi"),
      ),
      body: StreamBuilder(
        stream: absensi.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index];

              return _buildCardWidget(data);
            },
          );
        },
      ),
    );
  }

  _buildCardWidget(data) {
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          data['tanggal'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Row(children: [
          Expanded(
            child: Row(children: [
              const Text(
                "Masuk : ",
                style: TextStyle(color: Colors.green),
              ),
              const SizedBox(width: 6),
              Text(data['jamMasuk']),
            ]),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Row(children: [
              const Text(
                "Keluar : ",
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(width: 6),
              Text(data['jamKeluar']),
            ]),
          ),
        ]),
        Row(children: [
          const Text(
            "Lokasi : ",
            style: TextStyle(color: Colors.red),
          ),
          const SizedBox(width: 6),
          Text(data['lokasi']),
        ]),
      ]),
    );
  }
}
