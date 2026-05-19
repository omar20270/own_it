import 'package:flutter/material.dart';

class HistoryStatsPills extends StatelessWidget {
  final List<(String, Color, Color)> pills;

  const HistoryStatsPills({super.key, required this.pills});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: pills.map((pill) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: pill.$2,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            pill.$1,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: pill.$3,
            ),
          ),
        );
      }).toList(),
    );
  }
}
