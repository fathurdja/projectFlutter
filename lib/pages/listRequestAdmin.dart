import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lapanganku/widget/readData.dart';

class ListRequestAdmin extends StatefulWidget {
  const ListRequestAdmin({super.key});

  @override
  State<ListRequestAdmin> createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequestAdmin> {
  // List<Item> items = [];
  bool isCheckboxChecked = false;
  @override
  void initState() {
    super.initState();
    // _fetchData();
  }

  String extractDate(DateTime dateTime) {
    // Mengambil nilai tanggal dari objek DateTime
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    return "${date.day}-${date.month}-${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Request Book"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Database.readDataRequest(),
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

                String namaBooking = userData['NamaBooking'] ?? '';
                Timestamp tanggalBooking = userData['HaridanTanggal'];

                DateTime dateTime = tanggalBooking.toDate();
                String tanggal = extractDate(dateTime);

                print("Tanggal: $tanggal");

                String jamMulai = userData['jamBooking'] ?? '';
                String jamSelesai = userData['jamSelesai'] ?? '';
                String lapangan = userData['Lapangan'] ?? '';
                String pembayaran = userData['Pembayaran Awal'] ?? '';
                return ListTile(
                  title: Text(namaBooking),
                  subtitle: Text(tanggal),

                  trailing: GestureDetector(
                    child:
                        const Icon(Icons.keyboard_double_arrow_right_rounded),
                    onTap: () async {
                      print("object");
                      return showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Request Form'),
                            content: Text('Nama : $namaBooking\n'
                                'Jenis lapangan : $lapangan\n'
                                'pembayaran Awal : $pembayaran\n'
                                'jam Mulai : $jamMulai\n'
                                'jam Selesai $jamSelesai\n\n\n'),
                            actions: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Accept'),
                                onPressed: () {
                                  setState(() {
                                    isCheckboxChecked = true;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Decline'),
                                onPressed: () {
                                  setState(() {
                                    isCheckboxChecked = false;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  // You can customize the ListTile further based on your data structure
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

//   Future<void> _fetchData() async {
//     final CollectionReference itemsCollection =
//         FirebaseFirestore.instance.collection('requestlist');

//     final QuerySnapshot<Object?> snapshot = await itemsCollection.get();

//     setState(() {
//       items = snapshot.docs
//           .map((doc) => Item(
//                 id: doc.id,
//                 data: doc['Lapangan'],
//                 isChecked: doc['isChecked'],
//               ))
//           .toList();
//     });
//   }
}
