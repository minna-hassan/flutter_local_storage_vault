import 'package:flutter/material.dart';
import 'package:flutter_database_assignment/dialog/add_password_dialog.dart';
import 'package:flutter_database_assignment/services/hive_service.dart';
import 'package:flutter_database_assignment/model/password_model.dart';
import 'package:flutter_database_assignment/widget/divider.dart';
import 'package:flutter_database_assignment/widget/empty_state_container.dart';
import 'package:flutter_database_assignment/widget/recent_items.dart';

class PasswordsContainer extends StatelessWidget {
  final List<PasswordModel> passwordsList;
  final VoidCallback onAddItemPressed;

  const PasswordsContainer({
    super.key,
    required this.passwordsList,
    required this.onAddItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    final list = passwordsList;

    if (list.isEmpty) {
      return EmptyStateContainer(onPress: onAddItemPressed);
    }

    return Column(
      children: List.generate(list.length, (index) {
        final item = list[index];

        return RecentItem(
          icon: Icons.key_rounded,
          title: item.username,
          userName: item.username,
        );
      }),
    );
  }
}
