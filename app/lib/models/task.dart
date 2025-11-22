class Task {
  final String title;
  final String description;
  bool done;

  Task({
    required this.title,
    required this.description,
    this.done = false,
  });

  Task copyWith({
    String? title,
    String? description,
    bool? done,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': description,
      'done': done,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      description: map['desc'] ?? '',
      done: map['done'] ?? false,
    );
  }
}
