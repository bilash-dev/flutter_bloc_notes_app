import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqflite_notes_app/Bloc/note_bloc.dart';
import 'package:flutter_bloc_sqflite_notes_app/Views/add_note.dart';
import 'package:flutter_bloc_sqflite_notes_app/Views/update_note.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class AllNotes extends StatefulWidget {
  const AllNotes({Key? key}) : super(key: key);

  @override
  State<AllNotes> createState() => _AllNotesState();
}

class _AllNotesState extends State<AllNotes> {

  @override
  void initState() {
    //Fetch Notes in initial state
    context.read<NoteBloc>().add(GetAllNoteEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddNote()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('Notes'),),
      body: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state){
          if(state is GetNoteByIdState){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const UpdateNote()));
          }
        },
        builder: (context, state){
          if(state is LoadedState){
            return state.allNotes.isEmpty ? const Center(child: Text("No Data"))
            : MasonryGridView.builder(
                gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: state.allNotes.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      context.read<NoteBloc>().add(GetNoteByIDEvent(state.allNotes[index].noteId!));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.amberAccent.withOpacity(.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.allNotes[index].title,style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                          Text(state.allNotes[index].content,),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(dateFormat(state.allNotes[index].createdAt),
                              style: const TextStyle(fontWeight: FontWeight.bold),),
                              IconButton(onPressed: (){
                                context.read<NoteBloc>().add(DeleteNoteEvent(state.allNotes[index].noteId!));
                              }, icon: const Icon(Icons.delete))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
            );
          }
          return Container();
        },
      ),
    );
  }

  String dateFormat(String date){
    final DateFormat dateFormat = DateFormat("H:mm aa");
    return dateFormat.format(DateTime.parse(date));
  }
}
