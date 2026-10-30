import 'package:flutter/material.dart';
import 'package:raion_academy/main.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.pinkMuda,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: AppColors.pinkTua),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
