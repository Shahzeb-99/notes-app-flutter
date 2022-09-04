import 'package:flutter/material.dart';
import 'package:notes_dev/model/note_data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesData extends ChangeNotifier {
  List<Notes> notes = [];

  void addToList(Notes newNote){
    notes.add(newNote);
    notifyListeners();
  }

  Future<void> getNotes() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'notes_database.db'),
    );
    final db = await database;


    final List<Map<String, dynamic>> maps = await db.query('notes');


    notes = List.generate(maps.length, (i) {
      notifyListeners();
      return Notes(
        heading: maps[i]['heading'],
        body: maps[i]['body'],
        month: maps[i]['month'],
        year: maps[i]['year'],
        date: maps[i]['date'],
      );
});
  }

  Future<void> insertNotes(Notes newNote) async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'notes_database.db'),
    );

    final db = await database;
    await db.insert(
      'notes',
      newNote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
