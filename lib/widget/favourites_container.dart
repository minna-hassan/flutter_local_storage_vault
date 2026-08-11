import 'package:flutter/material.dart';
import 'package:flutter_database_assignment/model/notes_model.dart';
import 'package:flutter_database_assignment/model/password_model.dart';
import 'package:flutter_database_assignment/widget/divider.dart';
import 'package:flutter_database_assignment/widget/empty_state_container.dart';
import 'package:flutter_database_assignment/widget/notes_item.dart';
import 'package:flutter_database_assignment/widget/recent_items.dart';

class FavoritesContainer extends StatelessWidget {
  final List<dynamic> favoritesList;
  final VoidCallback onAddItemPressed;

  FavoritesContainer({
    super.key,
    required this.favoritesList,
    required this.onAddItemPressed,
  });

  void showNoteDialog(BuildContext context, dynamic note) {
    final screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            note.title,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              note.content,
              style: TextStyle(
                fontSize: screenWidth * 0.038,
                height: 1.5,
                color: Color.fromARGB(255, 51, 51, 51),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Close',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = favoritesList;
    final screenWidth = MediaQuery.of(context).size.width;

    if (list.isEmpty) {
      return EmptyStateContainer(onPress: onAddItemPressed);
    }

    return Column(
      children: List.generate(list.length, (index) {
        final item = list[index];

        if (item is PasswordModel) {
          return RecentItem(
            icon: Icons.key_rounded,
            title: item.title,
            userName: item.username,
            contentToCopy: item.password ?? '',
            isFavorite: item.isFavorite,
            onFavoriteToggled: () async {
              item.isFavorite = !item.isFavorite;
              await item.save();
            },
          );
        } else if (item is NotesModel) {
          return NoteItem(
            icon: Icons.description_outlined,
            title: item.title,
            description: item.content,
            isFavorite: item.isFavorite,
            onFavoriteToggled: () async {
              item.isFavorite = !item.isFavorite;
              await item.save();
            },
            onTap: () {
              showNoteDialog(context, item);
            },
          );
        }
        return Container();
      }),
    );
  }
}
