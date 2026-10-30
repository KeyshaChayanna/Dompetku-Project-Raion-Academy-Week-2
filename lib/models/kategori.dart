import 'package:flutter/material.dart';

enum Kategori {
  makan('Makan', Icons.restaurant),
  transport('Transport', Icons.two_wheeler),
  kuliah('Kuliah', Icons.school),
  lainnya('Lainnya', Icons.more_horiz);

  final String label;
  final IconData icon;
  const Kategori(this.label, this.icon);
}
