class NoteEntry {
  Map<dynamic, dynamic> notes;
  String email;

  NoteEntry({
    required this.notes,
    required this.email,

  });

  Map<String, Object?> toJson() => {
        'email': email,
        'notes': notes,

      };

  static NoteEntry fromJson(Map<dynamic, dynamic>? json) => NoteEntry(
        email: json!['email'] as String,
        notes: json['notes'] as Map<dynamic, dynamic>,

      );
}
