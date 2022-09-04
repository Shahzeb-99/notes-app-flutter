import 'package:flutter/material.dart';

class NoteSceen extends StatelessWidget {
  const NoteSceen({Key? key, required this.headingText, required this.bodyText}) : super(key: key);

  final String headingText;
  final String bodyText;

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
                    GestureDetector(onTap: (){Navigator.pop(context);},
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
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(headingText,style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    getDateTime(DateTime.now()),
                    style: const TextStyle(
                        color: Color(0x59FFFFFF),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(bodyText,style: TextStyle(
                    fontSize: 20,
                  ),)
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
