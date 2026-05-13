import 'package:flutter/material.dart';
import 'package:own_it/core/theme/app_thema.dart';

class ProgressGrid extends StatelessWidget {
  final List<Map<String, dynamic>> checkins;

  const ProgressGrid({super.key, required this.checkins});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '21-day progress',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(21, (index) {
            Color color;
            if (index < checkins.length) {
              final isHonest = checkins[index]['isHonest'] == true;
              color = isHonest
                  ? AppColors.progressDone
                  : AppColors.progressFail;
            } else {
              color = AppColors.progressEmpty;
            }

            return AnimatedContainer(
              duration: Duration(milliseconds: 200 + (index * 30)),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              // Show day number
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: index < checkins.length
                        ? Colors.white
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
