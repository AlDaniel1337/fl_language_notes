import 'dart:io';
import '../models/note_model.dart';

/// Interfaz para el acceso al sistema de archivos para las notas. 
/// Proporciona métodos para escanear directorios, guardar y eliminar archivos de notas.
abstract class FileSystemDataSource {
  Future<List<NoteModel>> scanDirectory(String rootPath);
  Future<void> saveNoteFile(NoteModel note);
  Future<void> deleteNoteFile(String filePath);
}



/// Implementación concreta de [FileSystemDataSource] que interactúa con el sistema de archivos.
class FileSystemDataSourceImpl implements FileSystemDataSource {
  @override
  Future<List<NoteModel>> scanDirectory(String rootPath) async {
    
    //: Verificar si el directorio raíz existe
    final rootDir = Directory(rootPath);
    if (!await rootDir.exists()) return [];

    final List<NoteModel> notes = [];

    //: Recorrer la estructura 
    // ej: _notas_estudio / [idioma] / [categoria] / nota.md
    await for (final entity in rootDir.list(recursive: true)) {

      //: Verificar si la entidad es un archivo Markdown
      if (entity is File && entity.path.endsWith('.md')) {
        final normalizedPath = entity.path.replaceAll('\\', '/');
        final parts = normalizedPath.split('/');

        // Se esperan al menos 3 partes tras la raíz: idioma/categoria/archivo.md
        if (parts.length >= 3) {
          final language = parts[parts.length - 3];
          final category = parts[parts.length - 2];
          final rawContent = await entity.readAsString();

          notes.add(NoteModel.fromMarkdown(
            rawContent: rawContent,
            filePath: entity.path,
            language: language,
            category: category,
          ));
        }
      }
    }
    return notes;
  }

  @override
  Future<void> saveNoteFile(NoteModel note) async {
    final file = File(note.filePath);
    await file.create(recursive: true);
    await file.writeAsString(note.content);
  }

  @override
  Future<void> deleteNoteFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}