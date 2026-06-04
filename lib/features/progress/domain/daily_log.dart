class DailyLog {
  final DateTime date;
  final bool mainGoalDone;
  final bool badHabitAvoided;
  final int supportDone;
  final int supportTotal;

  const DailyLog({
    required this.date,
    required this.mainGoalDone,
    required this.badHabitAvoided,
    required this.supportDone,
    required this.supportTotal,
  });

  double get score {
    final mainGoalScore = mainGoalDone ? 50.0 : 0.0;
    final badHabitScore = badHabitAvoided ? 30.0 : 0.0;

    final supportScore = supportTotal == 0
        ? 20.0
        : (supportDone / supportTotal) * 20.0;

    return mainGoalScore + badHabitScore + supportScore;
  }

  bool get isSuccessfulDay => score >= 80;
}
