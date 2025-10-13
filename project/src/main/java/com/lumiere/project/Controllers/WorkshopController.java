package com.lumiere.project.Controllers;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID; // Adicionado para gerar nomes de arquivo únicos

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody; // Mantido, mas não usado nos métodos de upload
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam; // Adicionado para MultipartFile
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile; // Adicionado para MultipartFile

import com.fasterxml.jackson.databind.ObjectMapper; // Adicionado para desserializar o JSON String
import com.lumiere.project.dto.CursoDTO;
import com.lumiere.project.entities.WorkshopEntities;
import com.lumiere.project.repositories.WorkShopRepositories;

@RestController
@RequestMapping("/workshop")
public class WorkshopController {

	// A pasta onde o arquivo será SALVO
    private final String UPLOAD_DIR = "uploads/";
    
    // A URL base que o Angular usará para ACESSAR o arquivo
    private final String STATIC_URL = "/images/"; 

	@Autowired
	WorkShopRepositories repository;

    // --- MÉTODOS AUXILIARES PARA MANIPULAÇÃO DE ARQUIVOS (ATUALIZADO)---
    private String salvarArquivoNoDisco(MultipartFile file) throws IOException {
        // Cria um nome de arquivo único para evitar colisões
        String originalFilename = file.getOriginalFilename();
        String extension = "";
        if (originalFilename != null && originalFilename.lastIndexOf(".") != -1) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String fileName = UUID.randomUUID().toString() + extension;
        
        // Define o caminho ABSOLUTO para salvar o arquivo no disco
        Path uploadPath = Paths.get(UPLOAD_DIR).toAbsolutePath().normalize();
        
        // Cria o diretório se ele não existir
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // Resolve o caminho completo para salvar o arquivo
        Path targetLocation = uploadPath.resolve(fileName);
        
        // Copia o arquivo para o local de destino
        Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);
        
        // Retorna o caminho *URL* que será salvo no banco de dados e usado pelo Angular
        // Ex: /images/nome-do-arquivo.png
        return STATIC_URL + fileName; 
    }
    // --- FIM DOS MÉTODOS AUXILIARES ---
    
    // ... restante dos métodos cadastrarCurso, listUsers, deletarUsuario, atualizarCapa ...
    // ... O restante do WorkshopController fica IGUAL ao que te passei antes.
    
    // NOTA: O RESTO DOS MÉTODOS ABAIXO É O MESMO CÓDIGO DA RESPOSTA ANTERIOR
    // APENAS MANTENHA-OS PARA COMPLETAR A CLASSE.
	@CrossOrigin(origins = "http://localhost:4200")
	@PostMapping("/cadastrar")
	public ResponseEntity<?> cadastrarCurso(
            @RequestParam("file") MultipartFile file,
            @RequestParam("cursoData") String cursoDataJson) {
		try {
            ObjectMapper objectMapper = new ObjectMapper();
            CursoDTO cursoDTO = objectMapper.readValue(cursoDataJson, CursoDTO.class);

            String caminhoRelativo = salvarArquivoNoDisco(file);
            
			WorkshopEntities wk = new WorkshopEntities(cursoDTO.tituloDoCurso(), cursoDTO.descricao(), 
                cursoDTO.preco(), caminhoRelativo);
                
			repository.save(wk);
			return ResponseEntity.ok().body(Map.of("sucesso", "Curso cadastrado e imagem salva."));
            
		} catch (IOException e) {
            System.out.println("Erro ao salvar arquivo: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Map.of("error", "Erro ao processar o upload do arquivo."));
		} catch (Exception e) {
            System.out.println("Erro ao cadastrar curso: " + e.getMessage());
			return ResponseEntity.badRequest().body(Map.of("error", "Não foi possível cadastrar o curso"));
		}
	}

	@GetMapping("/buscar")
	public List<CursoDTO> listUsers() {
		return repository.findAll().stream().map(u -> new CursoDTO(u.getId(), u.getTituloDoCurso(), u.getDescricao(),
				u.getPreco(), u.getCaminhoDaCapa())).toList();
	}

	@CrossOrigin(origins = "http://localhost:4200")
	@DeleteMapping("/delete/{id}")
	public ResponseEntity<?> deletarUsuario(@PathVariable Long id) {
		try {
			repository.deleteById(id);
			return ResponseEntity.ok().body(Map.of("sucesso", "Curso deletado"));
		} catch (Exception e) {
			return ResponseEntity.badRequest().body(Map.of("error", "Não foi possível achar o curso"));
		}
	}

	@CrossOrigin(origins = "http://localhost:4200")
	@PutMapping("/atualizar/{id}")
	@Transactional
	public ResponseEntity<?> atualizarCapa(
            @PathVariable Long id, 
            @RequestParam("cursoData") String cursoDataJson,
            @RequestParam(value = "file", required = false) MultipartFile file) {
		
		Optional<WorkshopEntities> optionalWorkshop = repository.findById(id); 

		if (optionalWorkshop.isEmpty()) {
			System.out.println("!! ERRO: CURSO COM ID " + id + " NÃO ENCONTRADO !!");
			return ResponseEntity.badRequest().body(Map.of("error", "não foi possívela achar o curso"));
		}

		WorkshopEntities workshop = optionalWorkshop.get();

		try {
            ObjectMapper objectMapper = new ObjectMapper();
            CursoDTO curso = objectMapper.readValue(cursoDataJson, CursoDTO.class);
            
            if (file != null && !file.isEmpty()) {
                String novoCaminho = salvarArquivoNoDisco(file);
                workshop.setCaminhoDaCapa(novoCaminho);
            }

            if (curso.tituloDoCurso() != null && !curso.tituloDoCurso().isBlank()) {
                workshop.setTituloDoCurso(curso.tituloDoCurso());
            }

            if (curso.preco() != null && !curso.preco().isBlank()) {
                workshop.setPreco(curso.preco());
            }

            if (curso.descricao() != null && !curso.descricao().isBlank()) {
                workshop.setDescricao(curso.descricao());
            }

            repository.save(workshop);

            return ResponseEntity.ok().body(Map.of("sucesso", "Curso atualizado"));
        } catch (Exception e) {
            System.out.println("Erro ao atualizar curso: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Map.of("error", "Erro ao atualizar curso ou processar arquivo."));
        }
	}
}