import 'package:flutter/material.dart';

class RecentItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String userName;

  const RecentItem({
    super.key,
    required this.icon,
    required this.title,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenWidth * 0.18,
      margin: EdgeInsets.only(bottom: screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        border: Border.all(color: Color.fromARGB(255, 216, 216, 216)),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Row(
        children: [
          SizedBox(width: screenWidth * 0.035),

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
                  style: TextStyle(
                    fontSize: screenWidth * 0.038,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 17, 17, 17),
                  ),
                ),

                SizedBox(height: screenWidth * 0.005),

                Text(
                  userName,
                  style: TextStyle(
                    fontSize: screenWidth * 0.030,
                    color: Color.fromARGB(255, 85, 85, 85),
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Copied to clipboard")));
            },
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              minWidth: screenWidth * 0.09,
              minHeight: screenWidth * 0.09,
            ),
            icon: Icon(
              Icons.copy_outlined,
              size: screenWidth * 0.055,
              color: Color.fromARGB(255, 34, 34, 34),
            ),
          ),

          SizedBox(width: screenWidth * 0.02),
        ],
      ),
    );
  }
}
