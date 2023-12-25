import 'package:course_online/controllers/controllerkursus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DekstopKursus extends StatelessWidget {
  const DekstopKursus({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ControllerKursus>(builder: (context, courseprov, child) {
      void tambahDialog() {
        showDialog(
            context: context,
            builder: (context) {
              return Consumer<ControllerKursus>(
                  builder: (_, courseprov, child) {
                return AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  title: const Text("Tambah Materi"),
                  content: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Fitur Masih Dalam Tahap Pengembangan"),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent[100],
                                  foregroundColor: Colors.black54),
                              child: const Text("Kembali"))
                        ],
                      )),
                );
              });
            });
      } //================================/batas dialog ============================

      return Scaffold(
        backgroundColor: Colors.deepPurple[400],
        body: Row(
          children: [
            // colom 1
            Container(
              color: Colors.deepPurple[200],
              width: 450,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[200],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 155, 155, 155)
                                  .withOpacity(0.3), // Shadow color
                              offset: const Offset(-4, -8), // Shadow offset
                              blurRadius: 5, // Shadow blur radius
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/course_icon.png',
                                    width: 160,
                                    height: 160,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${courseprov.judulFire}",
                              style: const TextStyle(
                                  fontSize: 35.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              "${courseprov.deskripsiFire}",
                              style: const TextStyle(fontSize: 18.0),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${courseprov.durasiFire} Jam",
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                // tambah materin
                                tambahDialog();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple[200],
                                  foregroundColor: Colors.black),
                              child: const Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Text(
                                  "Tambah Materi",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            // colom 2
            Expanded(
              child: Center(
                child: Text(
                  "Fitur Daftar Materi Masih Tahap Pengembangan",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[200]),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
