import 'package:hive_flutter/hive_flutter.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 1)
class NotesModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String content;
  NotesModel({required this.title, required this.content});
}
