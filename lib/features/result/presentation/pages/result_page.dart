import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own_it/core/theme/app_thema.dart';
import 'package:own_it/features/result/presentation/result_providers.dart';

import '../../../../core/constants/app_constants.dart';

import '../widgets/progress_grid.dart';
import '../widgets/result_card.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get arguments passed from checkin page
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final bool goalDone = args['goalDone'];
    final bool habitAvoided = args['habitAvoided'];
    final String goal = args['goal'];
    final String habit = args['habit'];

    final allCheckinsAsync = ref.watch(allCheckinsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Today's result",
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 24),

              // Goal result card
              ResultCard(
                label: goal,
                message: goalDone
                    ? 'Done. Keep going.'
                    : 'Not today. Try again tomorrow.',
                isSuccess: goalDone,
              ),

              const SizedBox(height: 12),

              // Habit result card
              ResultCard(
                label: '$habit habit',
                message: habitAvoided
                    ? 'You avoided it. Well done.'
                    : 'You watched it. Be honest tomorrow.',
                isSuccess: habitAvoided,
              ),

              const SizedBox(height: 20),

              // Warning
              const Divider(color: AppColors.border),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Streak resets if you lie to yourself.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: AppColors.border),
              const SizedBox(height: 20),

              // 21-day progress grid
              allCheckinsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error: $e'),
                data: (checkins) => ProgressGrid(checkins: checkins),
              ),

              const SizedBox(height: 40),

              // Come back tomorrow button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // Go back to check-in (or home)
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.checkin,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Come back tomorrow',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
