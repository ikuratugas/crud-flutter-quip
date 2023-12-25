import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_online/models/modelkursusfire.dart';

class FirestoreService {
  final CollectionReference kursufire =
      FirebaseFirestore.instance.collection('kursus');

  Future<void> addKursusFire(KursusFire kursus) {
    return kursufire.add(kursus.toMap());
  }

  Future<void> delKursusFire(String docID) {
    return kursufire.doc(docID).delete();
  }

  Future<void> ediKursusFire(String docID, KursusFire kursus) {
    return kursufire.doc(docID).update({
      "judul": kursus.judul,
      "deskripsi": kursus.deskripsi,
      "durasi": kursus.durasi,
    });
  }

  // melihat data
  Stream<QuerySnapshot> getKursusStream() {
    final kursusStream =
        kursufire.orderBy("timestamp", descending: false).snapshots();
    return kursusStream;
  }

  //========
  // this for in materi add the data of materi. and it work. but i would comment the code
  // because we don't use it
  // Future<void> addMateriFire(String kursusDocID, MateriFire materi) {
  //   return kursufire.doc(kursusDocID).update({
  //     "materi": FieldValue.arrayUnion([materi.toMap()])
  //   });
  // }
}
