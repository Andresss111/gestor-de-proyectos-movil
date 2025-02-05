import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  TaskItem({required this.task, required this.onUpdate, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    Color shadowColor;
    print(task.status);
    switch (task.status) {
      case 'En progreso':
        shadowColor = Colors.orange;
        break;
      case 'Completada':
        shadowColor = Colors.green;
        break;
      default:
        shadowColor = Colors.red;
        break;
    }
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.task_outlined, color: Colors.blue, size: 32),
              SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${task.description}",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      "${task.status}",
                      style: TextStyle(color: shadowColor, fontSize: 14),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: onUpdate,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
    );
  }
}