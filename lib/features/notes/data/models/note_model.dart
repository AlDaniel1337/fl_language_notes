import 'package:yaml/yaml.dart';
import '../../domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    required super.id,
    required super.title,
    required super.language,
    required super.category,
    required super.content,
    required super.filePath,
    super.level,
    super.tags,
  });

  /// Crea un NoteModel a partir del contenido de un archivo `.md` con Front Matter YAML
  factory NoteModel.fromMarkdown({
    required String rawContent,
    required String filePath,
    required String language,
    required String category,
  }) {
    String content = rawContent;
    String level = 'General';
    List<String> tags = [];

    // Detectar metadatos YAML en Front Matter (delimitado por ---)
    if (rawContent.startsWith('---')) {
      final parts = rawContent.split('---');
      
      // Verificar que haya al menos tres partes: antes del primer '---', el YAML y el contenido restante
      if (parts.length >= 3) {
        final yamlMap = loadYaml(parts[1]) as YamlMap?;
        if (yamlMap != null) {
          level = yamlMap['level']?.toString() ?? 'General';
          if (yamlMap['tags'] != null) {
            tags = List<String>.from(yamlMap['tags']);
          }
        }
        content = parts.sublist(2).join('---').trim();
      }

    }

    final filename = filePath.split(RegExp(r'[/\\]')).last;
    final title = filename.replaceAll('.md', '');

    return NoteModel(
      id: filePath,
      title: title,
      language: language,
      category: category,
      content: content,
      filePath: filePath,
      level: level,
      tags: tags,
    );
  }
}