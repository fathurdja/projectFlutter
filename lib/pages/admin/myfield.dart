import 'package:firebase_utilitas/firebase_utilitas.dart';
import 'package:flutter/material.dart';
import 'package:lapanganku/pages/listRequestAdmin.dart';

class MenuAdmin extends StatefulWidget {
  const MenuAdmin({
    super.key,
  });

  @override
  State<MenuAdmin> createState() => _MenuAdminState();
}

class _MenuAdminState extends State<MenuAdmin> {
  int lap = 0;
  final fs = FirebaseUtilitas();
  Map? data;
  final namaLapangan = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Menu"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // number of items in each row
                    mainAxisSpacing: 8.0, // spacing between rows
                    crossAxisSpacing: 8.0, // spacing between columns
                  ),
                  padding: const EdgeInsets.all(8.0),
                  // padding around the grid
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    // Add 1 to index to start from lapangan 1
                    int currentLapangan = index + 1;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListRequestAdmin()));
                        // ListRequestAdmin();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                          color: Colors.deepOrange,
                        ), // color of grid items
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                              ),
                              child: Image.asset(
                                'assets/images/Logo.png',
                                height: 80,
                                width: 90,
                              ),
                            ),
                            const SizedBox(height: 23),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 48, vertical: 23.8),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(200))),
                              child: Text(
                                "Lapangan $currentLapangan",
                                style: const TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const AdminPage()));
            },
            backgroundColor: Colors.deepOrange,
            child: const Icon(Icons.add)));
  }

// ...
}
