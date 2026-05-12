import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/repositories/checkin_repository.dart';

final checkinRepositoryProvider = Provider<CheckinRepository>((ref) {
  return CheckinRepository();
});

// User's goal and habit loaded from Firestore
final userSetupProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  return ref.read(checkinRepositoryProvider).getUserSetup();
});

// Today's existing check-in (null if not answered yet)
final todayCheckinProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  return ref.read(checkinRepositoryProvider).getTodayCheckin();
});

// Honest days count
final honestDaysProvider = FutureProvider<int>((ref) async {
  return ref.read(checkinRepositoryProvider).getHonestDaysCount();
});

// Local answer state before saving
class CheckinAnswers {
  final bool? goalDone;
  final bool? habitAvoided;

  const CheckinAnswers({this.goalDone, this.habitAvoided});

  bool get isComplete => goalDone != null && habitAvoided != null;

  CheckinAnswers copyWith({bool? goalDone, bool? habitAvoided}) {
    return CheckinAnswers(
      goalDone: goalDone ?? this.goalDone,
      habitAvoided: habitAvoided ?? this.habitAvoided,
    );
  }
}

class CheckinAnswersNotifier extends StateNotifier<CheckinAnswers> {
  CheckinAnswersNotifier() : super(const CheckinAnswers());

  void setGoalDone(bool value) {
    state = state.copyWith(goalDone: value);
  }

  void setHabitAvoided(bool value) {
    state = state.copyWith(habitAvoided: value);
  }
}

final checkinAnswersProvider =
    StateNotifierProvider<CheckinAnswersNotifier, CheckinAnswers>((ref) {
      return CheckinAnswersNotifier();
    });

// Saving state
final checkinSavingProvider = StateProvider<bool>((ref) => false);
