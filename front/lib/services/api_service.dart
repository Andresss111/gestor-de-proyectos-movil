import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/project.dart';
import '../models/task.dart';

class ApiService {
  final String baseUrl = 'http://172.18.72.118:8080';

  Future<List<Project>> getProjects() async {
    final response = await http.get(Uri.parse('$baseUrl/projects'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((project) => Project.fromJson(project)).toList();
    } else {
      throw Exception('Error al cargar los proyectos');
    }
  }

  Future<Project> getProjectWithTasks(int projectId) async {
    final response = await http.get(Uri.parse('$baseUrl/projects/$projectId/with-tasks'));
    if (response.statusCode == 200) {
      return Project.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al cargar el proyecto');
    }
  }

  Future<void> addProject(Project project) async {
    final response = await http.post(
      Uri.parse('$baseUrl/projects'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': project.name,
        'description': project.description,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el proyecto');
    }
  }

  Future<void> updateProject(Project project) async {
    final response = await http.put(
      Uri.parse('$baseUrl/projects'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'projectId': project.projectId,
        'name': project.name,
        'description': project.description,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el proyecto');
    }
  }

  Future<void> deleteProject(int projectId) async {
    final response = await http.delete(Uri.parse('$baseUrl/projects/$projectId'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el proyecto');
    }
  }

  Future<void> addTask(Task task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': task.title,
        'description': task.description,
        'status': task.status,
        'projectId': task.projectId,
      }),
    );
    print("Código de estado: ${response.statusCode}");
    print("Respuesta del servidor: ${response.body}");
    if (response.statusCode != 201) {
      throw Exception('Error al crear la tarea');
    }
  }

  Future<void> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'taskId': task.taskId,
        'title': task.title,
        'description': task.description,
        'status': task.status,
        'projectId': task.projectId,
      }),
    );
    print("Código de estado: ${response.statusCode}");
    print("Respuesta del servidor: ${response.body}");
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar la tarea');
    }
  }

  Future<void> deleteTask(int taskId) async {
    final response = await http.delete(Uri.parse('$baseUrl/tasks/$taskId'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la tarea');
    }
  }
}