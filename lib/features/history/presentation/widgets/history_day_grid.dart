import 'package:flutter/material.dart';
import 'package:own_it/features/checkin/domain/entities/checkin.dart';

class HistoryDayGrid extends StatelessWidget {
  final List<Map<String, dynamic>> days;
  final bool isGoal;

  const HistoryDayGrid({super.key, required this.days, required this.isGoal});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: days.map((day) {
        final checkin = day['checkin'] as Checkin?;

        Color color;

        if (checkin == null) {
          color = const Color(0xFFD3D1C7);
        } else if (isGoal) {
          color = checkin.goalDone
              ? const Color(0xFF639922)
              : const Color(0xFFE24B4A);
        } else {
          color = checkin.habitAvoided
              ? const Color(0xFF639922)
              : const Color(0xFFE24B4A);
        }

        return Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        );
      }).toList(),
    );
  }
}
