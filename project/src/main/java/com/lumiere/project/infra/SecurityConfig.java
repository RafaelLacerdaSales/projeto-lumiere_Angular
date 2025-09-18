package com.lumiere.project.infra;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	SecurityFilter securityFilter;

	@Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
        return httpSecurity
                .cors(cors -> cors.configurationSource(request -> {
                    CorsConfiguration configuration = new CorsConfiguration();
                    configuration.setAllowedOrigins(List.of("http://localhost:4200"));
                    configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
                    configuration.setAllowedHeaders(List.of("*"));
                    return configuration;
                }))
                .csrf(csrf -> csrf.disable())
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers(HttpMethod.POST, "/usuario/cadastrar").permitAll()
                        .requestMatchers(HttpMethod.GET, "/usuario/buscarTodos").permitAll()
                        .requestMatchers(HttpMethod.POST, "/usuario/validar").permitAll()  
                        .requestMatchers(HttpMethod.PUT, "/usuario/atualizarEmail/{idUser}").permitAll()   
                        .requestMatchers(HttpMethod.POST, "/workshop/cadastrar").permitAll()
                        .requestMatchers(HttpMethod.PUT, "/workshop/atualizar/{id}").permitAll()
                        .requestMatchers(HttpMethod.GET, "/workshop/buscar").permitAll()
                        .requestMatchers(HttpMethod.DELETE, "/workshop/{id}").permitAll()
                        .requestMatchers(HttpMethod.POST, "/funcionario/cadastrar").permitAll()
                        .requestMatchers(HttpMethod.POST, "/funcionario/validar").permitAll()
                        .requestMatchers(HttpMethod.POST, "/aulas/adicionarAula/{id}").permitAll()
                        .requestMatchers(HttpMethod.GET, "/aulas/buscar").permitAll()
                        .requestMatchers(HttpMethod.DELETE, "/aulas/deletarAula/{id}").permitAll()
                        .requestMatchers(HttpMethod.PUT, "/aulas/atualizar/{id}").permitAll()

                        .anyRequest().authenticated()
                )
                .addFilterBefore(securityFilter, UsernamePasswordAuthenticationFilter.class)
                .build();
    }
	@Bean
	public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration)
			throws Exception {
		return authenticationConfiguration.getAuthenticationManager();
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

}
