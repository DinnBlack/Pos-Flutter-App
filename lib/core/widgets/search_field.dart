import 'package:flutter/material.dart';

import '../utils/constants.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearchChanged;
  final String hintText;

  const SearchField({
    super.key,
    required this.controller,
    required this.onSearchChanged, required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return TextField(
      controller: controller,
      onChanged: onSearchChanged,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: colors.secondary,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
  }
}
