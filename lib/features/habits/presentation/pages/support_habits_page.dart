import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own_it/features/habits/presentation/widgets/support_habit_tile.dart';

import '../providers/support_habits_provider.dart';

class SupportHabitsPage extends ConsumerWidget {
  const SupportHabitsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(supportHabitsProvider);

    final doneCount = habits.where((habit) => habit.isDoneToday).length;
    final totalCount = habits.length;
    final progress = totalCount == 0 ? 0.0 : doneCount / totalCount;

    return Scaffold(
      appBar: AppBar(title: const Text('Face Your Day')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddHabitDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Add habit'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Support Habits',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'Small habits that support your main goal and discipline.',
          ),
          const SizedBox(height: 20),

          LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            borderRadius: BorderRadius.circular(100),
          ),

          const SizedBox(height: 12),

          Text(
            '$doneCount of $totalCount completed today',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 24),

          if (habits.isEmpty)
            const Center(
              child: Text('No support habits yet. Add your first one.'),
            )
          else
            ...habits.map(
              (habit) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SupportHabitTile(
                  habit: habit,
                  onToggle: () {
                    ref
                        .read(supportHabitsProvider.notifier)
                        .toggleHabit(habit.id);
                  },
                  onDelete: () {
                    ref
                        .read(supportHabitsProvider.notifier)
                        .deleteHabit(habit.id);
                  },
                  onEdit: () {
                    _showEditHabitDialog(context, ref, habit.id, habit.title);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showAddHabitDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add support habit'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Example: Read 10 minutes',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(supportHabitsProvider.notifier)
                    .addHabit(controller.text);

                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditHabitDialog(
    BuildContext context,
    WidgetRef ref,
    String habitId,
    String oldTitle,
  ) {
    final controller = TextEditingController(text: oldTitle);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit habit'),
          content: TextField(controller: controller, autofocus: true),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(supportHabitsProvider.notifier)
                    .updateHabit(habitId, controller.text);

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
