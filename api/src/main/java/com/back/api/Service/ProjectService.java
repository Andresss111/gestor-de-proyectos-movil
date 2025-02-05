package com.back.api.Service;

import com.back.api.Model.Project;
import com.back.api.Model.Task;
import com.back.api.Repository.ProjectRepository;
import com.back.api.Repository.TaskRepository;
import lombok.Data;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProjectService {

    private final ProjectRepository projectRepository;
    private final TaskRepository taskRepository;

    public ProjectService(ProjectRepository projectRepository, TaskRepository taskRepository) {
        this.projectRepository = projectRepository;
        this.taskRepository = taskRepository;
    }

    public List<Project> findAll() {
        return projectRepository.findAll();
    }

    public Optional<ProjectWithTasks> getProjectWithTasks(Integer projectId) {
        Optional<Project> projectOpt = projectRepository.findById(projectId);

        if (projectOpt.isPresent()) {
            Project project = projectOpt.get();
            List<Task> tasks = taskRepository.findByIdProject(projectId);
            ProjectWithTasks projectWithTasks = new ProjectWithTasks();
            projectWithTasks.setProjectId(project.getProjectId());
            projectWithTasks.setName(project.getName());
            projectWithTasks.setDescription(project.getDescription());
            projectWithTasks.setTasks(tasks);
            return Optional.of(projectWithTasks);
        } else {
            return Optional.empty();
        }
    }

    @Data
    public static class ProjectWithTasks {
        private Integer projectId;
        private String name;
        private String description;
        private List<Task> tasks;
    }

    public void save(Project project){
        projectRepository.save(project);
    }

    public void update(Project project) {
        projectRepository.update(project);
    }

    public void deleteById(Integer projectId) {
        projectRepository.deleteById(projectId);
    }

}
