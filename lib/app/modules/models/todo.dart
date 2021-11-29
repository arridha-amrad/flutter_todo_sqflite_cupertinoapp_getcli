import 'package:todo_sqflite/app/modules/database/todo_fields.dart';

class Todo {
  int? id;
  String description;
  String title;
  bool isComplete;
  DateTime createdAt;
  DateTime? updatedAt;

  Todo({
    required this.title,
    required this.description,
    required this.isComplete,
    required this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory Todo.fromMap(Map<String, Object?> map) => Todo(
        id: map[TodoFields.id] as int,
        title: map[TodoFields.title] as String,
        description: map[TodoFields.description] as String,
        isComplete: map[TodoFields.isComplete] == 1,
        createdAt: DateTime.parse(map[TodoFields.createdAt] as String),
        updatedAt: map[TodoFields.updatedAt] != null
            ? DateTime.parse(map[TodoFields.updatedAt] as String)
            : null,
      );

  Map<String, Object?> toMap() => {
        TodoFields.title: title,
        TodoFields.description: description,
        TodoFields.createdAt: createdAt.toIso8601String(),
        TodoFields.isComplete: isComplete ? 1 : 0,
        TodoFields.updatedAt:
            updatedAt != null ? updatedAt!.toIso8601String() : null,
      };

  Todo copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isComplete,
  }) =>
      Todo(
        id: id ?? id,
        title: title ?? this.title,
        description: description ?? this.description,
        isComplete: isComplete ?? this.isComplete,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
