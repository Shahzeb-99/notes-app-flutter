
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:notes_dev/model/note_dao.dart';
import 'package:notes_dev/model/note_data_model.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Notes])
abstract class AppDatabase extends FloorDatabase {
  NotesDao get noteDao;
}