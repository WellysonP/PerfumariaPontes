import 'package:flutter/material.dart';

class SubtitleAppBar extends StatelessWidget {
  final String text;
  const SubtitleAppBar({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 17),
      child: Column(
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 17),
        ],
      ),
    );
  }
}
