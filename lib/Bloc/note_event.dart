part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();
}

//Get Event
class GetAllNoteEvent extends NoteEvent{
  @override
  List<Object?> get props => [];
}

//Add note event
class AddNoteEvent extends NoteEvent{
  final Notes notes;
  const AddNoteEvent(this.notes);
  @override
  List<Object?> get props =>[notes];
}

//Update note event
class UpdateNoteEvent extends NoteEvent{
  final Notes notes;
  const UpdateNoteEvent(this.notes);
  @override
  List<Object?> get props =>[notes];
}

//Delete Note event
class DeleteNoteEvent extends NoteEvent{
  final int id;
  const DeleteNoteEvent(this.id);
  @override
  List<Object?> get props => [id];
}

//Get Note by ID
class GetNoteByIDEvent extends NoteEvent{
  final int id;
  const GetNoteByIDEvent(this.id);
  @override
  List<Object?> get props => [id];
}
