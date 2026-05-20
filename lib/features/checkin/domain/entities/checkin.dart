class Checkin {
  final String date;
  final bool goalDone;
  final bool habitAvoided;
  final bool isHonest;

  const Checkin({
    required this.date,
    required this.goalDone,
    required this.habitAvoided,
    required this.isHonest,
  });

  factory Checkin.fromMap(Map<String, dynamic> map) {
    return Checkin(
      date: map['date']?.toString() ?? '',
      goalDone: map['goalDone'] == true,
      habitAvoided: map['habitAvoided'] == true,
      isHonest: map['isHonest'] == true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'goalDone': goalDone,
      'habitAvoided': habitAvoided,
      'isHonest': isHonest,
    };
  }
}
