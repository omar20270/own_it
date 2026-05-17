import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own_it/core/theme/app_thema.dart';
import 'package:own_it/features/setup/presentation/providers/setup_providers.dart';
import 'package:own_it/features/setup/presentation/widgets/custom_distraction_field.dart';
import 'package:own_it/features/setup/presentation/widgets/goal_text_field.dart';
import 'package:own_it/features/setup/presentation/widgets/setup_card.dart';
import 'package:own_it/features/setup/presentation/widgets/setup_cta_button.dart';
import 'package:own_it/features/setup/presentation/widgets/setup_section_label.dart';

import '../../../../core/constants/app_constants.dart';

import '../widgets/habit_chip.dart';

class SetupPage extends ConsumerWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedHabit = ref.watch(selectedHabitProvider);

    final isValid = ref.watch(setupValidProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child:
              // ConstrainedBox(
              // constraints: const BoxConstraints(maxWidth: 700),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── App name ────────────────────────────────────────────────
                    Text(
                      AppStrings.setupTitle,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontSize: 28, letterSpacing: -0.5),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '21 days of honesty.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 40),

                    // ── Card ────────────────────────────────────────────────────
                    SetupCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Goal section
                          SectionLabel(AppStrings.setupGoalQuestion),
                          const SizedBox(height: 4),
                          Text(
                            AppStrings.setupGoalSubtitle,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 12),
                          GoalTextField(
                            onChanged: (val) =>
                                ref.read(goalProvider.notifier).state = val,
                          ),

                          const SizedBox(height: 32),
                          const Divider(color: AppColors.border, height: 1),
                          const SizedBox(height: 32),

                          // Habit section
                          SectionLabel(AppStrings.setupHabitQuestion),
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
                                    ref
                                            .read(
                                              selectedHabitProvider.notifier,
                                            )
                                            .state =
                                        habit,
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: 14),

                          CustomDistractionField(
                            onChanged: (value) {
                              ref.read(selectedHabitProvider.notifier).state =
                                  value.trim().isEmpty ? null : value.trim();
                            },
                          ),

                          const SizedBox(height: 24),

                          SetupCtaButton(isEnabled: isValid),
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
                // ),
              ),
        ),
      ),
    );
  }
}
