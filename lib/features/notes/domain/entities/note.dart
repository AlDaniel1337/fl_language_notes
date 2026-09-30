import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String language;
  final String category;
  final String content;
  final String filePath;
  final String level;
  final List<String> tags;

  const Note({
    required this.id,
    required this.title,
    required this.language,
    required this.category,
    required this.content,
    required this.filePath,
    this.level = 'General',
    this.tags = const [],
  });

  @override
  List<Object?> get props => [
    id,
    title,
    language,
    category,
    content,
    filePath,
    level,
    tags,
  ];
}