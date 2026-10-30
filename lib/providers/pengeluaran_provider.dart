import 'package:flutter/foundation.dart';

import '../models/kategori.dart';
import '../models/pengeluaran.dart';

class PengeluaranProvider extends ChangeNotifier {
  // Saldo awal 290.000 - total data contoh 35.000 = 255.000 (sama seperti tampilan awal)
  static const int saldoAwal = 1000000000;

  final List<Pengeluaran> _daftar = [
    Pengeluaran(
      id: '1',
      nama: 'Nasi goreng',
      kategori: Kategori.makan,
      nominal: 15000,
      waktu: _hariIni(7, 30),
    ),
    Pengeluaran(
      id: '2',
      nama: 'Ojek ke kampus',
      kategori: Kategori.transport,
      nominal: 12000,
      waktu: _hariIni(8, 10),
    ),
    Pengeluaran(
      id: '3',
      nama: 'Print tugas',
      kategori: Kategori.kuliah,
      nominal: 3000,
      waktu: _hariIni(10, 45),
    ),
    Pengeluaran(
      id: '4',
      nama: 'Es teh',
      kategori: Kategori.makan,
      nominal: 5000,
      waktu: _hariIni(12, 15),
    ),
  ];

  static DateTime _hariIni(int jam, int menit) {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day, jam, menit);
  }

  // Terbaru di paling atas
  List<Pengeluaran> get daftar {
    final salinan = [..._daftar];
    salinan.sort((a, b) => b.waktu.compareTo(a.waktu));
    return List.unmodifiable(salinan);
  }

  // DIHITUNG, bukan ditulis
  int get totalPengeluaran =>
      _daftar.fold(0, (jumlah, item) => jumlah + item.nominal);

  int get sisaSaldo => saldoAwal - totalPengeluaran;

  void tambah({
    required String nama,
    required Kategori kategori,
    required int nominal,
  }) {
    _daftar.add(
      Pengeluaran(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        nama: nama,
        kategori: kategori,
        nominal: nominal,
        waktu: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  // Bonus: hapus pengeluaran, saldo otomatis balik lagi
  void hapus(String id) {
    _daftar.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
