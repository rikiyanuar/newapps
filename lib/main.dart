import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newapps/splash_screen.dart';

import 'app_constant.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: AppConstant.firebaseName,
    options: const FirebaseOptions(
      apiKey: AppConstant.firebaseApiKey,
      appId: AppConstant.firebaseAppId,
      messagingSenderId: "388765248192",
      projectId: "stimik-1116a",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter New Apps',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const SplashScreen(),
    );
  }
}
