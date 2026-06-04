import '../domain/daily_log.dart';
import '../domain/progress_summary.dart';

class ProgressCalculator {
  ProgressSummary calculate({
    required List<DailyLog> logs,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final normalizedStart = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );

    final normalizedEnd = DateTime(endDate.year, endDate.month, endDate.day);

    final totalDays = normalizedEnd.difference(normalizedStart).inDays + 1;

    final logsByDate = {
      for (final log in logs)
        DateTime(log.date.year, log.date.month, log.date.day): log,
    };

    int loggedDays = 0;
    int successfulDays = 0;
    int failedDays = 0;
    double totalScore = 0;

    int currentStreak = 0;
    int bestStreak = 0;

    for (int i = 0; i < totalDays; i++) {
      final currentDate = normalizedStart.add(Duration(days: i));
      final log = logsByDate[currentDate];

      if (log == null) {
        failedDays++;
        currentStreak = 0;
        continue;
      }

      loggedDays++;
      totalScore += log.score;

      if (log.isSuccessfulDay) {
        successfulDays++;
        currentStreak++;

        if (currentStreak > bestStreak) {
          bestStreak = currentStreak;
        }
      } else {
        failedDays++;
        currentStreak = 0;
      }
    }

    final averageScore = totalDays == 0 ? 0.0 : totalScore / totalDays;

    return ProgressSummary(
      totalDays: totalDays,
      loggedDays: loggedDays,
      successfulDays: successfulDays,
      failedDays: failedDays,
      averageScore: averageScore,
      bestStreak: bestStreak,
    );
  }
}
