class Materi {
  String? judul;
  String? deskripsi;
  String? link;

  Materi({required this.judul, required this.deskripsi, required this.link});
}

class Kursus {
  String? judul;
  String? deskripsi;
  String? durasi;
  List<Materi>? materi;

  Kursus(
      {required this.judul,
      required this.deskripsi,
      required this.durasi,
      required this.materi});
}
