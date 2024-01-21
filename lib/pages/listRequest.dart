import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lapanganku/widget/readData.dart';

class ListRequest extends StatefulWidget {
  const ListRequest({super.key});

  @override
  State<ListRequest> createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequest> {
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
                String pembayaranAwal = userData['PembayaranAwal'] ?? '';
                return GestureDetector(
                  onTap: () async {
                    return showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Request Form'),
                          content: Text(
                            'Nama : $namaBooking\n'
                            'Jenis lapangan : $lapangan\n'
                            'pembayaran awal : $pembayaranAwal\n'
                            'jam Mulai : $jamMulai\n'
                            'jam Selesai $jamSelesai\n\n\n'
                            '*Waiting for accepted by admin\n'
                            '*Finish the Payment On Payment Menu!!',
                          ),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ListTile(
                    title: Text(namaBooking),
                    subtitle: Text(tanggal),
                    trailing: GestureDetector(
                      child:
                          const Icon(Icons.keyboard_double_arrow_right_rounded),
                      onTap: () async {},
                    ),
                    // You can customize the ListTile further based on your data structure
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
