package com.lumiere.project.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lumiere.project.dto.CadastrarDTO;
import com.lumiere.project.dto.LoginDTO;
import com.lumiere.project.dto.LoginResponseDTO;
import com.lumiere.project.entities.UsersEntities;
import com.lumiere.project.infra.TokenService;
import com.lumiere.project.repositories.UsersRepositories;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/usuario")
public class UsersControllers {

	@Autowired
	private UsersRepositories repository;

	@Autowired
	TokenService tokenService;

	@Autowired
	private AuthenticationManager authenticationManager;

	@CrossOrigin(origins = "http://localhost:4200")
	@GetMapping("/buscar")
	public List<UsersEntities> listUsers() {
		return repository.findAll();
	}

	// cadastrar usuario padrão
	@CrossOrigin(origins = "http://localhost:4200")
	@PostMapping("/cadastrar")
	public ResponseEntity<Map<String, String>> criarUsuario(@RequestBody @Valid CadastrarDTO user) {
		if (this.repository.findByTelefoneAndEmailAndCpf(user.telefone(), user.email(), user.cpf()) != null) {
			return ResponseEntity.badRequest().build();
		}
		String encryptedPassword = new BCryptPasswordEncoder().encode(user.senha());
		UsersEntities newUser = new UsersEntities(user.nome(), user.cpf(), user.data_nascimento(), user.telefone(),
				user.email(), encryptedPassword, user.role());
		this.repository.save(newUser);
		return ResponseEntity.ok().build();
	}

	@CrossOrigin(origins = "http://localhost:4200")
	@PostMapping("/validar")
	public ResponseEntity login(@RequestBody @Valid LoginDTO data) {
		try {
			var usernamePassword = new UsernamePasswordAuthenticationToken(data.email(), data.senha());
			var auth = this.authenticationManager.authenticate(usernamePassword);
			// geramos o token JWT para o usuário autenticado.
			var token = tokenService.generateToken((UsersEntities) auth.getPrincipal());

			// 4. Retornamos o status 200 OK com o token no corpo da resposta.
			return ResponseEntity.ok(new LoginResponseDTO(token));

		} catch (AuthenticationException e) {
			// Retornamos um erro 401 Unauthorized, que é o correto para falha de login.
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "Login ou senha inválidos."));
		}
	}

	@CrossOrigin(origins = "http://localhost:4200")
	@DeleteMapping("/{id}")
	public String deletarUsuario(@PathVariable String id) {
		try {
			repository.deleteById(id);
			return "Usuario deletado com sucesso";
		} catch (Exception e) {
			return "não foi possível deletar o usuario " + e.getMessage();
		}
	}

}
