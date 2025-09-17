package com.lumiere.project.controllers;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lumiere.project.dto.AulaWorkshopDTO;
import com.lumiere.project.dto.BuscarAulaWorkshop;
import com.lumiere.project.entities.VideosWorkshopEntities;
import com.lumiere.project.entities.WorkshopEntities;
import com.lumiere.project.repositories.VideosWorkshopRepositories;
import com.lumiere.project.repositories.WorkShopRepositories;

@RestController
@RequestMapping("/aulas")
public class VideosWorkshopController {

	@Autowired
	WorkShopRepositories workshopRepositories;

	@Autowired
	VideosWorkshopRepositories videosRepositories;

	@CrossOrigin(origins = "http://localhost:4200")
	@PostMapping("/adicionarAula/{id}")
	public ResponseEntity adicionarAula(@PathVariable Long id, @RequestBody AulaWorkshopDTO aula) {
		Optional<WorkshopEntities> optionalWorkshop = workshopRepositories.findById(id);
		if (optionalWorkshop.isEmpty()) {
			return ResponseEntity.badRequest().body(Map.of("error", "curso não existe"));
		}
		WorkshopEntities curso = optionalWorkshop.get();

		VideosWorkshopEntities wk = new VideosWorkshopEntities(aula.titulo(), aula.urlDaAula(), aula.descricao(),
				curso);

		videosRepositories.save(wk);
		return ResponseEntity.status(HttpStatus.CREATED).body(Map.of("sucesso", "curso cadastrado"));
	}

	@CrossOrigin(origins = "http://localhost:4200")
	@DeleteMapping("/deletarAula/{id}")
	public ResponseEntity deletarAula(@PathVariable Long id, @RequestBody AulaWorkshopDTO aula) {
		Optional<VideosWorkshopEntities> optionalWorkshop = videosRepositories.findById(id);
		try {
			if (optionalWorkshop.isEmpty()) {
				return ResponseEntity.badRequest().body(Map.of("error", "aula não existe"));
			}

			videosRepositories.deleteById(id);
			return ResponseEntity.ok().body(Map.of("sucesso", "curso deletado"));
		
		} catch (Exception e) {
			return ResponseEntity.badRequest().body(Map.of("error", "error inesperado"));
		}

	}
	@GetMapping("/buscar")
	public List<BuscarAulaWorkshop> listUsers() {
		return videosRepositories.findAll().stream()
				.map(u -> new BuscarAulaWorkshop(u.getId(), u.getTitulo(), u.getUrlDaAula(), u.getDescricao())).toList();
	}

}
