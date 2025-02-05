package com.back.api.Controller;

import com.back.api.Model.Project;
import com.back.api.Service.ProjectService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequestMapping("/projects")
public class ProjectController {

    private final ProjectService projectService;

    public ProjectController(ProjectService projectService) {
        this.projectService = projectService;
    }

    @GetMapping
    public ResponseEntity<Object> getAllProjects() {
        List<Project> projects = projectService.findAll();
        return ResponseEntity.ok(projects);
    }

    @GetMapping("/{projectId}/with-tasks")
    public ResponseEntity<ProjectService.ProjectWithTasks> getProjectWithTasks(@PathVariable Integer projectId) {
        return projectService.getProjectWithTasks(projectId)
                .map(ResponseEntity::ok)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Proyecto no encontrado"));
    }

    @PostMapping
    public ResponseEntity<Object> createProject(@RequestBody Project project) {
        projectService.save(project);
        return ResponseEntity.status(HttpStatus.CREATED).body("Proyecto creado correctamente");
    }

    @PutMapping
    public ResponseEntity<Object> updateProject(@RequestBody Project project) {
        projectService.update(project);
        return ResponseEntity.ok("Proyecto actualizado correctamente");
    }

    @DeleteMapping("/{projectId}")
    public ResponseEntity<Object> deleteProject(@PathVariable Integer projectId) {
        projectService.deleteById(projectId);
        return ResponseEntity.ok("Proyecto eliminado correctamente");
    }

}
