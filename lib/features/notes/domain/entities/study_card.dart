import 'package:equatable/equatable.dart';

enum CardType { flashcard, audioExercise, fillBlank }

class StudyCard extends Equatable {
  final String id;
  final String noteId;
  final String language;
  final CardType type;
  final String question;
  final String answer;
  final String? audioPath;
  final List<String>? options;

  const StudyCard({
    required this.id,
    required this.noteId,
    required this.language,
    required this.type,
    required this.question,
    required this.answer,
    this.audioPath,
    this.options,
  });

  @override
  List<Object?> get props => [
    id,
    noteId,
    language,
    type,
    question,
    answer,
    audioPath,
    options,
  ];
}