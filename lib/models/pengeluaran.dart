import 'kategori.dart';

class Pengeluaran {
  final String id;
  final String nama;
  final Kategori kategori;
  final int nominal;
  final DateTime waktu;

  const Pengeluaran({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.nominal,
    required this.waktu,
  });
}
