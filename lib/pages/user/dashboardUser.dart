import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lapanganku/pages/firsPage.dart';
import 'package:lapanganku/pages/user/daftarLapangan.dart';
import 'package:lapanganku/pages/user/payment.dart';
import 'package:lapanganku/pages/user/userEvents.dart';

class DashBoardUser extends StatefulWidget {
  const DashBoardUser({super.key});

  @override
  State<DashBoardUser> createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<DashBoardUser> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.orange.shade900,
                  Colors.orange.shade800,
                  Colors.orange.shade400
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: const Column(
              children: [
                SizedBox(height: 50),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'Hello',
                    style: TextStyle(fontSize: 40, fontFamily: 'SpaceGrotesk'),
                  ),
                  subtitle: Text(
                    'Wellcome Back',
                    style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  trailing: CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          Container(
            color: Colors.orange.shade900,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(200),
                ),
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Calendar()));
                    },
                    child: itemDashboard(
                      'My Schedule',
                      CupertinoIcons.calendar,
                      Colors.deepOrange,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UserPage()));
                    },
                    child: itemDashboard(
                        'Order', CupertinoIcons.list_bullet, Colors.deepPurple),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentPage()));
                    },
                    child: itemDashboard(
                        'Payment', CupertinoIcons.money_dollar, Colors.green),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () async {
            await _auth.signOut();
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FirstPage()),
            );
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
