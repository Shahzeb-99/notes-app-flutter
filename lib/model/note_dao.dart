
import 'package:floor/floor.dart';
import 'package:notes_dev/model/note_data_model.dart';

@dao
abstract class NotesDao {
  @Query('SELECT * FROM Notes')
  Future<List<Notes>> findAllNotes();

  @Query('SELECT * FROM Notes WHERE id = :id')
  Stream<Notes?> findNoteById(int id);

  @insert
  Future<void> insertNote(Notes note);
}