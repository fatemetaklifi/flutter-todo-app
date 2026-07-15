import 'package:uuid/uuid.dart';

class Task {
  final String id;
  final String title;
  final String? description;
  final TaskPriority priority;
  final TaskStatus status;
  final DateTime createdAt;

  Task({
    String? id,
    required this.title,
    this.description,
    this.priority = TaskPriority.none,
    this.status = TaskStatus.todo,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       id = id ?? const Uuid().v4();

  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskPriority? priority,
    TaskStatus? status,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority.name,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      priority: TaskPriority.values.firstWhere(
        (value) => value.name == map['priority'],
      ),
      status: TaskStatus.values.firstWhere(
        (value) => value.name == map['status'],
      ),
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}

enum TaskPriority { high, medium, low, none }

enum TaskStatus { todo, completed }
