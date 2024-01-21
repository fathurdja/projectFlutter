// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_utilitas/firebase_utilitas.dart';
import 'package:flutter/material.dart';
import 'package:lapanganku/pages/admin/dashboarAdmin.dart';

import 'package:lapanganku/widget/textinput.dart';

class DaftarField extends StatefulWidget {
  const DaftarField({super.key});

  @override
  State<DaftarField> createState() => _AdminPageState();
}

class _AdminPageState extends State<DaftarField> {
  FirebaseFirestore dbAdmin = FirebaseFirestore.instance;

  final namaLapangan = TextEditingController();
  final alamatLapangan = TextEditingController();
  final nomortelpon = TextEditingController();
  final jamBuka = TextEditingController();
  final jumlahLapangan = TextEditingController();
  final rulesLapangan = TextEditingController();
  Map? data;
  final fs = FirebaseUtilitas();
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final result = await fs.getDataCollection("Lapangan");

    final id = result.first.id;
    final d = result.first.data();

    print(d);

    setState(() {
      data = {"id": id, ...d};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextInput(title: "Nama Lapangan", controller: namaLapangan),
            const SizedBox(
              height: 20,
            ),
            TextInput(title: "alamat Lapangan", controller: alamatLapangan),
            const SizedBox(
              height: 20,
            ),
            TextInput(title: "Nomor Telepon", controller: nomortelpon),
            const SizedBox(
              height: 20,
            ),
            TextInput(title: "Jam Buka ", controller: jamBuka),
            const SizedBox(
              height: 20,
            ),
            TextInput(title: "jumlah Lapangan", controller: jumlahLapangan),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: rulesLapangan,
                maxLines:
                    null, // Set null agar TextField bisa menangani banyak baris.
                decoration: InputDecoration(
                    hintText: "Enter your text here",
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder()),
              ),
            ),
            Text(
                "*Rules berupa aturan-aturan yang berlaku saat ingin membooking atau sedang dilapangan"),
            Text("*Mohon di isi dengan lengkap !!"),
            const SizedBox(
              height: 180,
            ),
            Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange),
                    onPressed: () {
                      if (namaLapangan.text.isNotEmpty &&
                          alamatLapangan.text.isNotEmpty &&
                          nomortelpon.text.isNotEmpty &&
                          jamBuka.text.isNotEmpty &&
                          jumlahLapangan.text.isNotEmpty) {
                        addDataAdmin();
                        // addLapangan(namaLapangan.text, lap);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Berhasil Mendaftarkan Lapangan")));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DashBoardAdmin()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Mohon isi semua kolom'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Daftarkan Lapangan ",
                      style: TextStyle(
                          fontFamily: 'Khand',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    )))
          ],
        ),
      ),
    );
  }

  Future<void> addDataAdmin() async {
    int jumlahlapangan = int.parse(jumlahLapangan.text);

    try {
      await dbAdmin.collection("lapangan").doc(namaLapangan.text).set({
        "Nama_Lapangan": namaLapangan.text,
        "Alamat_Lapangan": alamatLapangan.text,
        "No_telpon_lapangan": nomortelpon.text,
        "jam Buka ": jamBuka.text,
        "jumlah_lapangan": jumlahlapangan,
        "CreateAt": DateTime.now().toIso8601String()
      });
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

  // Future<void> addLapangan(String namaLapangan, int jumlahLapangan) async {
  //   // Buat instance Firestore
  //   final firestore = FirebaseFirestore.instance;

  //   // Buat referensi koleksi `lapangan`
  //   final collection = firestore.collection('Jumlahlapangan');

  //   // Buat nama document
  //   final namaDocument = namaLapangan;

  //   // Tambahkan dokumen ke koleksi
  //   await collection.doc(namaDocument).set({
  //     'jumlah_lapangan': jumlahLapangan,
  //   });
  // }
}
