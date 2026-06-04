import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/support_habit.dart';

class SupportHabitsController extends Notifier<List<SupportHabit>> {
  @override
  List<SupportHabit> build() {
    return const [
      SupportHabit(id: '1', title: 'Read 10 minutes'),
      SupportHabit(id: '2', title: 'No sugar'),
      SupportHabit(id: '3', title: 'Plank'),
    ];
  }

  void addHabit(String title) {
    final trimmedTitle = title.trim();

    if (trimmedTitle.isEmpty) return;

    final newHabit = SupportHabit(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: trimmedTitle,
    );

    state = [...state, newHabit];
  }

  void toggleHabit(String id) {
    state = [
      for (final habit in state)
        if (habit.id == id)
          habit.copyWith(isDoneToday: !habit.isDoneToday)
        else
          habit,
    ];
  }

  void deleteHabit(String id) {
    state = state.where((habit) => habit.id != id).toList();
  }

  void updateHabit(String id, String newTitle) {
    final trimmedTitle = newTitle.trim();

    if (trimmedTitle.isEmpty) return;

    state = [
      for (final habit in state)
        if (habit.id == id) habit.copyWith(title: trimmedTitle) else habit,
    ];
  }

  int get doneCount {
    return state.where((habit) => habit.isDoneToday).length;
  }

  int get totalCount {
    return state.length;
  }
}

final supportHabitsProvider =
    NotifierProvider<SupportHabitsController, List<SupportHabit>>(
      SupportHabitsController.new,
    );
