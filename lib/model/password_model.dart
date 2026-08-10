import 'package:hive_flutter/hive_flutter.dart';

part 'password_model.g.dart';

@HiveType(typeId: 0)
class PasswordModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String username;

  @HiveField(2, defaultValue: '')
  String? password;

  PasswordModel({
    required this.title,
    required this.username,
    required this.password,
  });
}
