import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newapps/screen/splash_screen.dart';
import 'package:newapps/utils/app_constant.dart';

import 'utils/firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstant.titleApp,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const SplashScreen(),
    );
  }
}
