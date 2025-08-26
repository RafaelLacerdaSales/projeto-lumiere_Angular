package com.lumiere.project.entities;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotBlank;

@Entity
public class FuncionarioEntities {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long IdFuncionario;
    @NotBlank(message = "Nome é obrigatório")
    @Column(nullable = false, unique = true)
    private String nomeDoFuncionario;
    @NotBlank(message = "sobreNomeDoFuncionario é obrigatório")
    @Column(nullable = false, unique = true)
    private String sobreNomeDoFuncionario;
    @Column(nullable = false, unique = true)
    @NotBlank(message = "Email é obrigatório")
    private String email;
    @Column(nullable = false)
    @NotBlank(message = "Data de nascimento é obrigatório")
    private String dataDeNascimento;
    @NotBlank(message = "CPF é obrigatório")
    @Column(nullable = false, unique = true)
    private String cpf;
    @NotBlank(message = "rg é obrigatório")
    @Column(nullable = false, unique = true)
    private String rg;
    @NotBlank(message = "caminho do arquivo é obrigatório")
    @Column(nullable = false, unique = true)
    private String caminhoDoArquivo;
    
    public FuncionarioEntities() {}

	public FuncionarioEntities(Long idFuncionario, String nomeDoFuncionario, String sobreNomeDoFuncionario,
			String email,  String dataDeNascimento, String cpf, String rg, String caminhoDoArquivo) {
		super();
		IdFuncionario = idFuncionario;
		this.nomeDoFuncionario = nomeDoFuncionario;
		this.sobreNomeDoFuncionario = sobreNomeDoFuncionario;
		this.email = email;
		this.dataDeNascimento = dataDeNascimento;
		this.cpf = cpf;
		this.rg = rg;
		this.caminhoDoArquivo = caminhoDoArquivo;
	}

	public Long getIdFuncionario() {
		return IdFuncionario;
	}

	public void setIdFuncionario(Long idFuncionario) {
		IdFuncionario = idFuncionario;
	}

	public String getNomeDoFuncionario() {
		return nomeDoFuncionario;
	}

	public void setNomeDoFuncionario(String nomeDoFuncionario) {
		this.nomeDoFuncionario = nomeDoFuncionario;
	}

	public String getSobreNomeDoFuncionario() {
		return sobreNomeDoFuncionario;
	}

	public void setSobreNomeDoFuncionario(String sobreNomeDoFuncionario) {
		this.sobreNomeDoFuncionario = sobreNomeDoFuncionario;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public  String getDataDeNascimento() {
		return dataDeNascimento;
	}

	public void setDataDeNascimento( String dataDeNascimento) {
		this.dataDeNascimento = dataDeNascimento;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public String getRg() {
		return rg;
	}

	public void setRg(String rg) {
		this.rg = rg;
	}

	public String getCaminhoDoArquivo() {
		return caminhoDoArquivo;
	}

	public void setCaminhoDoArquivo(String caminhoDoArquivo) {
		this.caminhoDoArquivo = caminhoDoArquivo;
	}
    
    
    

}
