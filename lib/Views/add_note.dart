import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqflite_notes_app/Model/notes.dart';
import '../Bloc/note_bloc.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final title = TextEditingController();
  final content = TextEditingController();
  String createdAt = DateTime.now().toIso8601String();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      listener: (context, state) {
        if(state is SuccessNoteInsertion){
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Add Note'),
            actions: [
              state is LoadingState? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ) : IconButton(onPressed: () {
                context.read<NoteBloc>().add(AddNoteEvent(Notes(
                  title: title.text,
                  content: content.text,
                  createdAt: createdAt,
                )));
              },
                  icon: const Icon(Icons.check))
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: title,
                  decoration: const InputDecoration(
                    hintText: "Title",
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: content,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Content",
                    // border: InputBorder.none,
                  ),
                )
              ],
            ),
          ),

        );
      },
    );
  }
}
