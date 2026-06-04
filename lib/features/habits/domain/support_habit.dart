class SupportHabit {
  final String id;
  final String title;
  final bool isDoneToday;
  final bool isActive;

  const SupportHabit({
    required this.id,
    required this.title,
    this.isDoneToday = false,
    this.isActive = true,
  });

  SupportHabit copyWith({
    String? id,
    String? title,
    bool? isDoneToday,
    bool? isActive,
  }) {
    return SupportHabit(
      id: id ?? this.id,
      title: title ?? this.title,
      isDoneToday: isDoneToday ?? this.isDoneToday,
      isActive: isActive ?? this.isActive,
    );
  }
}
