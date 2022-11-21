import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_dev/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../data/note_data.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key, required this.index, required this.id})
      : super(key: key);
  final int index;
  final int id;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  bool startAnim = false;

  @override
  void initState() {

    startAnimation();
    super.initState();
  }

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
                    Provider.of<NotesData>(context, listen: false)
                        .deleteNote(widget.id);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false);
                  },
                  child: Container(
                    height: 50,
                    width: 70,
                    decoration: BoxDecoration(
                        color: const Color(0xFF3B3B3B),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text(
                      'Delete',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ShaderMask(
                shaderCallback: (Rect rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.purple,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.purple
                    ],
                    stops: [
                      0.0,
                      0.05,
                      0.95,
                      1.0
                    ], // 10% purple, 80% transparent, 10% purple
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
                  clipBehavior: Clip.antiAlias,
                  child: AnimatedOpacity(opacity: startAnim?1:0,
                    duration: const Duration(milliseconds:800),
                    curve: Curves.easeInCubic   ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds:800),
                          height: !startAnim
                              ? MediaQuery.of(context).size.height
                              : 10,curve: Curves.easeOutCirc,
                        ),

                        Text(
                            Provider.of<NotesData>(context)
                                .notes[widget.index]
                                .heading!,
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w600)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            DateFormat.yMMMEd().format(DateTime(
                                Provider.of<NotesData>(context)
                                    .notes[widget.index]
                                    .year!,
                                Provider.of<NotesData>(context)
                                    .notes[widget.index]
                                    .month!,
                                Provider.of<NotesData>(context)
                                    .notes[widget.index]
                                    .date!)),
                            style: const TextStyle(
                                color: Color(0x59FFFFFF),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          Provider.of<NotesData>(context)
                              .notes[widget.index]
                              .body!,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  void startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 300));
    startAnim = true;
  }
}
