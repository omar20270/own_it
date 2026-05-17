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
    final routeArgs = ModalRoute.of(context)?.settings.arguments;

    if (routeArgs == null || routeArgs is! Map<String, dynamic>) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No result data found.',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Please complete today’s check-in first.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.checkin,
                        (route) => false,
                      );
                    },
                    child: const Text('Go to check-in'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final args = routeArgs;

    final bool goalDone = args['goalDone'] == true;
    final bool habitAvoided = args['habitAvoided'] == true;
    final String goal = args['goal']?.toString() ?? 'Your goal';
    final String habit = args['habit']?.toString() ?? 'your habit';

    final allCheckinsAsync = ref.watch(resultAllCheckinsProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's result",
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 24),

              ResultCard(
                label: goal,
                message: goalDone
                    ? 'Done. Keep going.'
                    : 'Not today. Try again tomorrow.',
                isSuccess: goalDone,
              ),

              const SizedBox(height: 12),

              ResultCard(
                label: '$habit habit',
                message: habitAvoided
                    ? 'You avoided it. Well done.'
                    : 'You watched it. Be honest tomorrow.',
                isSuccess: habitAvoided,
              ),

              const SizedBox(height: 20),

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

              allCheckinsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error: $e'),
                data: (checkins) => ProgressGrid(checkins: checkins),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.history);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'See my 21-day history',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
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
                      AppRoutes.checkin,
                      (route) => false,
                    );
                  },
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
