package com.lumiere.prject.DTO;

import java.time.LocalDate;

import com.lumiere.project.enums.EnumsLumiere;


public record CadastrarDTO(String nome, String cpf, String telefone, String senha, String email, EnumsLumiere role, LocalDate data_nascimento){
}
