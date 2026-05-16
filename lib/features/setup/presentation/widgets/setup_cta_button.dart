import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own_it/core/constants/app_constants.dart';
import 'package:own_it/core/theme/app_thema.dart';
import 'package:own_it/features/setup/presentation/providers/setup_providers.dart';

class SetupCtaButton extends ConsumerWidget {
  final bool isEnabled;

  const SetupCtaButton({super.key, required this.isEnabled});

  Future<void> _saveSetup(BuildContext context, WidgetRef ref) async {
    ref.read(setupSavingProvider.notifier).state = true;

    try {
      await ref
          .read(setupRepositoryProvider)
          .saveSetup(
            goal: ref.read(goalProvider).trim(),
            badHabit: ref.read(selectedHabitProvider)!,
          );

      if (context.mounted) {
        Navigator.pushNamed(context, AppRoutes.checkin);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      ref.read(setupSavingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaving = ref.watch(setupSavingProvider);

    return AnimatedOpacity(
      opacity: isEnabled ? 1.0 : 0.45,
      duration: const Duration(milliseconds: 200),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: isEnabled && !isSaving
              ? () => _saveSetup(context, ref)
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: isEnabled ? 3 : 0,
          ),
          child: isSaving
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: Colors.white,
                  ),
                )
              : const Text(
                  AppStrings.setupCta,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
        ),
      ),
    );
  }
}
