import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_dev/data/note_data.dart';
import 'package:notes_dev/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
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
            textTheme: GoogleFonts.montserratTextTheme(
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
