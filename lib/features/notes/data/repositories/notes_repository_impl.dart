import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/note.dart';
import '../../domain/entities/study_card.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/file_system_datasource.dart';
import '../models/note_model.dart';

/// Implementación concreta de [NotesRepository] que utiliza un [FileSystemDataSource] para gestionar las notas en el sistema de archivos.
class NotesRepositoryImpl implements NotesRepository {
  final FileSystemDataSource dataSource;
  List<Note> _cachedNotes = [];

  NotesRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Note>>> rescanDirectory(String rootPath) async {
    try {
      final noteModels = await dataSource.scanDirectory(rootPath);
      _cachedNotes = noteModels;
      return Right(_cachedNotes);
    } catch (e) {
      return Left(FileSystemFailure('Error al escanear directorio: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    return Right(_cachedNotes);
  }

  @override
  Future<Either<Failure, void>> saveNote(Note note) async {
    try {
      final model = NoteModel(
        id: note.id,
        title: note.title,
        language: note.language,
        category: note.category,
        content: note.content,
        filePath: note.filePath,
        level: note.level,
        tags: note.tags,
      );
      await dataSource.saveNoteFile(model);
      return const Right(null);
    } catch (e) {
      return Left(FileSystemFailure('Error al guardar la nota: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(String filePath) async {
    try {
      await dataSource.deleteNoteFile(filePath);
      _cachedNotes.removeWhere((note) => note.filePath == filePath);
      return const Right(null);
    } catch (e) {
      return Left(FileSystemFailure('Error al eliminar la nota: $e'));
    }
  }

  @override
  Future<Either<Failure, List<StudyCard>>> getRandomStudyCards({
    String? languageFilter,
    int count = 10,
  }) async {
    // Generación de tarjetas aleatorias a partir de la lista de notas en memoria
    final filtered = languageFilter == null
        ? _cachedNotes
        : _cachedNotes.where((n) => n.language == languageFilter).toList();

    filtered.shuffle();
    final selectedNotes = filtered.take(count);

    final cards = selectedNotes.map((note) {
      return StudyCard(
        id: note.id,
        noteId: note.id,
        language: note.language,
        type: CardType.flashcard,
        question: '¿Qué tema o estructura representa: "${note.title}"?',
        answer: note.content,
      );
    }).toList();

    return Right(cards);
  }
}