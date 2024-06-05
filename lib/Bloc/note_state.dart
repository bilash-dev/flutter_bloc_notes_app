part of 'note_bloc.dart';

sealed class NoteState extends Equatable {
  const NoteState();
}

final class NoteInitial extends NoteState {
  @override
  List<Object> get props => [];
}

//loading state
class LoadingState extends NoteState{
  @override
  List<Object?> get props => [];
}

//Get all notes State
class LoadedState extends NoteState{
  final List<Notes> allNotes;
  const LoadedState(this.allNotes);
  @override
  List<Object?> get props => [allNotes];
}

//In case when there is an error
class FailureState extends NoteState{
  final String errorMessage;
  const FailureState(this.errorMessage);

  @override
  List<Object?> get props =>[errorMessage];
}

//Get Note by ID
class GetNoteByIdState extends NoteState{
  final Notes notes;
  const GetNoteByIdState(this.notes);
  @override
  List<Object?> get props => [notes];
}

//Success Note Add Insertion
final class SuccessNoteInsertion extends NoteState{
  @override
  List<Object?> get props => [];
}
//Success Note Update
class SuccessNoteUpdate extends NoteState{
  @override
  List<Object?> get props => [];
}

//Success Note Delete
class SuccessNoteDelete extends NoteState{
  @override
  List<Object?> get props => [];
}