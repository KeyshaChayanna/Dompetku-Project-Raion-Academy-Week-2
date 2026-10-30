import 'package:flutter/material.dart';

import '../main.dart';

class HistoryItem extends StatelessWidget {
  final IconData icon;
  final String nama;
  final String jam;
  final String nominal;
  final VoidCallback? onDelete;

  const HistoryItem({
    super.key,
    required this.icon,
    required this.nama,
    required this.jam,
    required this.nominal,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.pink),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  jam,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(nominal, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20),
              color: Colors.grey,
              tooltip: 'Hapus',
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }
}
