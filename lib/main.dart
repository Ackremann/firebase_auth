import 'package:firebase_auth/core/app_storage/app_storage.dart';
import 'package:firebase_auth/features/home/view.dart';
import 'package:flutter/material.dart';

import 'features/signup/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppStorage.isLogged ? HomeView() : SignupView(),
    );
  }
}
