import 'package:flutter/material.dart';

class RecentDivider extends StatelessWidget {
  const RecentDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 9),
      child: SizedBox(
        height: 1,
        child: Container(color: Color.fromARGB(255, 229, 229, 229)),
      ),
    );
  }
}
