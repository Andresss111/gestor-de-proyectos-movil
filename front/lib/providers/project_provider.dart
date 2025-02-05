import 'package:flutter/material.dart';
import '../models/project.dart';
import '../models/task.dart';

import '../services/api_service.dart';

class ProjectProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Project> _projects = [];
  Project? _projectDetail;

  List<Project> get projects => _projects;
  Project? get projectDetail => _projectDetail;

  Future<void> fetchProjects() async {
    _projects = await _apiService.getProjects();
    notifyListeners();
  }

  Future<void> addProject(Project project) async {
    await _apiService.addProject(project);
    await fetchProjects();
  }

  Future<void> updateProject(Project project) async {
    await _apiService.updateProject(project);
    await getProjectWithTasks(project.projectId);
    await fetchProjects();
  }

  Future<void> deleteProject(int projectId) async {
    await _apiService.deleteProject(projectId);
    await fetchProjects();
  }

  Future<void> getProjectWithTasks(int projectId) async {
    _projectDetail = await _apiService.getProjectWithTasks(projectId);
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _apiService.addTask(task);
    await getProjectWithTasks(task.projectId);
  }

  Future<void> updateTask(Task task) async {
    await _apiService.updateTask(task);
    await getProjectWithTasks(task.projectId);
  }

  Future<void> deleteTask(Task task) async {
    await _apiService.deleteTask(task.taskId);
    await getProjectWithTasks(task.projectId);
  }
}