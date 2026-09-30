import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/note.dart';
import '../entities/study_card.dart';

abstract class NotesRepository {
  
  /// Escanea recursivamente el directorio raíz y re-analiza las notas
  Future<Either<Failure, List<Note>>> rescanDirectory(String rootPath);

  /// Obtiene todas las notas cargadas en memoria
  Future<Either<Failure, List<Note>>> getAllNotes();

  /// Guarda o actualiza una nota en el disco duro
  Future<Either<Failure, void>> saveNote(Note note);

  /// Elimina un archivo de nota del disco
  Future<Either<Failure, void>> deleteNote(String filePath);

  /// Genera tarjetas aleatorias mezclando todos los idiomas o uno en específico
  Future<Either<Failure, List<StudyCard>>> getRandomStudyCards({
    String? languageFilter,
    int count = 10,
  });
}