import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String count;
  final bool isSelected;

  const SummaryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.widthOf(context);

    return Card(
      elevation: 0,
      color: isSelected
          ? Color.fromARGB(255, 0, 0, 0)
          : Color.fromARGB(255, 255, 255, 255),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: isSelected
              ? Color.fromARGB(0, 0, 0, 0)
              : Color.fromARGB(255, 234, 234, 234),
          width: 1.5,
        ),
      ),

      child: SizedBox(
        height: screenWidth * 0.30,

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                width: 40,
                height: 40,

                decoration: BoxDecoration(
                  color: isSelected
                      ? Color.fromARGB(255, 255, 255, 255)
                      : Color.fromARGB(255, 242, 242, 247),

                  borderRadius: BorderRadius.circular(10),
                ),

                child: Icon(
                  icon,
                  size: 22,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),

              SizedBox(height: screenWidth * 0.025),

              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? Color.fromARGB(255, 255, 255, 255)
                      : Color.fromARGB(255, 0, 0, 0),
                ),
              ),

              SizedBox(height: 3),

              Text(
                count,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? Color.fromARGB(255, 255, 255, 255)
                      : Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
