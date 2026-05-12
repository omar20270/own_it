import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/repositories/setup_repository.dart';

// ── existing providers (keep them) ──
final goalProvider = StateProvider<String>((ref) => '');
final selectedHabitProvider = StateProvider<String?>((ref) => null);
final setupValidProvider = Provider<bool>((ref) {
  final goal = ref.watch(goalProvider).trim();
  final habit = ref.watch(selectedHabitProvider);
  return goal.isNotEmpty && habit != null;
});

// ── add these new ones ──
final setupRepositoryProvider = Provider<SetupRepository>((ref) {
  return SetupRepository();
});

// tracks loading/error state while saving
final setupSavingProvider = StateProvider<bool>((ref) => false);
