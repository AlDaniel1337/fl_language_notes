import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:language_notes/features/notes/domain/entities/note.dart';
import 'package:language_notes/features/notes/domain/repositories/notes_repository.dart';
import 'package:language_notes/features/notes/domain/usecases/rescan_directory.dart';
import 'package:mocktail/mocktail.dart';


// 1. Creamos una clase Mock que simula el repositorio real
class MockNotesRepository extends Mock implements NotesRepository {}

void main() {
  late RescanDirectoryUseCase useCase;
  late MockNotesRepository mockNotesRepository;

  // setUp se ejecuta antes de CADA test individual
  setUp(() {
    mockNotesRepository = MockNotesRepository();
    useCase = RescanDirectoryUseCase(mockNotesRepository);
  });

  const tRootPath = '_notas_estudio';
  const tNote = Note(
    id: '1',
    title: 'de',
    language: 'japones',
    category: 'Particulas',
    content: '# Partícula De',
    filePath: '_notas_estudio/japones/Particulas/de.md',
  );

  final tNotesList = [tNote];

  test(
    'debe obtener la lista de notas desde el repositorio al escanear el directorio',
    () async {
      // ARRANGE: Decimos al mock qué responder cuando llamen a rescanDirectory
      when(() => mockNotesRepository.rescanDirectory(tRootPath))
          .thenAnswer((_) async => Right(tNotesList));

      // ACT: Ejecutamos el Caso de Uso
      final result = await useCase(tRootPath);

      // ASSERT: Verificamos resultados
      expect(result, Right(tNotesList));
      
      // Verificamos que el método del repositorio se llamó exactamente 1 vez con el parámetro correcto
      verify(() => mockNotesRepository.rescanDirectory(tRootPath)).called(1);
      verifyNoMoreInteractions(mockNotesRepository);
    },
  );
}