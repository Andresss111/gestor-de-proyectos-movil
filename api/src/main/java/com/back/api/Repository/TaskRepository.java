package com.back.api.Repository;

import com.back.api.Model.Task;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TaskRepository {

    private final JdbcTemplate jdbcTemplate;

    //Inicializar
    public TaskRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Task> findAll() {
        String sql = "SELECT * FROM Task";
        return jdbcTemplate.query(sql, taskRowMapper());
    }

    public List<Task> findByIdProject(Integer projectId) {
        String sql = "SELECT * FROM Task WHERE projectId = ?";
        return jdbcTemplate.query(sql, taskRowMapper(), projectId);
    }

    public void save(Task task) {
        String sql = "INSERT INTO Task (title, description, status, projectId) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, task.getTitle(), task.getDescription(), task.getStatus(), task.getProjectId());
    }

    public void update(Task task) {
        String sql = "UPDATE Task SET title = ?, description = ?, status = ? WHERE taskId = ?";
        jdbcTemplate.update(sql, task.getTitle(), task.getDescription(), task.getStatus(), task.getTaskId());
    }

    public void deleteById(Integer taskId) {
        String sql = "DELETE FROM Task WHERE taskId = ?";
        jdbcTemplate.update(sql, taskId);
    }

    public void deleteTasksByProjectId(Integer projectId) {
        String sql = "DELETE FROM Task WHERE projectId = ?";
        jdbcTemplate.update(sql, projectId);
    }

    private RowMapper<Task> taskRowMapper() {
        return (rs, rowNum) -> {
            Task task = new Task();
            task.setTaskId(rs.getInt("taskId"));
            task.setTitle(rs.getString("title"));
            task.setDescription(rs.getString("description"));
            task.setStatus(rs.getString("status"));
            task.setProjectId(rs.getInt("projectId"));
            return task;
        };
    }
}

