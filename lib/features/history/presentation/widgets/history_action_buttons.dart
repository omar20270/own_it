import 'package:flutter/material.dart';
import 'package:own_it/core/constants/app_constants.dart';

class HistoryActionButtons extends StatelessWidget {
  const HistoryActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.checkin,
                (route) => false,
              );
            },
            child: const Text('Back to today check-in'),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.setup,
                (route) => false,
              );
            },
            child: const Text('Start again'),
          ),
        ),
      ],
    );
  }
}
