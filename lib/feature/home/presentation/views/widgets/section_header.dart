import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          const Text(
            'Prime',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          Text(
            ' - $title',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
