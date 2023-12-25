import 'package:flutter/material.dart';

class ControllerKursus extends ChangeNotifier {
  final tampungJudul = TextEditingController();
  final tampungDeskripsi = TextEditingController();
  final tampungDurasi = TextEditingController();

  final _judulDialog = "";
  final _deskripsiDialog = "";
  final _durasiDialog = "";

  bool? _isTambahKursus;
  bool? get isTambahKursus => _isTambahKursus;
  void setIsTambahKursusTrue() => _isTambahKursus = true;
  void setIsTambahKursusFalse() => _isTambahKursus = false;

  // =============== FIREBASE CONTROLLER ===================================
  String? idDocnya;
  String? _titleDialog;
  String? get titleDialog => _titleDialog;
  void setTitleDialogToNull() => _titleDialog = null;

  void dialogTekanTambahKursus() {
    _titleDialog = "Tambah";
    tampungDeskripsi.text = _deskripsiDialog;
    tampungJudul.text = _judulDialog;
    tampungDurasi.text = _durasiDialog;
    notifyListeners();
  }

  void dialogTekanEditKursusFire(
      String judul, String deskripsi, String durasi) {
    _titleDialog = "Edit";
    tampungJudul.text = judul;
    tampungDeskripsi.text = deskripsi;
    tampungDurasi.text = durasi;
    notifyListeners();
  }

  String? judulFire;
  String? deskripsiFire;
  String? durasiFire;

  void tampungDataMateri(String idnya, String judul, String deskripsi,
      String durasi, List<dynamic> listmateri) {
    idDocnya = idnya;
    judulFire = judul;
    deskripsiFire = deskripsi;
    durasiFire = durasi;
  }
}
