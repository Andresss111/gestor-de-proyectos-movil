import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';
import '../models/task.dart';

class AddEditTaskDialog extends StatelessWidget {
  final Task? task;
  final int projectId;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedStatus = 'Por hacer';

  AddEditTaskDialog({this.task, required this.projectId}) {
    if (task != null) {
      _titleController.text = task!.title;
      _descriptionController.text = task!.description;
      _selectedStatus = task!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(task == null ? 'Agregar Tarea' : 'Editar Tarea'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El título es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La descripción es obligatoria';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: InputDecoration(labelText: 'Estado'),
                items: ['Por hacer', 'En progreso', 'Completada']
                    .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    )
                ).toList(),
                onChanged: (value) {
                  _selectedStatus = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El estado es obligatorio';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final newTask = Task(
                taskId: task?.taskId ?? 0,
                title: _titleController.text,
                description: _descriptionController.text,
                status: _selectedStatus,
                projectId: task?.projectId ?? projectId,
              );

              if (task == null) {
                await Provider.of<ProjectProvider>(context, listen: false)
                    .addTask(newTask);
              } else {
                await Provider.of<ProjectProvider>(context, listen: false)
                    .updateTask(newTask);
              }

              Navigator.pop(context);
            }
          },
          child: Text(task == null ? 'Guardar' : 'Actualizar'),
        ),
      ],
    );
  }
}