import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/study_card.dart';
import 'notes_repository.dart';

/// Caso de uso para obtener tarjetas de estudio aleatorias.
/// Permite filtrar por idioma y especificar la cantidad de tarjetas a obtener.
class GetRandomStudyCardsUseCase {
  final NotesRepository repository;

  GetRandomStudyCardsUseCase(this.repository);

  Future<Either<Failure, List<StudyCard>>> call({
    String? languageFilter,
    int count = 10,
  }) async {
    return await repository.getRandomStudyCards(
      languageFilter: languageFilter,
      count: count,
    );
  }
}