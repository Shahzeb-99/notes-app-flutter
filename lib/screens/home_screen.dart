import 'dart:math';
import 'package:flutter/material.dart';
import 'package:notes_dev/add%20task%20screen/add_task_screen.dart';
import 'package:notes_dev/data/note_data.dart';
import 'package:notes_dev/widgets/note_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<NotesData>(context, listen: false).getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTaskScreen()));
        },
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Notes',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 45,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 55.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
                  itemCount: Provider.of<NotesData>(context).notes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return NoteCard(
                      headline:
                          Provider.of<NotesData>(context).notes[index].heading,
                      day: Provider.of<NotesData>(context).notes[index].date,
                      month: Provider.of<NotesData>(context).notes[index].month,
                      year: Provider.of<NotesData>(context).notes[index].year,
                      body: Provider.of<NotesData>(context).notes[index].body,
                      rand: Random().nextInt(4),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
