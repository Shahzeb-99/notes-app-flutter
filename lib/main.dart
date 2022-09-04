import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_dev/data/note_data.dart';
import 'package:notes_dev/screens/home_screen.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  openDatabase(
    join(await getDatabasesPath(), 'notes_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, heading TEXT, body TEXT, date INTEGER, month INTEGER, year INTEGER)',
      );
    },
    version: 1,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NotesData(),
      child: MaterialApp(
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xFF252525),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.black, iconSize: 35),
            textTheme: GoogleFonts.openSansTextTheme(
              Theme.of(context).textTheme,
            ).apply(
              bodyColor: Colors.white, //<-- SEE HERE
              displayColor: Colors.white,
            ),
          ),
          home: const HomeScreen()),
    );
  }
}
