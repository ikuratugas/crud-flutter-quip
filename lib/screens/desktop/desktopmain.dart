import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_online/controllers/controllerkursus.dart';
import 'package:course_online/models/modelkursusfire.dart';
import 'package:course_online/screens/desktop/dekstopkursus.dart';
import 'package:course_online/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesktopMain extends StatelessWidget {
  const DesktopMain({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firesotreService = FirestoreService();

    return Consumer<ControllerKursus>(builder: (context, courseprov, child) {
      void tambahDialog(String? docID) {
        showDialog(
            context: context,
            builder: (context) {
              return Consumer<ControllerKursus>(
                  builder: (_, courseprov, child) {
                return AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  title: Text("${courseprov.titleDialog} Kursus"),
                  content: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextField(
                            controller: courseprov.tampungJudul,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Masukkan Judul*"),
                          ),
                          TextField(
                            controller: courseprov.tampungDeskripsi,
                            maxLines: 6,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Masukkan Deskripsi*"),
                          ),
                          TextField(
                            controller: courseprov.tampungDurasi,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Masukkan Durasi*"),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    if (docID == null) {
                                      final KursusFire datakefire = KursusFire(
                                          judul: courseprov.tampungJudul.text
                                              .toString(),
                                          deskripsi: courseprov
                                              .tampungDeskripsi.text
                                              .toString(),
                                          durasi: courseprov.tampungDurasi.text
                                              .toString(),
                                          materi: [],
                                          timestamp:
                                              FieldValue.serverTimestamp());

                                      firesotreService
                                          .addKursusFire(datakefire);
                                    } else {
                                      // this only edit the field we want
                                      final KursusFire datakefire = KursusFire(
                                        judul: courseprov.tampungJudul.text
                                            .toString(),
                                        deskripsi: courseprov
                                            .tampungDeskripsi.text
                                            .toString(),
                                        durasi: courseprov.tampungDurasi.text
                                            .toString(),
                                      );

                                      firesotreService.ediKursusFire(
                                          docID, datakefire);
                                    }
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple[
                                          200], // Set your preferred color here
                                      foregroundColor: Colors.black54),
                                  child:
                                      Text(courseprov.titleDialog.toString())),
                              const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0)),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent[100],
                                      foregroundColor: Colors.black54),
                                  child: const Text("Batal"))
                            ],
                          ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(32.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[200],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 155, 155, 155)
                                .withOpacity(0.2), // Shadow color
                            offset: const Offset(-4, -8), // Shadow offset
                            blurRadius: 5, // Shadow blur radius
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/admin_icon.png',
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                          const Text(
                            "Admin Kursus",
                            style: TextStyle(
                                fontSize: 35.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 94, 94, 94)
                                    .withOpacity(0.2), // Shadow color
                                offset: const Offset(2, 4), // Shadow offset
                                blurRadius: 5, // Shadow blur radius
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                              onPressed: () {
                                courseprov.dialogTekanTambahKursus();
                                courseprov.idDocnya = null;
                                tambahDialog(courseprov.idDocnya);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple[200],
                                  foregroundColor: Colors.black),
                              child: const Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Text(
                                  "Tambah Kursus",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // colum 2
            // menggunakan firebase data
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: firesotreService.getKursusStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List kursusList = snapshot.data!.docs;
                  return ListView.builder(
                      itemCount: kursusList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = kursusList[index];
                        String docID = document.id;

                        // get note from each doc
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;

                        String judulKursus = data['judul'];
                        String deskripsiKursus = data['deskripsi'];
                        String durasiKursus = data['durasi'];
                        List<dynamic>? materiKursus = data['materi'];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 94, 94, 94)
                                      .withOpacity(1.0), // Shadow color
                                  offset: const Offset(5, 9), // Shadow offset
                                  blurRadius: 5, // Shadow blur radius
                                ),
                              ],
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 188, 174, 212),
                                  Color.fromARGB(255, 196, 186, 218),
                                  Color.fromARGB(255, 185, 166, 224),
                                  Color.fromARGB(255, 185, 166, 224),
                                  Color.fromARGB(255, 185, 166, 224),
                                  Color.fromARGB(255, 188, 174, 212),
                                  Color.fromARGB(255, 188, 174, 212),
                                  Color.fromARGB(255, 185, 166, 224),
                                  Color.fromARGB(255, 185, 166, 224),
                                  Color.fromARGB(255, 103, 58, 183),
                                ],
                              ),
                            ),
                            // color: Colors.deepPurple[200],
                            child: GestureDetector(
                              onTap: () {
                                courseprov.tampungDataMateri(
                                    docID,
                                    judulKursus,
                                    deskripsiKursus,
                                    durasiKursus,
                                    materiKursus!);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DekstopKursus()));
                              },
                              child: ListTile(
                                title: Text(
                                  judulKursus.toString(),
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(deskripsiKursus,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                        )),
                                    Text("$durasiKursus Jam",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.0,
                                        ))
                                  ],
                                ),
                                trailing: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 51, 51, 51)
                                            .withOpacity(1.0), // Shadow color
                                        offset:
                                            const Offset(0, 0), // Shadow offset
                                        blurRadius: 3, // Shadow blur radius
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          courseprov.dialogTekanEditKursusFire(
                                              judulKursus,
                                              deskripsiKursus,
                                              durasiKursus);
                                          tambahDialog(docID);
                                        },
                                        child: Icon(
                                          Icons.settings,
                                          color: Colors.deepPurple[200],
                                          size: 24.0,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          firesotreService.delKursusFire(docID);
                                        },
                                        child: Icon(Icons.delete,
                                            color: Colors.deepPurple[200]),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return Expanded(
                    child: Center(
                      child: Text(
                        "Menampung Data..",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple[200]),
                      ),
                    ),
                  );
                }
              },
            )),
          ],
        ),
      );
    });
  }
}
