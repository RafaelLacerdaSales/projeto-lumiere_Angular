package com.lumiere.project.dto;

import java.time.LocalDate;

import com.lumiere.project.enums.EnumsLumiere;

public record AtualizarCursoDTO(String tituloDoCurso, String descricao, String preco, String caminhoDaCapa){}
