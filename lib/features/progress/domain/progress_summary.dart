class ProgressSummary {
  final int totalDays;
  final int loggedDays;
  final int successfulDays;
  final int failedDays;
  final double averageScore;
  final int bestStreak;

  const ProgressSummary({
    required this.totalDays,
    required this.loggedDays,
    required this.successfulDays,
    required this.failedDays,
    required this.averageScore,
    required this.bestStreak,
  });
}
