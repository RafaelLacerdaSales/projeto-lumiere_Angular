package com.lumiere.project.infra; // Importante: Mantenha este package ou o seu package correto

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.file.Path;
import java.nio.file.Paths;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        
        // 1. Define o caminho ABSOLUTO da pasta 'uploads' na raiz do projeto.
        // O Spring precisa do caminho físico completo para encontrar o arquivo.
        Path uploadDir = Paths.get("./uploads").toAbsolutePath().normalize();
        String uploadPath = uploadDir.toFile().getAbsolutePath();

        // 2. Mapeia a URL pública para o caminho físico
        // Quando o navegador requisitar 'http://localhost:8080/images/nome.jpg'
        // O Spring irá buscar em 'file:/Caminho/Completo/do/Seu/Projeto/uploads/'
        registry.addResourceHandler("/images/**")
                .addResourceLocations("file:" + uploadPath + "/");
                
        // Mantenha o mapeamento padrão para os recursos internos do projeto (static)
        registry.addResourceHandler("/**")
                .addResourceLocations("classpath:/static/");
    }
}