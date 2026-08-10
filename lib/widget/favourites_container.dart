import 'package:flutter/material.dart';
import 'package:flutter_database_assignment/widget/divider.dart';
import 'package:flutter_database_assignment/widget/empty_state_container.dart';
import 'package:flutter_database_assignment/widget/recent_items.dart';

class FavoritesContainer extends StatelessWidget {
  final List<Map<String, String>> favoritesList;
  final VoidCallback onAddItemPressed;

  const FavoritesContainer({
    super.key,
    required this.favoritesList,
    required this.onAddItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    final list = favoritesList;
    final screenWidth = MediaQuery.of(context).size.width;

    if (list.isEmpty) {
      return EmptyStateContainer(onPress: onAddItemPressed);
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        border: Border.all(color: Color.fromARGB(255, 216, 216, 216)),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Column(
        children: List.generate(list.length, (index) {
          final item = list[index];

          return Column(
            children: [
              RecentItem(
                icon: Icons.star_rounded,
                title: item['title'] ?? '',
                userName: item['subtitle'] ?? '',
              ),
              if (index < list.length - 1) RecentDivider(),
            ],
          );
        }),
      ),
    );
  }
}
