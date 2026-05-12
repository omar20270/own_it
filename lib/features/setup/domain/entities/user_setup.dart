class UserSetup {
  final String goal;
  final String badHabit;
  final DateTime startDate;

  const UserSetup({
    required this.goal,
    required this.badHabit,
    required this.startDate,
  });

  UserSetup copyWith({String? goal, String? badHabit, DateTime? startDate}) {
    return UserSetup(
      goal: goal ?? this.goal,
      badHabit: badHabit ?? this.badHabit,
      startDate: startDate ?? this.startDate,
    );
  }
}
