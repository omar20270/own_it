import 'package:flutter/material.dart';

class CustomDistractionField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const CustomDistractionField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'e.g. Overthinking, gaming, social media',
        filled: true,
        fillColor: const Color(0xFFF1EFE8),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFD8D6CF)),
        ),
      ),
    );
  }
}
