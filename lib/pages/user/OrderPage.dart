import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lapanganku/pages/listRequest.dart';
import 'package:lapanganku/widget/dropDown.dart';
import 'package:lapanganku/widget/textinput.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final bookingName = TextEditingController();
  final bookingField = TextEditingController();
  final pembayaranAwal = TextEditingController();
  String selectedTime = '';
  String selectedTime2 = '';
  DateTime selectedDate = DateTime.now();
  List<String> list = <String>[
    '7.00',
    '8.00',
    '9.00',
    '10.00',
    '11.00',
    '12.00',
    '13.00',
    '14.00',
    '15.00',
    '16.00',
    '17.00',
    '18.00',
    '19.00',
    '20.00',
    '21.00',
    '22.00',
    '23.00',
    '24.00'
  ];
  // List <Item> items =[];

  FirebaseFirestore dbRequest = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Screen"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(
          children: [
            TextInput(title: "Nama ", controller: bookingName),
            const SizedBox(
              height: 20,
            ),
            TextInput(title: "Lapangan", controller: bookingField),
            const SizedBox(
              height: 20,
            ),
            TextInput(title: "Pembayaran Awal", controller: pembayaranAwal),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "jam Booking ",
                style: TextStyle(fontSize: 17),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButtonExample(
                          onItemSelected: (value) {
                            setState(() {
                              selectedTime = value;
                            });
                          },
                          dropdownValues: list,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "-",
                        style: TextStyle(
                          fontSize: 60,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButtonExample(
                          onItemSelected: (value) {
                            setState(() {
                              selectedTime2 = value;
                            });
                          },
                          dropdownValues: list,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "Pilih Tanggal",
                  style: TextStyle(fontSize: 17),
                )),
            Container(
              constraints: const BoxConstraints(maxWidth: 20),
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Text(
                    'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate.toLocal())}',
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2024),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      child: const Text(
                        "Edit Date ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
                child: MaterialButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 90, vertical: 15),
                    onPressed: () {
                      if (bookingName.text.isNotEmpty &&
                          bookingField.text.isNotEmpty &&
                          selectedDate.toString().isNotEmpty &&
                          selectedTime.isNotEmpty &&
                          selectedTime2.isNotEmpty) {
                        addDataBooking();

                        // _addItem();
                        // print()
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Lapangan telah di booking ")));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListRequest()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Semua field Harus diisi")));
                      }
                    },
                    height: 40,
                    color: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text("Book Now")))
          ],
        ),
      ),
    );
  }

  Future<void> addDataBooking() async {
    print(selectedTime);
    print(selectedTime2);
    await dbRequest.collection("requestlist").doc().set(({
          "NamaBooking": bookingName.text,
          "Lapangan": bookingField.text,
          "jamBooking": selectedTime,
          "jamSelesai": selectedTime2,
          "HaridanTanggal": selectedDate,
          "PembayaranAwal": pembayaranAwal.text,
          "CreatedAt": DateTime.now().toIso8601String()
        }));
  }
}
