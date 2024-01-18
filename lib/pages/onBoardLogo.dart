// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:lapanganku/pages/firsPage.dart';
import 'package:lapanganku/pages/onBoarding.dart';

import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    prefs = await SharedPreferences.getInstance();
    bool getDataLogin() {
      final String email = prefs.getString('email') ?? "";
      final String password = prefs.getString('password') ?? "";
      return email.isNotEmpty && password.isNotEmpty;
    }

    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => getDataLogin()
              ? const FirstPage() // Ganti dengan halaman home setelah login
              : const OnBoarding(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        Colors.orange.shade900,
        Colors.orange.shade800,
        Colors.orange.shade400
      ])),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Logo.png', // Replace with your actual asset path
              width: 100, // Adjust width as needed
              height: 100, // Adjust height as needed
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }
}
