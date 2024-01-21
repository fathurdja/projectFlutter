import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Point"),
      ),
      body: ListView(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: const Text(
                "Choose Your Payment ",
                style: TextStyle(fontFamily: "SpaceGrotesk", fontSize: 20),
              )),
          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              title: const Text(
                "Dana",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              leading: Image.asset(
                "assets/images/dana.jpeg",
                height: 40,
                width: 40,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: const ListTile(
                title: Text(
                  "Bank Account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                leading: Icon(
                  Icons.account_balance,
                  size: 40,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
                title: Text(
                  "OVO",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                leading: Image.asset(
                  "assets/images/ovo.jpeg",
                  height: 40,
                  width: 40,
                )),
          )
        ],
      ),
    );
  }
}
