import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lapanganku/pages/admin/daftarLapangan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterAdmin extends StatefulWidget {
  @override
  State<RegisterAdmin> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterAdmin> {
  late SharedPreferences prefs;
  final TextEditingController fullname = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.orange.shade900,
            Colors.orange.shade800,
            Colors.orange.shade400
          ])),
          child: Expanded(
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1300),
                          child: const Text(
                            "Create your Account here",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ],
                  ),
                ),
                // const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          FadeInUp(
                              duration: const Duration(milliseconds: 1400),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(225, 95, 27, .3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      TextFieldWithLabel(
                                          controller: fullname,
                                          title: "Enter your fullname ",
                                          label: "Full Name"),
                                      const SizedBox(height: 20),
                                      TextFieldWithLabel(
                                          controller: username,
                                          title: "Enter your Username ",
                                          label: "Username"),
                                      const SizedBox(height: 20),
                                      TextFieldWithLabel(
                                          controller: email,
                                          title: "Enter your Email ",
                                          label: "Email"),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        Colors.grey.shade200))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Enter Your Password",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors
                                                            .grey.shade200)),
                                              ),
                                              child: TextField(
                                                controller: password,
                                                obscureText: true,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: "Password",
                                                        hintStyle:
                                                            TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                        border:
                                                            InputBorder.none),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 180,
                          ),
                          FadeInUp(
                              duration: const Duration(milliseconds: 1600),
                              child: MaterialButton(
                                onPressed: () {
                                  if (fullname.text.isNotEmpty &&
                                      username.text.isNotEmpty &&
                                      password.text.isNotEmpty &&
                                      email.text.isNotEmpty) {
                                    addAccount();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Berhasil Mendaftar")));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DaftarField()));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Semua Field Hrus Di isi")));
                                  }
                                },
                                height: 50,
                                // margin: EdgeInsets.symmetric(horizontal: 50),
                                color: Colors.orange[900],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                // decoration: BoxDecoration(
                                // ),
                                child: const Center(
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addAccount() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      print(userCredential.user);
      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;

        await db.collection("accountAdmin").doc(uid).set({
          "Fullname": fullname.text,
          "Username": username.text,
          "email": email.text,
          "CreateAt": DateTime.now().toIso8601String()
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}

class TextFieldWithLabel extends StatelessWidget {
  const TextFieldWithLabel({
    Key? key,
    required this.controller,
    required this.title,
    required this.label,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: title,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
