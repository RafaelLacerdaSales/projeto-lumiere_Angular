package com.lumiere.project.repositories;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import com.lumiere.project.entities.UsersEntities;
public interface UsersRepositories extends JpaRepository<UsersEntities, Long>{
   Optional<UsersEntities> findByEmail(String email);
   List<UsersEntities> findByNome(String nome);
   List<UsersEntities> findBySenha(String senha);
   List<UsersEntities> findByCpf(String cpf);
   List<UsersEntities> findByTelefone(String telefone);
}