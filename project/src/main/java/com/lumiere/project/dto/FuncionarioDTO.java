package com.lumiere.project.dto;

import java.time.LocalDate;

import com.lumiere.project.enums.EnumsLumiere;

public record FuncionarioDTO (String nome, String cpf, String telefone, String senha, String email, EnumsLumiere role, LocalDate data_nascimento, String rg, String caminhoDoArquivo){}
