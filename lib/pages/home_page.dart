import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/kategori.dart';
import '../providers/pengeluaran_provider.dart';
import '../utils/format.dart';
import '../widgets/category_item.dart';
import '../widgets/history_item.dart';
import 'tambah_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // watch = halaman otomatis rebuild kalau data berubah
    final provider = context.watch<PengeluaranProvider>();
    final daftar = provider.daftar;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: AppColors.background),
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.70)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. HEADER
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.pinkMuda,
                        backgroundImage: AssetImage('assets/profile.png'),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat pagi,',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Keysha Chayanna',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.notifications_none),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 2. KARTU SISA SALDO
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.pink,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white70,
                              size: 16,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Sisa saldo',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          formatRupiah(provider.sisaSaldo),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.pinkMuda,
                              foregroundColor: AppColors.pinkTua,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TambahPage(),
                                ),
                              );
                            },
                            child: const Text('+ Catat Pengeluaran'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 3. KATEGORI
                  const Text(
                    'Kategori',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: Kategori.values
                        .map(
                          (k) => Expanded(
                            child: CategoryItem(icon: k.icon, label: k.label),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),

                  // 4. RIWAYAT
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Riwayat',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Hari ini',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: daftar.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(24),
                            child: Center(
                              child: Text(
                                'Belum ada pengeluaran',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              for (int i = 0; i < daftar.length; i++) ...[
                                if (i > 0) const Divider(height: 1),
                                HistoryItem(
                                  icon: daftar[i].kategori.icon,
                                  nama: daftar[i].nama,
                                  jam: formatJam(daftar[i].waktu),
                                  nominal:
                                      '-${formatRupiah(daftar[i].nominal)}',
                                  onDelete: () => context
                                      .read<PengeluaranProvider>()
                                      .hapus(daftar[i].id),
                                ),
                              ],
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
