class Task {
  int? id;
  final String title;
  final String description;
  bool done;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.done = false,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    bool? done,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'done': done ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      done: map['done'] == 1,
    );
  }

  Map<String, dynamic> toMapLegacy() {
    return {
      'title': title,
      'desc': description,
      'done': done,
    };
  }
}
