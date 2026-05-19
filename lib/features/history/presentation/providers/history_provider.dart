import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../checkin/data/repositories/checkin_repository.dart';

final historyRepositoryProvider = Provider<CheckinRepository>((ref) {
  return CheckinRepository();
});

final historyUserSetupProvider = FutureProvider<Map<String, dynamic>?>((ref) {
  return ref.read(historyRepositoryProvider).getUserSetup();
});

final historyAllCheckinsProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) {
  return ref.read(historyRepositoryProvider).getAllCheckins();
});
