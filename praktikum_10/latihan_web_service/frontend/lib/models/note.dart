import 'dart:convert';

class Note {
  final int id;
  String title;
  String content;
  final DateTime date;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  // Convert a Note object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
    };
  }

  // Create a Note object from a Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }

  // Convert a Note object into a JSON string
  String toJson() {
    return '{"id": $id, "title": "$title", "content": "$content", "date": "${date.toIso8601String()}"}';
  }

  // Create a Note object from a JSON string
  factory Note.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    return Note.fromMap(map);
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, content: $content, date: $date}';
  }

  Note copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? date,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }
}
