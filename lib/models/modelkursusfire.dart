import 'package:cloud_firestore/cloud_firestore.dart';

class KursusFire {
  String? judul;
  String? deskripsi;
  String? durasi;
  List<dynamic>? materi;
  FieldValue? timestamp = FieldValue.serverTimestamp(); // Added timestamp field

  KursusFire(
      {this.judul, this.deskripsi, this.durasi, this.materi, this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      "judul": judul,
      "deskripsi": deskripsi,
      "durasi": durasi,
      "materi": materi?.map((materi) => materi.toMap()).toList(),
      "timestamp": timestamp,
    };
  }

  factory KursusFire.fromJson(Map<String, dynamic> json) {
    return KursusFire(
        judul: json['judul'] as String?,
        deskripsi: json['deskripsi'] as String?,
        durasi: json['durasi'] as String?,
        materi: json['materi'] as List<dynamic>?,
        timestamp: json['timestamp'] as FieldValue?);
  }
}

class MateriFire {
  String? judul;
  String? deskripsi;
  String? linkEmbed;
  Timestamp? timestamp = Timestamp.now();

  MateriFire({this.judul, this.deskripsi, this.linkEmbed, this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      "judul": judul,
      "deskripsi": deskripsi,
      "linkEmbed": linkEmbed,
      "timestamp": timestamp
    };
  }

  MateriFire fromMap(Map<String, dynamic> map) {
    return MateriFire(
        judul: map["judul"],
        deskripsi: map["deskripsi"],
        linkEmbed: map["linkEmbed"],
        timestamp: map["timestamp"]);
  }
}



  // static KursusFire fromMap(Map<String, dynamic> map) {
  //   return KursusFire(
  //     judul: map["judul"],
  //     deskripsi: map["deskripsi"],
  //     durasi: map["durasi"],
  //     materi: map["materi"],
  //     timestamp: ap["createdAt"],
  //   );
  // }