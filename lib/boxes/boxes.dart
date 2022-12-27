import 'package:hive_flutter/adapters.dart';
import 'package:task_app/model/notes_model.dart';

class Boxes {
  static Box<NotesModel> getData() => Hive.box<NotesModel>('notes');
}
