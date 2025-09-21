package com.lumiere.project.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.validation.constraints.NotBlank;

@Entity
public class VideosWorkshopEntities {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotBlank
	@Column(nullable = false)
	private String titulo;

	@NotBlank
	@Column(nullable = false)
	private String urlDaAula;
	

	@NotBlank
	@Column(nullable = false)
	private String descricao;

	@ManyToOne
	@JoinColumn(name = "curso_id")
	private WorkshopEntities curso;

	public VideosWorkshopEntities() {
	}

	public VideosWorkshopEntities(Long id, @NotBlank String titulo, @NotBlank String urlDaAula,
			WorkshopEntities curso) {
		super();
		this.id = id;
		this.titulo = titulo;
		this.urlDaAula = urlDaAula;
		this.curso = curso;
	}
	
	public VideosWorkshopEntities(@NotBlank String titulo, @NotBlank String urlDaAula, @NotBlank String descricao, 	WorkshopEntities curso) {
		this.titulo = titulo;
		this.urlDaAula = urlDaAula;
		this.descricao = descricao;
		this.curso = curso;
	}
	
	

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getUrlDaAula() {
		return urlDaAula;
	}

	public void setUrlDaAula(String urlDaAula) {
		this.urlDaAula = urlDaAula;
	}

	public WorkshopEntities getCurso() {
		return curso;
	}

	public void setCurso(WorkshopEntities curso) {
		this.curso = curso;
	}

}
