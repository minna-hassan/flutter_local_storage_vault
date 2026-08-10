import 'package:flutter/material.dart';

class EmptyStateContainer extends StatelessWidget {
  final VoidCallback onPress;

  EmptyStateContainer({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.03,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.06),
        border: Border.all(color: Color.fromARGB(255, 235, 236, 239)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            'https://cdn-icons-png.flaticon.com/512/4076/4076432.png',
            height: screenWidth * 0.14,
            width: screenWidth * 0.14,
            color: Color.fromARGB(255, 243, 240, 240),
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.inbox_outlined,
                size: screenWidth * 0.13,
                color: Color.fromARGB(255, 242, 240, 240),
              );
            },
          ),

          SizedBox(height: screenHeight * 0.018),

          Text(
            "No vault records found",
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 34, 34, 34),
            ),
          ),

          SizedBox(height: screenHeight * 0.022),

          ElevatedButton.icon(
            onPressed: onPress,
            icon: Icon(
              Icons.add,
              size: screenWidth * 0.045,
              color: Colors.white,
            ),
            label: Text(
              "Add Item Now",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              elevation: 0,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.055,
                vertical: screenHeight * 0.015,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
