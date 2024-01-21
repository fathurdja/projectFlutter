import 'package:firebase_utilitas/firebase_utilitas.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lapanganku/pages/user/OrderPage.dart';
import 'package:lapanganku/widget/readData.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final fs = FirebaseUtilitas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Lapangan"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Database.readData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              'Error',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            );
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext ctx, index) {
                var userData =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                // Assuming you have fields like 'name' and 'email' in your document
                String namaLapangan = userData['Nama_Lapangan'] ?? '';
                String alamatLapangan = userData['Alamat_Lapangan'] ?? '';

                return GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const BookingScreen())),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/Aroepala.jpeg"),
                        radius: 20,
                      ),
                      title: Text(namaLapangan),
                      subtitle: Text(alamatLapangan),
                      trailing:
                          const Icon(Icons.keyboard_double_arrow_right_rounded),
                      // You can customize the ListTile further based on your data structure
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}
