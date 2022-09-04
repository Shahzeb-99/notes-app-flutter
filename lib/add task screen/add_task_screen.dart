import 'package:flutter/material.dart';
import 'package:notes_dev/data/note_data.dart';
import 'package:notes_dev/model/note_data_model.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String bodyText = '';

  String headingText = '';

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xFF3B3B3B),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Notes newNotesObject = Notes(
                        date: dateTime.day,
                        month: dateTime.month,
                        year: dateTime.year,
                        heading: headingText,
                        body: bodyText);
                    Provider.of<NotesData>(context, listen: false)
                        .addToList(newNotesObject);
                    Provider.of<NotesData>(context, listen: false)
                        .insertNotes(newNotesObject);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: 70,
                    decoration: BoxDecoration(
                        color: const Color(0xFF3B3B3B),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text(
                      'Save',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              autofocus: true,
              onChanged: (newText) {
                headingText = newText;
              },
              maxLines: 2,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle:
                      TextStyle(fontSize: 40, fontWeight: FontWeight.w600)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: dateTime,
                    initialDatePickerMode: DatePickerMode.day,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  setState(() {
                    dateTime = newDate!;
                  });
                },
                child: Text(
                  getDateTime(dateTime),
                  style: const TextStyle(
                      color: Color(0x59FFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                onChanged: (newText) {
                  bodyText = newText;
                },
                maxLines: null,
                minLines: null,
                expands: true,
                style: const TextStyle(
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type Something...',
                    hintStyle: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

String getDateTime(DateTime noteDate) {
  String? month;

  switch (noteDate.month) {
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

  return "$month ${noteDate.day}, ${noteDate.year}";
}
