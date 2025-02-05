import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/project_provider.dart';
import 'screens/project_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ProjectProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gestión de Proyectos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProjectListScreen(),
      ),
    );
  }
}