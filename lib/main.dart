import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own_it/core/theme/app_thema.dart';
import 'package:own_it/features/checkin/presentation/pages/checkin_page.dart';
import 'package:own_it/features/checkin/presentation/pages/history_screen.dart';
import 'package:own_it/features/result/presentation/pages/result_page.dart';
import 'package:own_it/firebase_options.dart';

import 'core/constants/app_constants.dart';

import 'features/setup/presentation/pages/setup_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: OwnItApp()));
}

class OwnItApp extends StatelessWidget {
  const OwnItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OwnIt',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.setup,
      routes: {
        AppRoutes.setup: (_) => const SetupPage(),
        AppRoutes.checkin: (_) => const CheckinPage(),
        AppRoutes.result: (_) => const ResultPage(),
        AppRoutes.history: (context) => const HistoryScreen(),
      },
    );
  }
}
