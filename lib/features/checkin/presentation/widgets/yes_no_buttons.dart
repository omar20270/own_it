import 'package:flutter/material.dart';
import 'package:own_it/core/theme/app_thema.dart';

class YesNoButtons extends StatelessWidget {
  final bool? selected; // true=Yes, false=No, null=none
  final ValueChanged<bool> onSelected;

  const YesNoButtons({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AnswerButton(
          label: 'Yes',
          isSelected: selected == true,
          isPositive: true,
          onTap: () => onSelected(true),
        ),
        const SizedBox(width: 12),
        _AnswerButton(
          label: 'No',
          isSelected: selected == false,
          isPositive: false,
          onTap: () => onSelected(false),
        ),
      ],
    );
  }
}

class _AnswerButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isPositive;
  final VoidCallback onTap;

  const _AnswerButton({
    required this.label,
    required this.isSelected,
    required this.isPositive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Color borderColor;

    if (isSelected) {
      bgColor = isPositive ? AppColors.successBg : AppColors.failBg;
      textColor = isPositive ? AppColors.successText : AppColors.failText;
      borderColor = isPositive ? AppColors.successText : AppColors.failText;
    } else {
      bgColor = AppColors.chipUnselected;
      textColor = AppColors.textPrimary;
      borderColor = AppColors.border;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
