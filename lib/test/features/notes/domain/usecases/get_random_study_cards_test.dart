import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:language_notes/features/notes/domain/entities/study_card.dart';
import 'package:language_notes/features/notes/domain/repositories/get_random_study_cards.dart';
import 'package:language_notes/features/notes/domain/repositories/notes_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockNotesRepository extends Mock implements NotesRepository {}

void main() {
  late GetRandomStudyCardsUseCase useCase;
  late MockNotesRepository mockNotesRepository;

  setUp(() {
    mockNotesRepository = MockNotesRepository();
    useCase = GetRandomStudyCardsUseCase(mockNotesRepository);
  });

  const tCards = [
    StudyCard(
      id: 'c1',
      noteId: 'n1',
      language: 'japones',
      type: CardType.flashcard,
      question: '¿Qué significa 〜そう?',
      answer: 'Apariencia o probabilidad visual',
    ),
  ];

  test(
    'debe obtener tarjetas aleatorias del repositorio filtradas por idioma',
    () async {
      // ARRANGE
      when(() => mockNotesRepository.getRandomStudyCards(
            languageFilter: 'japones',
            count: 5,
          )).thenAnswer((_) async => const Right(tCards));

      // ACT
      final result = await useCase(languageFilter: 'japones', count: 5);

      // ASSERT
      expect(result, const Right(tCards));
      verify(() => mockNotesRepository.getRandomStudyCards(
            languageFilter: 'japones',
            count: 5,
          )).called(1);
    },
  );
}