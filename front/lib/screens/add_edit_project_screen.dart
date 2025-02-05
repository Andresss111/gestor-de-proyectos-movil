import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';
import '../models/project.dart';

class AddEditProjectScreen extends StatelessWidget {
  final Project? project;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  AddEditProjectScreen({this.project}) {
    if (project != null) {
      _nameController.text = project!.name;
      _descriptionController.text = project!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project == null ? 'Agregar Proyecto' : 'Editar Proyecto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newProject = Project(
                      projectId: project?.projectId ?? 0,
                      name: _nameController.text,
                      description: _descriptionController.text,
                    );

                    if (project == null) {

                      Provider.of<ProjectProvider>(context, listen: false)
                          .addProject(newProject);
                    } else {

                      Provider.of<ProjectProvider>(context, listen: false)
                          .updateProject(newProject);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(project == null ? 'Guardar' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}