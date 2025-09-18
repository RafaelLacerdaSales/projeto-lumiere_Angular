package com.lumiere.project.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.lumiere.project.entities.VideosWorkshopEntities;

@Repository
public interface VideosWorkshopRepositories extends JpaRepository<VideosWorkshopEntities, Long>{

}
