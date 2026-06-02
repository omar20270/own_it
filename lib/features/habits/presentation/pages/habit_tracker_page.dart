import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Habit {
  final String id;
  final String title;
  final bool isPositive;

  const Habit({
    required this.id,
    required this.title,
    required this.isPositive,
  });
}

class HabitProgressState {
  final List<Habit> habits;
  final Map<String, bool> todayValues;

  const HabitProgressState({required this.habits, required this.todayValues});

  int get completedToday {
    return todayValues.values.where((value) => value == true).length;
  }

  int get totalHabits => habits.length;

  double get progress {
    if (totalHabits == 0) return 0;
    return completedToday / totalHabits;
  }

  HabitProgressState copyWith({
    List<Habit>? habits,
    Map<String, bool>? todayValues,
  }) {
    return HabitProgressState(
      habits: habits ?? this.habits,
      todayValues: todayValues ?? this.todayValues,
    );
  }
}

class HabitTrackerController extends Notifier<HabitProgressState> {
  @override
  HabitProgressState build() {
    return HabitProgressState(
      habits: const [
        Habit(id: 'no_sugar', title: 'No Sugar', isPositive: true),
        Habit(id: 'plank', title: 'Plank', isPositive: true),
        Habit(
          id: 'facebook_10',
          title: 'Facebook max 10 min',
          isPositive: true,
        ),
        Habit(id: 'telegram', title: 'Avoid Telegram', isPositive: false),
        Habit(id: 'gmail', title: 'Check Gmail', isPositive: true),
        Habit(
          id: 'whatsapp',
          title: 'Avoid WhatsApp scrolling',
          isPositive: false,
        ),
      ],
      todayValues: {
        'no_sugar': false,
        'plank': false,
        'facebook_10': false,
        'telegram': false,
        'gmail': false,
        'whatsapp': false,
      },
    );
  }

  void toggleHabit(String habitId) {
    final currentValue = state.todayValues[habitId] ?? false;

    state = state.copyWith(
      todayValues: {...state.todayValues, habitId: !currentValue},
    );
  }
}

final habitTrackerProvider =
    NotifierProvider<HabitTrackerController, HabitProgressState>(
      HabitTrackerController.new,
    );

class HabitTrackerPage extends ConsumerWidget {
  const HabitTrackerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitState = ref.watch(habitTrackerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Face Your Day')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _ProgressCard(state: habitState),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: habitState.habits.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final habit = habitState.habits[index];
                  final isDone = habitState.todayValues[habit.id] ?? false;

                  return _HabitTile(
                    habit: habit,
                    isDone: isDone,
                    onTap: () {
                      ref
                          .read(habitTrackerProvider.notifier)
                          .toggleHabit(habit.id);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final HabitProgressState state;

  const _ProgressCard({required this.state});

  @override
  Widget build(BuildContext context) {
    final percentage = (state.progress * 100).toStringAsFixed(0);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: state.progress,
              minHeight: 10,
              borderRadius: BorderRadius.circular(100),
            ),
            const SizedBox(height: 12),
            Text(
              '${state.completedToday} from ${state.totalHabits} completed • $percentage%',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _HabitTile extends StatelessWidget {
  final Habit habit;
  final bool isDone;
  final VoidCallback onTap;

  const _HabitTile({
    required this.habit,
    required this.isDone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icon = isDone ? Icons.check_circle : Icons.radio_button_unchecked;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDone
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: isDone
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                habit.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Text(
              isDone ? '1' : '0',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDone
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
