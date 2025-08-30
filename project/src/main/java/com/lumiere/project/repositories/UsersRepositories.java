package com.lumiere.project.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.security.core.userdetails.UserDetails;

import com.lumiere.project.entities.UsersEntities;

public interface UsersRepositories extends JpaRepository<UsersEntities, String> {

	UserDetails findByEmail(String email);
	UserDetails findByCpf(String cpf);
	UserDetails findByTelefone(String telefone);
	
}