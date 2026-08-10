import 'package:flutter/material.dart';

class NoteItem extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const NoteItem({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: screenWidth * 0.18,
        margin: EdgeInsets.only(bottom: screenWidth * 0.03),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border.all(color: Color.fromARGB(255, 216, 216, 216)),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.10,
              height: screenWidth * 0.10,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 233, 235, 238),
                borderRadius: BorderRadius.circular(screenWidth * 0.025),
              ),
              child: Icon(
                icon,
                size: screenWidth * 0.055,
                color: Color.fromARGB(255, 34, 34, 34),
              ),
            ),

            SizedBox(width: screenWidth * 0.035),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 17, 17, 17),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.005),
                  Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: screenWidth * 0.030,
                      color: Color.fromARGB(255, 85, 85, 85),
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right_rounded,
              size: screenWidth * 0.055,
              color: Color.fromARGB(255, 150, 150, 150),
            ),
          ],
        ),
      ),
    );
  }
}
