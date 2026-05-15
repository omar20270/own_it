import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/result_repository.dart';

final resultRepositoryProvider = Provider<ResultRepository>((ref) {
  return ResultRepository();
});

final resultAllCheckinsProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  return ref.read(resultRepositoryProvider).getAllCheckins();
});
