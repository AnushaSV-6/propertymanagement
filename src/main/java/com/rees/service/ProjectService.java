package com.rees.service;

import com.rees.dto.ProjectDTO;
import com.rees.model.Project;
import com.rees.mapper.ProjectMapper;
import com.rees.repository.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ProjectService {

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private ProjectMapper projectMapper;

    public List<ProjectDTO> getAllProjects() {
        return projectRepository.findAll()
                .stream()
                .map(projectMapper::toDTO)
                .collect(Collectors.toList());
    }

    public ProjectDTO getProjectById(int id) {
        Optional<Project> project = projectRepository.findById(id);
        return project.map(projectMapper::toDTO).orElse(null);
    }

    public boolean saveProject(ProjectDTO dto) {
        try {
            projectRepository.save(projectMapper.toEntity(dto));
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateProject(ProjectDTO dto) {
        if (dto.getProjectId() == null) return false;
        Optional<Project> optional = projectRepository.findById(dto.getProjectId());
        if (!optional.isPresent()) return false;
        projectRepository.save(projectMapper.toEntity(dto));
        return true;
    }
}
