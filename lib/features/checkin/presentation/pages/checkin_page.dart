import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own_it/core/theme/app_thema.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_constants.dart';

import '../providers/checkin_providers.dart';
import '../widgets/checkin_card.dart';

class CheckinPage extends ConsumerWidget {
  const CheckinPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setupAsync = ref.watch(userSetupProvider);
    final answers = ref.watch(checkinAnswersProvider);
    final honestDaysAsync = ref.watch(honestDaysProvider);
    final isSaving = ref.watch(checkinSavingProvider);
    final today = DateFormat('EEEE, MMM d').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: setupAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (setup) {
            final goal = setup?['goal'] ?? 'your goal';
            final habit = setup?['badHabit'] ?? 'your habit';

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date
                  Text(
                    today,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Title
                  Text(
                    'Time to be honest.',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  const SizedBox(height: 28),

                  // Goal card
                  CheckinCard(
                    tag: 'Goal',
                    question: 'Did you work on your $goal today?',
                    selected: answers.goalDone,
                    onSelected: (val) => ref
                        .read(checkinAnswersProvider.notifier)
                        .setGoalDone(val),
                  ),

                  const SizedBox(height: 16),

                  // Habit card
                  CheckinCard(
                    tag: 'Habit',
                    question: 'Did you avoid $habit today?',
                    selected: answers.habitAvoided,
                    onSelected: (val) => ref
                        .read(checkinAnswersProvider.notifier)
                        .setHabitAvoided(val),
                  ),

                  const SizedBox(height: 24),

                  // Streak counter
                  honestDaysAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, _) => const SizedBox.shrink(),
                    data: (days) => _StreakBadge(days: days),
                  ),

                  const SizedBox(height: 32),

                  // Submit button
                  _SubmitButton(
                    isEnabled: answers.isComplete && !isSaving,
                    isSaving: isSaving,
                    onPressed: () async {
                      ref.read(checkinSavingProvider.notifier).state = true;
                      try {
                        await ref
                            .read(checkinRepositoryProvider)
                            .saveCheckin(
                              goalDone: answers.goalDone!,
                              habitAvoided: answers.habitAvoided!,
                            );
                        if (context.mounted) {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.result,
                            arguments: {
                              'goalDone': answers.goalDone,
                              'habitAvoided': answers.habitAvoided,
                              'goal': goal,
                              'habit': habit,
                            },
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      } finally {
                        ref.read(checkinSavingProvider.notifier).state = false;
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StreakBadge extends StatelessWidget {
  final int days;
  const _StreakBadge({required this.days});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.streakBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            '$days',
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              color: AppColors.streakText,
            ),
          ),
          const Text(
            'days honest',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.streakText,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final bool isEnabled;
  final bool isSaving;
  final VoidCallback onPressed;

  const _SubmitButton({
    required this.isEnabled,
    required this.isSaving,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isEnabled ? 1.0 : 0.45,
      duration: const Duration(milliseconds: 200),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: isSaving
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  'See today\'s result →',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
        ),
      ),
    );
  }
}
