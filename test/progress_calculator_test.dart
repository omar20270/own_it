import 'package:flutter_test/flutter_test.dart';
import 'package:own_it/features/progress/application/progress_calculator.dart';
import 'package:own_it/features/progress/domain/daily_log.dart';

void main() {
  test('daily score should be 100 when all items are done', () {
    final log = DailyLog(
      date: DateTime(2026, 6, 4),
      mainGoalDone: true,
      badHabitAvoided: true,
      supportDone: 4,
      supportTotal: 4,
    );

    expect(log.score, 100);
    expect(log.isSuccessfulDay, true);
  });

  test('progress summary should calculate successful days correctly', () {
    final calculator = ProgressCalculator();

    final logs = [
      DailyLog(
        date: DateTime(2026, 6, 1),
        mainGoalDone: true,
        badHabitAvoided: true,
        supportDone: 2,
        supportTotal: 2,
      ),
      DailyLog(
        date: DateTime(2026, 6, 2),
        mainGoalDone: false,
        badHabitAvoided: true,
        supportDone: 1,
        supportTotal: 2,
      ),
    ];

    final summary = calculator.calculate(
      logs: logs,
      startDate: DateTime(2026, 6, 1),
      endDate: DateTime(2026, 6, 3),
    );

    expect(summary.totalDays, 3);
    expect(summary.loggedDays, 2);
    expect(summary.successfulDays, 1);
    expect(summary.failedDays, 2);
    expect(summary.bestStreak, 1);
  });
}
