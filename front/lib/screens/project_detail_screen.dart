import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dialogs/add_edit_project_dialog.dart';
import '../dialogs/add_edit_task_dialog.dart';
import '../models/project.dart';
import '../providers/project_provider.dart';
import '../widgets/task_item.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  ProjectDetailScreen({required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
            'Detalle del Proyecto',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
        actions: [

        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ProjectProvider>(context, listen: false).getProjectWithTasks(project.projectId),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar el proyecto'));
          } else {
            return Consumer<ProjectProvider>(
              builder: (ctx, projectProvider, _) {
                final project = projectProvider.projectDetail;
                if (project == null) {
                  return Center(child: Text('No se encontró el proyecto'));
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.name,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  project.description,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AddEditProjectDialog(
                                      project: project,
                                    ),
                                  ).then((_) {

                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _deleteDialog(
                                      context,
                                      '¿Quieres eliminar este proyecto?',
                                      () async {
                                        await Provider.of<ProjectProvider>(context, listen: false)
                                            .deleteProject(project.projectId);
                                        Navigator.pop(ctx);
                                        Navigator.pop(context);
                                      }
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: project.tasks.length,
                        itemBuilder: (ctx, index) {
                          return TaskItem(
                            task: project.tasks[index],
                            onUpdate: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AddEditTaskDialog(
                                  task: project.tasks[index],
                                  projectId: project.tasks[index].projectId,
                                ),
                              ).then((_) {

                              });
                            },
                            onDelete: () {
                              _deleteDialog(
                                  context,
                                  '¿Quieres eliminar esta tarea?',
                                  () async {
                                    await Provider.of<ProjectProvider>(context, listen: false)
                                        .deleteTask(project.tasks[index]);
                                    Navigator.pop(ctx);
                                  }
                              );

                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AddEditTaskDialog(
              projectId: project.projectId,
            ),
          ).then((_) {

          });
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _deleteDialog(BuildContext context, String msgContent, VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('¿Estás seguro?'),
        content: Text(msgContent),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              'Eliminar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

}