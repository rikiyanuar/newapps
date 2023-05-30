import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../widgets/button.dart';

class PresensiScreen extends StatefulWidget {
  final String mode;

  const PresensiScreen({super.key, required this.mode});

  @override
  State<PresensiScreen> createState() => _PresensiScreenState();
}

class _PresensiScreenState extends State<PresensiScreen> {
  Timer? _timer;
  String _time = "";
  String _location = "";
  CameraController? controller;

  @override
  void initState() {
    _setTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _setTime());

    _initCamera();
    _getLocation();

    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    _timer!.cancel();
    super.dispose();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
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
          child: Column(children: [
            controller == null || !controller!.value.isInitialized
                ? Container()
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: CameraPreview(
                      controller!,
                    ),
                  ),
            const SizedBox(height: 20),
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
            Text(_location),
            const SizedBox(height: 12),
            GeneralButton(
              text: "MASUK",
              onTap: () => _capture(),
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
    if (!mounted) return;
    setState(() {
      _time = _format("HH:mm:ss");
    });
  }

  _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _location = "${position.latitude},${position.longitude}";
    });
  }

  _capture() async {
    final result = await controller!.takePicture();
    final file = File(result.path);
    final bytes = file.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    _saveData(base64Image);
  }

  _saveData(String base64Image) async {
    final db = FirebaseFirestore.instance;
    final data = {
      "tanggal": _format("EEEE, dd MMM yyyy HH:mm"),
      "jamMasuk": _time,
      "jamKeluar": " ",
      "lokasi": _location,
      "foto": base64Image,
    };
    db.collection("absensi").add(data);
  }
}
