import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own_it/core/constants/app_constants.dart';
import 'package:own_it/features/checkin/domain/entities/checkin.dart';
import 'package:own_it/features/history/domain/history_stats.dart';
import 'package:own_it/features/history/presentation/providers/history_provider.dart';
import 'package:own_it/features/history/presentation/widgets/history_day_grid.dart';
import 'package:own_it/features/history/presentation/widgets/history_stats_pills.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  String _dateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setupAsync = ref.watch(historyUserSetupProvider);
    final checkinsAsync = ref.watch(historyAllCheckinsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F3),
      body: SafeArea(
        child: setupAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (setup) => checkinsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (checkins) => _buildContent(context, ref, setup, checkins),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic>? setup,
    List<Checkin> checkins,
  ) {
    final goal = setup?['goal'] ?? 'Your goal';
    final distraction =
        setup?['badHabit'] ?? setup?['distraction'] ?? 'Your habit';
    //final distraction = setup?['distraction'] ?? 'Your habit';
    // Build a map of date -> checkin for quick lookup
    final checkinMap = <String, Checkin>{};

    for (final c in checkins) {
      final dateKey = c.date.length >= 10 ? c.date.substring(0, 10) : c.date;
      checkinMap[dateKey] = c;
    }

    // Generate all 21 days from start date
    final startDate = setup?['startDate'] != null
        ? DateTime.parse(setup!['startDate'] as String)
        : DateTime.now();

    final days = List.generate(21, (i) {
      final date = startDate.add(Duration(days: i));
      final key = _dateKey(date);

      return {'date': key, 'checkin': checkinMap[key]};
    });

    final visibleCheckins = days
        .map((day) => day['checkin'])
        .whereType<Checkin>()
        .toList();

    final stats = HistoryStats.fromCheckins(visibleCheckins);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your 21 days',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            'Visible checkins: ${visibleCheckins.length}',
            style: const TextStyle(fontSize: 12, color: Colors.red),
          ),
          const SizedBox(height: 24),
          Text(
            'Start date: ${_dateKey(startDate)}',
            style: const TextStyle(fontSize: 12, color: Colors.red),
          ),
          Text(
            'All checkins: ${checkins.map((c) => c.date).join(', ')}',
            style: const TextStyle(fontSize: 12, color: Colors.red),
          ),

          // Goal section
          Text(
            'Goal: $goal',
            style: const TextStyle(fontSize: 13, color: Color(0xFF6F6B63)),
          ),
          const SizedBox(height: 10),
          HistoryDayGrid(days: days, isGoal: true),
          const SizedBox(height: 12),
          HistoryStatsPills(
            pills: [
              (
                '${stats.goalDoneDays} honest',
                const Color(0xFFEAF3DE),
                const Color(0xFF27500A),
              ),
              (
                '${stats.goalMissedDays} missed',
                const Color(0xFFFCEBEB),
                const Color(0xFF791F1F),
              ),
              (
                '${stats.goalLeftDays} left',
                const Color(0xFFF1EFE8),
                const Color(0xFF5F5E5A),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Habit section
          Text(
            'Habit: Avoid $distraction',
            style: const TextStyle(fontSize: 13, color: Color(0xFF6F6B63)),
          ),
          const SizedBox(height: 10),
          HistoryDayGrid(days: days, isGoal: false),
          const SizedBox(height: 12),
          HistoryStatsPills(
            pills: [
              (
                '${stats.habitCleanDays} clean',
                const Color(0xFFEAF3DE),
                const Color(0xFF27500A),
              ),
              (
                '${stats.habitSlippedDays} slipped',
                const Color(0xFFFCEBEB),
                const Color(0xFF791F1F),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Honesty score
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEDFE),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Overall honesty score',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3C3489),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${stats.honestyScore}%',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF26215C),
                    letterSpacing: -1,
                  ),
                ),

                const SizedBox(height: 28),

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
                    onPressed: () async {
                      final shouldReset = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Start again?'),
                            content: const Text(
                              'This will delete your current 21-day history and start a new challenge. This action cannot be undone.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: const Text('Delete and start again'),
                              ),
                            ],
                          );
                        },
                      );

                      if (shouldReset != true) return;

                      await ref
                          .read(historyRepositoryProvider)
                          .deleteAllCheckins();

                      ref.invalidate(historyAllCheckinsProvider);
                      ref.invalidate(historyUserSetupProvider);

                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.setup,
                          (route) => false,
                        );
                      }
                    },
                    child: const Text('Start again'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
