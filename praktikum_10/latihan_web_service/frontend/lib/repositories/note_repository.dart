import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan_web_service/models/models.dart';

class NoteRepository {
  final Uri baseUrl;

  NoteRepository({required this.baseUrl});

  // Fetch all notes
  Future<List<Note>> getNotes() async {
    final response = await http.get(
      baseUrl.resolve('/notes'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((note) => Note.fromMap(note)).toList();
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }

  // Fetch a single note by ID
  Future<Note> fetchNoteById(int id) async {
    final response = await http.get(
      baseUrl.resolve('/notes/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Note.fromMap(data);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }

  // Create a new note
  Future<Note> createNote(Note note) async {
    final response = await http.post(
      baseUrl.resolve('/notes'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': note.title,
        'content': note.content,
        'date': note.date.toIso8601String(),
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      return Note.fromMap(data);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }

  // Update an existing note
  Future<Note> updateNote(int id, Map<String, dynamic> updatedData) async {
    final response = await http.put(
      baseUrl.resolve('/notes/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Note.fromMap(data);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }

  // Delete a note
  Future<bool> deleteNote(int id) async {
    final response = await http.delete(
      baseUrl.resolve('/notes/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }

    return true;
  }
}
