import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dialogs/add_edit_project_dialog.dart';
import '../providers/project_provider.dart';
import '../widgets/project_item.dart';
import 'project_detail_screen.dart';

class ProjectListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 40, 16, 20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lista de Proyectos",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Revisa tus proyectos",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AddEditProjectDialog(),
                      ).then((_) {

                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    child: Text(
                      "Agregar",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: Provider.of<ProjectProvider>(context, listen: false).fetchProjects(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Consumer<ProjectProvider>(
                      builder: (ctx, projectProvider, _) {
                        return ListView.builder(
                          itemCount: projectProvider.projects.length,
                          itemBuilder: (ctx, index) {
                            return ProjectItem(
                              project: projectProvider.projects[index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProjectDetailScreen(
                                      project: projectProvider.projects[index],
                                    ),
                                  ),
                                );
                              },
                              onDelete: () {
                                projectProvider.deleteProject(projectProvider.projects[index].projectId);
                              },
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
      ),
    );
  }
}