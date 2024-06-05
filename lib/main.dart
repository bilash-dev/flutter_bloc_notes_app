import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqflite_notes_app/Bloc/note_bloc.dart';
import 'package:flutter_bloc_sqflite_notes_app/DatabaseHelper/repository.dart';
import 'package:flutter_bloc_sqflite_notes_app/Views/notes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc(Repository())..add(GetAllNoteEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AllNotes(),
      ),
    );
  }
}

