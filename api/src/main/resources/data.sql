CREATE TABLE Project (
    projectId INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE Task (
    taskId INTEGER AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    status VARCHAR(50),
    projectId INTEGER,
    FOREIGN KEY (projectId) REFERENCES Project(projectId)
);

INSERT INTO Project (name, description) VALUES ('Proyecto 1', 'Descripcion del Proyecto 1');
INSERT INTO Project (name, description) VALUES ('Proyecto 2', 'Descripcion del Proyecto 2');

INSERT INTO Task (title, description, status, projectId) VALUES ('Tarea 1', 'Descripcion de la Tarea 1', 'Por hacer', 1);
INSERT INTO Task (title, description, status, projectId) VALUES ('Tarea 2', 'Descripcion de la Tarea 2', 'En progreso', 2);
INSERT INTO Task (title, description, status, projectId) VALUES ('Tarea 3', 'Descripcion de la Tarea 3', 'Completada', 2);