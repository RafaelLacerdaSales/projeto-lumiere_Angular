package com.lumiere.project.controllers;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lumiere.project.dto.CursoDTO;
import com.lumiere.project.entities.WorkshopEntities;
import com.lumiere.project.repositories.WorkShopRepositories;

@RestController
@RequestMapping("/workshop")
public class WorkshopController {

	@Autowired
	WorkShopRepositories repository;

	@CrossOrigin(origins = "http://localhost:4200")
	@PostMapping("/cadastrar")
	public ResponseEntity cadastrarCurso(@RequestBody CursoDTO curso) {
		WorkshopEntities wk = new WorkshopEntities(curso.tituloDoCurso(), curso.descricao(), curso.preco(),
				curso.caminhoDaCapa());
		repository.save(wk);
		return ResponseEntity.ok().body(Map.of("sucesso", "curso cadastrado"));
	}

	@GetMapping("/buscar")
	public List<CursoDTO> listUsers() {
		return repository.findAll().stream()
				.map(u -> new CursoDTO(u.getId(), u.getTituloDoCurso(), u.getDescricao(), u.getPreco(), u.getCaminhoDaCapa()))
				.toList();
	}

	@CrossOrigin(origins = "http://localhost:4200")
	@DeleteMapping("delete/{id}")
	public  ResponseEntity  deletarUsuario(@PathVariable Long id) {
		try {
			repository.deleteById(id);
			return ResponseEntity.ok().body(Map.of("sucesso", "Curso deletado"));
		} catch (Exception e) {
			return ResponseEntity.ok().body(Map.of("error", "Não foi possível achar o curso"));
		}
	}

	@CrossOrigin(origins = "http://localhost:4200")
	@PutMapping("/atualizar/{id}")
	@Transactional
	public ResponseEntity atualizarCapa(@PathVariable Long id, @RequestBody CursoDTO curso) {
		Optional<WorkshopEntities> optionalWorkshop = repository.findById(id); // o optional sempre verifica se existe
																				// ou n
		if (optionalWorkshop.isEmpty()) {
			System.out.println("!! ERRO: CURSO COM ID " + id + " NÃO ENCONTRADO !!");
			return ResponseEntity.badRequest().body(Map.of("error", "não foi possívela achar o curso"));
		}
		
		WorkshopEntities workshop = optionalWorkshop.get();
		
		if (curso.tituloDoCurso() != null && !curso.tituloDoCurso().isBlank()) {
			workshop.setTituloDoCurso(curso.tituloDoCurso());
		}
		
		if (curso.preco() != null && !curso.preco().isBlank()) {
			workshop.setPreco(curso.preco());
		}
		
		if (curso.descricao() != null && !curso.descricao().isBlank()) {
			workshop.setDescricao(curso.descricao());
		}
		
		if (curso.caminhoDaCapa() != null && !curso.caminhoDaCapa().isBlank()) {
			workshop.setCaminhoDaCapa(curso.caminhoDaCapa());
		}
			
		repository.save(workshop);

		return ResponseEntity.ok().body(Map.of("sucesso", "curso atualizado"));
	}

}
