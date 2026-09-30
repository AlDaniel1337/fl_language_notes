import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class RescanDirectoryUseCase {
  final NotesRepository repository;

  RescanDirectoryUseCase(this.repository);

  Future<Either<Failure, List<Note>>> call(String rootPath) async {
    return await repository.rescanDirectory(rootPath);
  }
}