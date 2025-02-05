package com.back.api.Repository;

import com.back.api.Model.Project;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import com.back.api.Repository.TaskRepository;

import java.util.List;
import java.util.Optional;

@Repository
public class ProjectRepository {

    //Variable final de tipo JdbcTemplate para interactuar con la base de datos
    private final JdbcTemplate jdbcTemplate;
    private final TaskRepository taskRepository;

    //Inicializar
    public ProjectRepository(JdbcTemplate jdbcTemplate, TaskRepository taskRepository){
        this.jdbcTemplate = jdbcTemplate;
        this.taskRepository = taskRepository;
    }

    //Listar lo que se encuetra en project
    public List<Project> findAll() {
        String sql = "SELECT * FROM Project";
        return jdbcTemplate.query(sql, projectRowMapper());
    }

    public Optional<Project> findById(Integer projectId) {
        String sql = "SELECT * FROM Project WHERE projectId = ?";
        return jdbcTemplate.query(sql, projectRowMapper(), projectId).stream().findFirst();
    }

    public void save(Project project) {
        String sql = "INSERT INTO Project (name, description) VALUES (?, ?)";
        jdbcTemplate.update(sql, project.getName(), project.getDescription());
    }

    public void update(Project project) {
        String sql = "UPDATE Project SET name = ?, description = ? WHERE projectId = ?";
        jdbcTemplate.update(sql, project.getName(), project.getDescription(), project.getProjectId());
    }

    public void deleteById(Integer projectId) {
        taskRepository.deleteTasksByProjectId(projectId);

        String sql = "DELETE FROM Project WHERE projectId = ?";
        jdbcTemplate.update(sql, projectId);
    }

    //Funcion para mapear las filas
    private RowMapper<Project> projectRowMapper() {
        return (rs, rowNum) -> {
            Project project = new Project();
            project.setProjectId(rs.getInt("projectId"));
            project.setName(rs.getString("name"));
            project.setDescription(rs.getString("description"));
            return project;
        };
    }

}
