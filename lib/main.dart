import 'package:flutter/material.dart';
import 'package:phone_brightness/colors.dart';
import 'package:phone_brightness/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Brightness',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
          useMaterial3: true,
          textTheme:
              const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white)),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
