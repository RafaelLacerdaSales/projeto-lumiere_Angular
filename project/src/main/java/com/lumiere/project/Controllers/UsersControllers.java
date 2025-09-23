package com.lumiere.project.Controllers;

import java.util.List;
import java.util.Map;
import java.util.Optional;

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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lumiere.project.dto.BuscarDadosUserDTO;
import com.lumiere.project.dto.CadastrarDTO;
import com.lumiere.project.dto.LoginDTO;
import com.lumiere.project.dto.LoginResponseDTO;
import com.lumiere.project.entities.UsersEntities;
import com.lumiere.project.entities.VideosWorkshopEntities;
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
	@GetMapping("/buscarTodos")
	public List<BuscarDadosUserDTO> listUsers() {
		return repository.findAll().stream().map(u -> new BuscarDadosUserDTO(u.getIdUser().toString(), u.getNome(),
				u.getEmail(), u.getTelefone(), u.getCpf())).toList();
	}

	// cadastrar usuario padrão
	@CrossOrigin(origins = "http://localhost:4200")
	@PostMapping("/cadastrar")
	public ResponseEntity<Map<String, String>> criarUsuario(@RequestBody @Valid CadastrarDTO user) {
		if (this.repository.findByTelefoneAndEmailAndCpf(user.telefone(), user.email(), user.cpf()) != null) {
			return ResponseEntity.badRequest().body(Map.of("error", "Algum campo está em uso"));
		}
		String encryptedPassword = new BCryptPasswordEncoder().encode(user.senha());
		UsersEntities newUser = new UsersEntities(user.nome(), user.cpf(), user.data_nascimento(), user.telefone(),
				user.email(), encryptedPassword, user.role());
		this.repository.save(newUser);
		return ResponseEntity.ok().body(Map.of("sucesso", "cadastro concluido"));
	}

	@CrossOrigin(origins = "http://localhost:4200")
	@PostMapping("/validar")
	public ResponseEntity login(@RequestBody @Valid LoginDTO data) {
		try {
			var usernamePassword = new UsernamePasswordAuthenticationToken(data.email(), data.senha());
			var auth = this.authenticationManager.authenticate(usernamePassword);
			// geramos o token JWT para o usuário autenticado.
			var token = tokenService.generateToken((UsersEntities) auth.getPrincipal());

			var usuarioAutenticado = (UsersEntities) auth.getPrincipal();

			// UsersEntities u = null;
			BuscarDadosUserDTO dados = new BuscarDadosUserDTO(usuarioAutenticado.getIdUser().toString(),
					usuarioAutenticado.getNome(), usuarioAutenticado.getEmail(), usuarioAutenticado.getTelefone(),
					usuarioAutenticado.getCpf());

			LoginResponseDTO response = new LoginResponseDTO(token, dados);
			// 4. Retornamos o status 200 OK com o token no corpo da resposta.
			return ResponseEntity.ok().body(response);

		} catch (AuthenticationException e) {
			// Retornamos um erro 401 Unauthorized, que é o correto para falha de login.
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "Login ou senha inválidos."));
		}
	}

	@CrossOrigin(origins = "http://localhost:4200")
	@DeleteMapping("/{id}")
	public ResponseEntity<?> deletarUsuario(@PathVariable String id) {
		try {
			Optional<UsersEntities> userId = repository.findById(id);
			if (userId.isEmpty()) {
				return ResponseEntity.badRequest().body(Map.of("error", "usuario não encontrado no banco de dados"));
			}
			repository.deleteById(id);
			return ResponseEntity.ok().body(Map.of("sucess", "usuario deletado"));
		} catch (Exception e) {
			return ResponseEntity.badRequest().body(Map.of("error", "Erro inesperado"));
		}
	}

	@CrossOrigin(origins = "http://localhost:4200")
	@PutMapping("/atualizar/{idUser}")
	public ResponseEntity atualizarEmail(@PathVariable String idUser, @RequestBody CadastrarDTO usuario) {
		try {
			
		Optional<UsersEntities> optionalUser = repository.findById(idUser); // o optional sempre
																								// verifica se existe
		// ou n
		if (optionalUser.isEmpty()) {
			return ResponseEntity.badRequest().body(Map.of("error", "não foi possívela achar o aluno no banco de dados"));
		}

		UsersEntities user = optionalUser.get();

		if (usuario.email() != null && !usuario.email().isBlank()) {
			user.setEmail(usuario.email());
		}

		if (usuario.telefone() != null && !usuario.telefone().isBlank()) {
			user.setTelefone(usuario.telefone());
		}

		if (usuario.nome() != null && !usuario.nome().isBlank()) {
			user.setNome(usuario.nome());
		}

		repository.save(user);

		return ResponseEntity.ok().body(Map.of("sucesso", "Aluno seus dados foram atualizados"));
		} catch (Exception e) {
			return ResponseEntity.badRequest().body(Map.of("error", "Erro inesperado"));
		}
	}

}
