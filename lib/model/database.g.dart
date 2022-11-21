// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NotesDao? _noteDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Notes` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `heading` TEXT, `body` TEXT, `date` INTEGER, `month` INTEGER, `year` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NotesDao get noteDao {
    return _noteDaoInstance ??= _$NotesDao(database, changeListener);
  }
}

class _$NotesDao extends NotesDao {
  _$NotesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _notesInsertionAdapter = InsertionAdapter(
            database,
            'Notes',
            (Notes item) => <String, Object?>{
                  'id': item.id,
                  'heading': item.heading,
                  'body': item.body,
                  'date': item.date,
                  'month': item.month,
                  'year': item.year
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Notes> _notesInsertionAdapter;

  @override
  Future<List<Notes>> findAllNotes() async {
    return _queryAdapter.queryList('SELECT * FROM Notes',
        mapper: (Map<String, Object?> row) => Notes(
            date: row['date'] as int?,
            month: row['month'] as int?,
            year: row['year'] as int?,
            id: row['id'] as int?,
            heading: row['heading'] as String?,
            body: row['body'] as String?));
  }

  @override
  Stream<Notes?> findNoteById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Notes WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Notes(
            date: row['date'] as int?,
            month: row['month'] as int?,
            year: row['year'] as int?,
            id: row['id'] as int?,
            heading: row['heading'] as String?,
            body: row['body'] as String?),
        arguments: [id],
        queryableName: 'Notes',
        isView: false);
  }

  @override
  Future<void> deleteUserById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Notes WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertNote(Notes note) async {
    await _notesInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }
}
