class Task {
  final int taskId;
  final String title;
  final String description;
  final String status;
  final int projectId;

  Task({
    required this.taskId,
    required this.title,
    required this.description,
    required this.status,
    required this.projectId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['taskId'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      projectId: json['projectId'],
    );
  }
}