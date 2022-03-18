const String tableNotes = 'notes';

class NoteTable {
  static const String id = "_id";
  static const String isImportant = "isImportant";
  static const String number = "number";
  static const String title = "title";
  static const String description = "description";
  static const String time = "time";

  static final List<String> values = [id, isImportant, number, title, description, time];
}

class MyNote {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  MyNote({this.id, required this.isImportant, required this.number, required this.title, required this.description, required this.createdTime});

  Map<String, Object?> toJson() =>
      {
        NoteTable.id: id,
        NoteTable.title: title,
        NoteTable.isImportant: isImportant ? 1 : 0,
        NoteTable.number: number,
        NoteTable.description: description,
        NoteTable.time: createdTime.toIso8601String(),
      };

  static MyNote fromJson(Map<String, Object?> json) =>
      MyNote(
        id: json[NoteTable.id] as int?,
        number: json[NoteTable.number] as int,
        title: json[NoteTable.title] as String,
        description: json[NoteTable.description] as String,
        createdTime: DateTime.parse(json[NoteTable.time] as String),
        isImportant: json[NoteTable.isImportant] == 1,
      );

  MyNote copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      MyNote(
          isImportant: isImportant ?? this.isImportant,
          number: number ?? this.number,
          title: title ?? this.title,
          description: description ?? this.description,
          createdTime: createdTime ?? this.createdTime);
}
