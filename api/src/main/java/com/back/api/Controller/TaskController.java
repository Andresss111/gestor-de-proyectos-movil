package com.back.api.Controller;

import com.back.api.Model.Task;
import com.back.api.Service.TaskService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/tasks")
public class TaskController {

    private final TaskService taskService;

    public TaskController(TaskService taskService) {
        this.taskService = taskService;
    }

    @GetMapping
    public ResponseEntity<Object> getAllTasks() {
        List<Task> tasks = taskService.findAll();
        return ResponseEntity.ok(tasks);
    }

    @GetMapping("/{projectId}")
    public ResponseEntity<Object> getTasksByIdProject(@PathVariable Integer projectId) {
        List<Task> tasks = taskService.findByIdProject(projectId);
        return ResponseEntity.ok(tasks);
    }

    @PostMapping
    public ResponseEntity<Object> createTask(@RequestBody Task task) {
        taskService.save(task);
        return ResponseEntity.status(HttpStatus.CREATED).body("Tarea creada correctamente");
    }

    @PutMapping
    public ResponseEntity<Object> updateTask(@RequestBody Task task) {
        taskService.update(task);
        return ResponseEntity.ok("Tarea actualizada correctamente");
    }

    @DeleteMapping("/{taskId}")
    public ResponseEntity<Object> deleteTask(@PathVariable Integer taskId) {
        taskService.deleteById(taskId);
        return ResponseEntity.ok("Tarea eliminada correctamente");
    }

}
