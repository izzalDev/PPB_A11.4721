import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan_web_service/models/models.dart';

class NoteRepository {
  final String baseUrl;

  NoteRepository({required this.baseUrl});

  // Fetch all notes
  Future<List<Note>> fetchNotes() async {
    final response = await http.get(Uri.parse('$baseUrl/notes'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((note) => Note.fromMap(note)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  // Fetch a single note by ID
  Future<Note> fetchNoteById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/notes/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Note.fromMap(data);
    } else {
      throw Exception('Failed to load note');
    }
  }

  // Create a new note
  Future<Note> createNote(Note note) async {
    print(Uri.parse('$baseUrl/notes'));
    final response = await http.post(
      Uri.parse('$baseUrl/notes'),
      body: jsonEncode(note.toMap()),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      return Note.fromMap(data);
    } else {
      print(response.body);
      throw Exception('Failed to create note');
    }
  }

  // Update an existing note
  Future<Note> updateNote(int id, Map<String, dynamic> updatedData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/notes/$id'),
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Note.fromMap(data);
    } else {
      throw Exception('Failed to update note');
    }
  }

  // Delete a note
  Future<void> deleteNote(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/notes/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete note');
    }
  }
}
