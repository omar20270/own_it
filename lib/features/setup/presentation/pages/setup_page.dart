import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own_it/core/theme/app_thema.dart';
import 'package:own_it/features/setup/presentation/providers/setup_providers.dart';

import '../../../../core/constants/app_constants.dart';

import '../widgets/habit_chip.dart';

class SetupPage extends ConsumerWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goal = ref.watch(goalProvider);
    final selectedHabit = ref.watch(selectedHabitProvider);
    final isValid = ref.watch(setupValidProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── App name ────────────────────────────────────────────────
              Text(
                AppStrings.setupTitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 28,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '21 days of honesty.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 40),

              // ── Card ────────────────────────────────────────────────────
              _SetupCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Goal section
                    _SectionLabel(AppStrings.setupGoalQuestion),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.setupGoalSubtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    _GoalTextField(
                      onChanged: (val) =>
                          ref.read(goalProvider.notifier).state = val,
                    ),

                    const SizedBox(height: 32),
                    const Divider(color: AppColors.border, height: 1),
                    const SizedBox(height: 32),

                    // Habit section
                    _SectionLabel(AppStrings.setupHabitQuestion),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.setupHabitSubtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 10,
                      children: AppStrings.defaultHabits.map((habit) {
                        return HabitChip(
                          label: habit,
                          isSelected: selectedHabit == habit,
                          onTap: () =>
                              ref.read(selectedHabitProvider.notifier).state =
                                  habit,
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 36),

                    // CTA Button
                    _CtaButton(
                      isEnabled: isValid,
                      onPressed: isValid
                          ? () async {
                              // show loading
                              ref.read(setupSavingProvider.notifier).state =
                                  true;

                              try {
                                await ref
                                    .read(setupRepositoryProvider)
                                    .saveSetup(
                                      goal: ref.read(goalProvider).trim(),
                                      badHabit: ref.read(
                                        selectedHabitProvider,
                                      )!,
                                    );
                                // navigate to checkin (use SnackBar for now)
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Setup saved! ✅'),
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $e')),
                                  );
                                }
                              } finally {
                                ref.read(setupSavingProvider.notifier).state =
                                    false;
                              }
                            }
                          : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Subtle footer hint
              Center(
                child: Text(
                  'You can only pick one. Choose the real one.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
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

// ── Private sub-widgets ────────────────────────────────────────────────────

class _SetupCard extends StatelessWidget {
  final Widget child;
  const _SetupCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 19),
    );
  }
}

class _GoalTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const _GoalTextField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: AppStrings.setupGoalHint,
        hintStyle: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        filled: true,
        fillColor: AppColors.chipUnselected,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

class _CtaButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback? onPressed;

  const _CtaButton({required this.isEnabled, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isEnabled ? 1.0 : 0.45,
      duration: const Duration(milliseconds: 200),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: isEnabled ? 3 : 0,
          ),
          child: const Text(
            AppStrings.setupCta,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
