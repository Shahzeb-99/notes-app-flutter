import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:notes_dev/screens/note_screen.dart';

class NoteCard extends StatelessWidget {
  final String headline;
  final int rand;
  final int day;
  final int month;
  final int year;
  final String body;

  const NoteCard(
      {Key? key,
      required this.headline,
      required this.day,
      required this.month,
      required this.year,
      required this.body,
      required this.rand})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: getColor(rand),
      openColor: Colors.black,
      middleColor: Colors.grey,
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: Duration(milliseconds: 350),
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      openBuilder:
          (BuildContext context, void Function({Object? returnValue}) action) =>
              NoteSceen(
        headingText: headline,
        bodyText: body,
      ),
      closedBuilder: (BuildContext context, void Function() action) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: getColor(rand),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    headline,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  '${getDateTime(month)} $day, $year',
                  style: const TextStyle(
                      color: Colors.black38,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
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
