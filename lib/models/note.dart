// ignore_for_file: avoid_renaming_method_parameters, unnecessary_this

Map<dynamic, dynamic> convertNoteListToMap(List<Note> notes) {
  Map<dynamic, dynamic> map = {};
  for (var i = 0; i < notes.length; i++) {
    map.addAll({'$i': notes[i].toJson()});
  }
  return map;
}

List<Note> convertMapToNoteList(Map<dynamic, dynamic> map) {
  List<Note> notes = [];
  for (var i = 0; i < map.length; i++) {
    notes.add(Note.fromJson(map['$i']));
  }
  return notes;
}

class Note {
  final String title;
  final String message;
  String? email;

  Note({
    required this.title,
    required this.message,
    this.email,
  });

  Map<String, Object?> toJson() => {
        'email': email,
        'title': title,
        'message': message,
      };

  static Note fromJson(Map<dynamic, dynamic>? json) => Note(
        email: json!['email'] as String,
        title: json['title'] as String,
        message: json['message'] as String,
      );

  @override
  bool operator ==(covariant Note note) {
    return (this.title.toUpperCase().compareTo(note.title.toUpperCase()) == 0);
  }

  @override
  int get hashCode {
    return title.hashCode;
  }
}
