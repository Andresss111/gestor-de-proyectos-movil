import 'package:front/models/task.dart';

class Project {
  final int projectId;
  final String name;
  final String description;
  List<Task> tasks;

  Project({
    required this.projectId,
    required this.name,
    required this.description,
    this.tasks = const [],
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      projectId: json['projectId'],
      name: json['name'],
      description: json['description'],
      tasks: (json['tasks'] != null)
          ? (json['tasks'] as List).map((task) => Task.fromJson(task)).toList()
          : []
    );
  }
}
