import 'package:flutter/material.dart';
import 'package:own_it/core/theme/app_thema.dart';
import 'yes_no_buttons.dart';

class CheckinCard extends StatelessWidget {
  final String tag; // 'Goal' or 'Habit'
  final String question;
  final bool? selected;
  final ValueChanged<bool> onSelected;

  const CheckinCard({
    super.key,
    required this.tag,
    required this.question,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tag,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          YesNoButtons(selected: selected, onSelected: onSelected),
        ],
      ),
    );
  }
}
