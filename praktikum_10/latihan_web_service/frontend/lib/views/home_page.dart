import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'notes_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _addNewNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotesFormPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewNote,
        child: const Icon(Icons.add),
      ),
      body: MasonryGridView.builder(
        itemCount: 6,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (contex, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: RandomColor.getColorObject(
                  Options(
                    luminosity: Luminosity.light,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                loremIpsum(
                  words: Random().nextInt(40) + 10,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          );
        },
      ),
    );
  }
}
