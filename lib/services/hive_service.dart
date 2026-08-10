import 'package:flutter_database_assignment/model/notes_model.dart';
import 'package:flutter_database_assignment/model/password_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(PasswordModelAdapter());

    Hive.registerAdapter(NotesModelAdapter());
    await Hive.openBox<PasswordModel>('password');
    await Hive.openBox<NotesModel>('notes');
  }

  static Future<void> addPassword({
    required String username,
    required String password,
    required String title,
  }) async {
    final box = Hive.box<PasswordModel>('password');
    await box.add(
      PasswordModel(username: username, password: password, title: title),
    );
  }

  static Future<void> addNote({
    required String title,
    required String content,
  }) async {
    final box = Hive.box<NotesModel>('notes');
    await box.add(NotesModel(title: title, content: content));
  }

  static PasswordModel? getPassword({required dynamic key}) {
    final box = Hive.box<PasswordModel>('password');

    return box.get(key);
  }

  static NotesModel? getNote({required dynamic key}) {
    final box = Hive.box<NotesModel>('notes');

    return box.get(key);
  }

  static int getPasswordCount() {
    return Hive.box<PasswordModel>('password').length;
  }

  static int getNotesCount() {
    return Hive.box<NotesModel>('notes').length;
  }

  static List<PasswordModel> getPasswords() {
    final box = Hive.box<PasswordModel>('password');
    return box.values.toList();
  }

  static List<NotesModel> getNotes() {
    final box = Hive.box<NotesModel>('notes');
    return box.values.toList();
  }

  static Future<void> delPassword({required String key}) {
    final box = Hive.box<PasswordModel>('password');
    return box.delete(key);
  }

  static Future<void> delNote({required String key}) {
    final box = Hive.box<NotesModel>('notes');
    return box.delete(key);
  }

  static dynamic getPasswordListenable() {
    return Hive.box<PasswordModel>('password').listenable();
  }

  static dynamic getNotesListenable() {
    return Hive.box<NotesModel>('notes').listenable();
  }
}
