package com.back.api.Model;

import lombok.Data;

@Data
public class Task {
    private Integer taskId;
    private String title;
    private String description;
    private String status;
    private Integer projectId;

}
