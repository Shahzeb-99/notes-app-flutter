import 'package:flutter/material.dart';
import 'package:notes_dev/model/note_data_model.dart';
import '../model/database.dart';

class NotesData extends ChangeNotifier {
  List<Notes> notes = [];

  void addToList(Notes newNote) {
    notes.add(newNote);
    notifyListeners();
  }

  Future<void> getNotes() async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final notedao = database.noteDao;
    notes = await notedao.findAllNotes();
    notifyListeners();

  }

  Future<void> insertNotes(Notes newNote) async {
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    await database.noteDao.insertNote(newNote);
    notifyListeners();

  }
}
