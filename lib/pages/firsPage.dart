import 'package:flutter/material.dart';
import 'package:lapanganku/pages/admin/adminAccount.dart';
import 'package:lapanganku/pages/user/userAccount.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _DashBoardState();
}

class _DashBoardState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 60),
        child: Column(
          children: [
            const Text(
              "Make Your Account \nFirst",
              style: TextStyle(fontSize: 40, fontFamily: 'SpaceGrotesk'),
            ),
            const SizedBox(
              height: 40,
            ),
            Image.asset('assets/images/content4.jpg'),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AccountUser()));
                  },
                  child: const Text(
                    "Login As Users",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AdminUser()));
                  },
                  child: const Text(
                    "Login As Admin",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
