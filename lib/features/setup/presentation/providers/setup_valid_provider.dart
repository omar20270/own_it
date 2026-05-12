import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// ── Goal text ──────────────────────────────────────────────────────────────
final goalProvider = StateProvider<String>((ref) => '');

// ── Selected bad habit ─────────────────────────────────────────────────────
final selectedHabitProvider = StateProvider<String?>((ref) => null);

// ── Form validity: both must be filled ────────────────────────────────────
final setupValidProvider = Provider<bool>((ref) {
  final goal = ref.watch(goalProvider).trim();
  final habit = ref.watch(selectedHabitProvider);
  return goal.isNotEmpty && habit != null;
});
