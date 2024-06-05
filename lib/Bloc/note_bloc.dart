import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_sqflite_notes_app/DatabaseHelper/repository.dart';
import '../Model/notes.dart';
part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final Repository repository;
  NoteBloc(this.repository) : super(NoteInitial()) {

    //Event Controllers
    //Get All Notes Event
    on<GetAllNoteEvent>((event, emit) async{
     emit(LoadingState());
     try{
       final notes = await repository.getNotes();
       emit(LoadedState(notes));
     }catch(e){
       emit(FailureState(e.toString()));
     }
    });

    //Add Note Event [on Add Button]
    on<AddNoteEvent>((event, emit)async{
      emit(LoadingState());
      try{
        //1 sec delay
        Future.delayed(const Duration(seconds: 1));
        int res = await repository.addNote(Notes(
            title: event.notes.title,
            content: event.notes.content,
            createdAt: event.notes.createdAt));
        if(res>0){
          emit(SuccessNoteInsertion());
          //Call fetch note event, once there is a new note
          add(GetAllNoteEvent());
        }
      }catch(e){
        emit(FailureState(e.toString()));
      }
    });

    //Delete Note Event - when [on delete button] is pressed
    on<DeleteNoteEvent>((event, emit) async{
      emit(LoadingState());
      try{
        //1 sec delay
        Future.delayed(const Duration(seconds: 1));
       final res = await repository.deleteNote(event.id);
       if(res>0){
         emit(SuccessNoteDelete());
         add(GetAllNoteEvent());
       }
      }catch(e){
        emit(FailureState(e.toString()));
      }
    });

    //Get note by ID [on a single note click]
    on<GetNoteByIDEvent>((event, emit) async{
      final notes = await repository.getNoteById(event.id);
      emit(GetNoteByIdState(notes));
    });

    //Update Note Event -when[On update button] is pressed
    on<UpdateNoteEvent>((event, emit)async{
      emit(LoadingState());
      try{
        //1 sec delay
        // Future.delayed(const Duration(seconds: 1));
        final res = await repository.updateNote(Notes(
            noteId: event.notes.noteId,
            title: event.notes.title,
            content: event.notes.content,
            createdAt: event.notes.createdAt));
        if(res>0){
          emit(SuccessNoteUpdate());
          add(GetAllNoteEvent());
        }
      }catch(e){
        emit(FailureState(e.toString()));
      }
    });
  }
}
