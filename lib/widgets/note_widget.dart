import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:notes_dev/data/note_data.dart';
import 'package:notes_dev/screens/note_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NoteCard extends StatefulWidget {
  final int id;
  final int index;

  const NoteCard({Key? key, required this.index, required this.id})
      : super(key: key);

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  late Color widgetColor;

  @override
  void initState() {
    widgetColor = getColor(
      Random().nextInt(4),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: widgetColor,
      openColor: const Color(0xFF252525),
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 400),
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      openBuilder:
          (BuildContext context, void Function({Object? returnValue}) action) =>
              NoteScreen(
        index: widget.index,
        id: widget.id,
      ),
      closedBuilder: (BuildContext context, void Function() action) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  Provider.of<NotesData>(context)
                      .notes[widget.index]
                      .heading!,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                DateFormat.yMMMEd().format(DateTime(
                    Provider.of<NotesData>(context).notes[widget.index].year!,
                    Provider.of<NotesData>(context)
                        .notes[widget.index]
                        .month!,
                    Provider.of<NotesData>(context)
                        .notes[widget.index]
                        .date!)),
                style: const TextStyle(

                    color: Colors.black38,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        );
      },
    );
  }
}

String getDateTime(int monthNum) {
  String month = '';

  switch (monthNum) {
    case 1:
      month = 'Jan';
      break;
    case 2:
      month = 'Feb';
      break;
    case 3:
      month = 'Mar';
      break;
    case 4:
      month = 'Apr';
      break;
    case 5:
      month = 'May';
      break;
    case 6:
      month = 'Jun';
      break;
    case 7:
      month = 'Jul';
      break;
    case 8:
      month = 'Aug';
      break;
    case 9:
      month = 'Sept';
      break;
    case 10:
      month = 'Oct';
      break;
    case 11:
      month = 'Nov';
      break;
    case 12:
      month = 'Dec';
      break;
  }

  return month;
}

Color getColor(int rand) {
  int color = 0xFFE6EE9B;

  switch (rand) {
    case 0:
      color = 0xFFE6EE9B;
      break;
    case 1:
      color = 0xFFCF93D9;
      break;
    case 2:
      color = 0xFF80DEEA;
      break;
    case 3:
      color = 0xFFFFCC80;
      break;
    case 4:
      color = 0xFF252525;
      break;
  }

  return Color(color);
}
