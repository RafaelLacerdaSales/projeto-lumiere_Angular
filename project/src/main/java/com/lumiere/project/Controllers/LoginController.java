package com.lumiere.project.Controllers;

import java.util.Map;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lumiere.project.entities.LoginEntities;
import com.lumiere.project.entities.UsersEntities;
import com.lumiere.project.repositories.UsersRepositories;

@RestController
@RequestMapping("/login")
public class LoginController {

    private UsersRepositories repository;

    public LoginController(UsersRepositories repository) {
        this.repository = repository;
    }

    @CrossOrigin(origins = "http://localhost:4200")
    @PostMapping("/validar")
    public ResponseEntity<Map<String, String>> validarLogin(@RequestBody LoginEntities user) {

        UsersEntities use = repository.findByEmail(user.getEmail()).orElse(null);

        if (use != null && user.getSenha().equals(use.getSenha())) {
            return ResponseEntity.status(HttpStatus.ACCEPTED)
                    .body(Map.of("aceito", "Login aceito"));
        }

        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(Map.of("error", "Login ou senha inválidos."));
    }
}
