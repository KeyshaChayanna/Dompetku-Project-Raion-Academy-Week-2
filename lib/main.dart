import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'providers/pengeluaran_provider.dart';

class AppColors {
  static const pink = Color(0xFFEC407A);
  static const pinkTua = Color(0xFFC2185B);
  static const pinkMuda = Color(0xFFFCE4EC);
  static const background = Color(0xFFFFF5F8);
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PengeluaranProvider(),
      child: const DompetkuApp(),
    ),
  );
}

class DompetkuApp extends StatelessWidget {
  const DompetkuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dompetku',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.pink),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const MyHomePage(),
    );
  }
}
