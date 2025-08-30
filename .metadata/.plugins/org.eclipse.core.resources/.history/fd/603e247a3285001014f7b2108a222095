package com.lumiere.project.Controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lumiere.project.entities.FuncionarioEntities;
import com.lumiere.project.repositories.FuncionarioRepositories;

@RestController
@RequestMapping("/funcionario")
public class FuncionarioController {


	@Autowired
	FuncionarioRepositories repository;

 
	
	@CrossOrigin(origins = "http://localhost:4200")
	@PostMapping("/cadastrarFuncionario")
	public ResponseEntity<Map<String, String>> cadastroFuncionar(@RequestBody FuncionarioEntities funcionario) {
		try {
			repository.save(funcionario);
			return ResponseEntity.status(HttpStatus.CREATED).body(Map.of("sucesso", "Usuário cadastrado com sucesso"));

		} catch (DataIntegrityViolationException e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("error", "verifica os campos."));
		} catch (Exception e) {
			// CAPTURA OUTROS ERROS INESPERADOS

			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("Erro", "ERRO desconhecido"));
		}
	}

}
