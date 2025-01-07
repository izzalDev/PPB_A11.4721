import 'package:flutter/material.dart';
import 'package:latihan_web_service/models/models.dart';
import 'package:latihan_web_service/repositories/repositories.dart';

class NotesFormPage extends StatefulWidget {
  final Note? note;

  const NotesFormPage({super.key, this.note});

  @override
  State<NotesFormPage> createState() => _NotesFormPageState();
}

class _NotesFormPageState extends State<NotesFormPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }
  }

  void _saveButtonAction() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      _showSnackBar(content: 'Judul dan konten tidak boleh kosong.');
      return;
    }

    try {
      final repository = NoteRepository(
          baseUrl: 'http://localhost:8080'); // Ganti dengan URL backend Anda

      if (widget.note == null) {
        // Tambah catatan baru
        final newNote = Note(
          id: 0, // ID akan diatur oleh backend
          title: title,
          content: content,
          date: DateTime.now(),
        );
        await repository.createNote(newNote);
        _showSnackBar(content: 'Catatan berhasil ditambahkan.');
      } else {
        // Perbarui catatan yang ada
        final updatedNote = widget.note!.copyWith(
          title: title,
          content: content,
        );
        await repository.updateNote(updatedNote.id, updatedNote.toMap());
        _showSnackBar(content: 'Catatan berhasil diperbarui.');
      }

      Navigator.pop(context, true); // Kembali ke layar sebelumnya
    } catch (e) {
      print(e);
      _showSnackBar(content: 'Gagal menyimpan catatan.');
    }
  }

  void _showSnackBar({required String content}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.note != null;

    return Scaffold(
      appBar:
          AppBar(title: Text(isUpdate ? 'Perbarui Catatan' : 'Buat Catatan')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: contentController,
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Konten',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveButtonAction,
                child: Text(isUpdate ? 'Perbarui Catatan' : 'Simpan Catatan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
