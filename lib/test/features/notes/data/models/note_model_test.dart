import 'package:flutter_test/flutter_test.dart';
import 'package:language_notes/features/notes/data/models/note_model.dart';

void main() {
  group('NoteModel.fromMarkdown', () {
    test('debe parsear correctamente el Front Matter YAML y el cuerpo Markdown', () {
      const rawContent = 
'''---
level: N5
tags:
  - Partículas
  - Gramática
---

# Partícula De (で)
Indica el lugar donde se realiza una acción.
''';

      final model = NoteModel.fromMarkdown(
        rawContent: rawContent,
        filePath: '_notas_estudio/japones/Particulas/de.md',
        language: 'japones',
        category: 'Particulas',
      );

      expect(model.title, 'de');
      expect(model.level, 'N5');
      expect(model.tags, ['Partículas', 'Gramática']);
      expect(model.language, 'japones');
      expect(model.category, 'Particulas');
      expect(model.content, contains('# Partícula De (で)'));
    });
  });
}