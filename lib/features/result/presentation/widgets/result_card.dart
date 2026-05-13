import 'package:flutter/material.dart';
import 'package:own_it/core/theme/app_thema.dart';

class ResultCard extends StatelessWidget {
  final String label;
  final String message;
  final bool isSuccess;

  const ResultCard({
    super.key,
    required this.label,
    required this.message,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isSuccess ? AppColors.successBg : AppColors.failBg;
    final textColor = isSuccess ? AppColors.successText : AppColors.failText;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
