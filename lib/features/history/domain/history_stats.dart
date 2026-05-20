import 'package:own_it/features/checkin/domain/entities/checkin.dart';

class HistoryStats {
  final int goalDoneDays;
  final int goalMissedDays;
  final int goalLeftDays;

  final int habitCleanDays;
  final int habitSlippedDays;

  final int honestyScore;

  const HistoryStats({
    required this.goalDoneDays,
    required this.goalMissedDays,
    required this.goalLeftDays,
    required this.habitCleanDays,
    required this.habitSlippedDays,
    required this.honestyScore,
  });

  factory HistoryStats.fromCheckins(List<Checkin> checkins) {
    final goalDoneDays = checkins.where((c) => c.goalDone).length;

    final goalMissedDays = checkins.where((c) => !c.goalDone).length;

    final habitCleanDays = checkins.where((c) => c.habitAvoided).length;

    final habitSlippedDays = checkins.where((c) => !c.habitAvoided).length;

    final answeredDays = checkins.length;

    final honestDays = checkins.where((c) => c.isHonest).length;

    final honestyScore = answeredDays == 0
        ? 0
        : ((honestDays / answeredDays) * 100).round();

    return HistoryStats(
      goalDoneDays: goalDoneDays,
      goalMissedDays: goalMissedDays,
      goalLeftDays: 21 - answeredDays,
      habitCleanDays: habitCleanDays,
      habitSlippedDays: habitSlippedDays,
      honestyScore: honestyScore,
    );
  }
}
