package com.back.api.Service;

import com.back.api.Model.Task;
import com.back.api.Repository.TaskRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TaskService {

    private final TaskRepository taskRepository;

    public TaskService(TaskRepository taskRepository) {
        this.taskRepository = taskRepository;
    }

    public List<Task> findAll() {
        return taskRepository.findAll();
    }

    public List<Task> findByIdProject(Integer projectId) {
        return taskRepository.findByIdProject(projectId);
    }

    public void save(Task task){
        taskRepository.save(task);
    }

    public void update(Task task) {
        taskRepository.update(task);
    }

    public void deleteById(Integer taskId) {
        taskRepository.deleteById(taskId);
    }

}
