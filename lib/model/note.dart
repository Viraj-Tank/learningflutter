const String tableNotes = 'notes';

class NoteTable {
  static const String id = "_id";
  static const String isImportant = "isImportant";
  static const String number = "number";
  static const String title = "title";
  static const String description = "description";
  static const String time = "time";
}

class MyNote {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  MyNote(
      {this.id,
      required this.isImportant,
      required this.number,
      required this.title,
      required this.description,
      required this.createdTime});
}