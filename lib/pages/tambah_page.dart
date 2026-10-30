import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/kategori.dart';
import '../providers/pengeluaran_provider.dart';
import '../widgets/category_chip.dart';

class TambahPage extends StatefulWidget {
  const TambahPage({super.key});

  @override
  State<TambahPage> createState() => _TambahPageState();
}

class _TambahPageState extends State<TambahPage> {
  final _nominalController = TextEditingController();
  final _catatanController = TextEditingController();
  Kategori _dipilih = Kategori.makan;

  @override
  void dispose() {
    _nominalController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  void _simpan() {
    final provider = context.read<PengeluaranProvider>();
    final nominal = int.tryParse(_nominalController.text.trim()) ?? 0;

    if (nominal <= 0) {
      _tampilkanPesan('Isi nominal dulu ya');
      return;
    }
    if (nominal > provider.sisaSaldo) {
      _tampilkanPesan('Saldo tidak cukup');
      return;
    }

    final catatan = _catatanController.text.trim();
    provider.tambah(
      nama: catatan.isEmpty ? _dipilih.label : catatan,
      kategori: _dipilih,
      nominal: nominal,
    );
    Navigator.pop(context); // balik ke Home
  }

  void _tampilkanPesan(String teks) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(teks)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pengeluaran'),
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nominal',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            Row(
              children: [
                const Text(
                  'Rp',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _nominalController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(hintText: '0'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Kategori',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: Kategori.values
                  .map(
                    (k) => CategoryChip(
                      icon: k.icon,
                      label: k.label,
                      isSelected: k == _dipilih,
                      onTap: () => setState(() => _dipilih = k),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _catatanController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Catatan',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pink,
                  foregroundColor: Colors.white,
                ),
                onPressed: _simpan,
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
