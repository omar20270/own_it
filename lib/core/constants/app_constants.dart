class AppStrings {
  // Setup
  static const setupTitle = 'FaceIt';
  static const setupGoalQuestion = 'What will you face for 21 days?';
  static const setupGoalSubtitle = 'One goal. One distraction. No excuses.';
  static const setupGoalHint = 'e.g. Finish Flutter tutorial';
  static const setupHabitQuestion = 'What distracts you most?';
  static const setupHabitSubtitle = 'Pick your bad habit';
  static const setupCta = 'Start my 21 days';

  // Habits list
  static const List<String> defaultHabits = [
    'Phone',
    'YouTube',
    'Smoking',
    'Social',
    'Gaming',
    'Netflix',
  ];

  // Check-in
  static const checkinTitle = 'Time to be honest.';
  static const daysHonest = 'days honest';

  // Result
  static const resultTitle = "Today's result";
  static const resultDone = 'Done. Keep going.';
  static const resultFail = 'You watched it. Be honest tomorrow.';
  static const streakResetWarning = 'Streak resets if you lie to yourself.';
  static const progressLabel = '21-day progress';
}

class AppRoutes {
  static const setup = '/';
  static const checkin = '/checkin';
  static const result = '/result';
  static const history = '/history';
}
