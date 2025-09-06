

public class Snippet {
	@CrossOrigin(origins = "http://localhost:4200")
	@PostMapping("/validar")
	public ResponseEntity login(@RequestBody @Valid LoginDTO data) {
	    try {
	        // 1. Cria o token de autenticação com email e senha.
	        var usernamePassword = new UsernamePasswordAuthenticationToken(data.email(), data.senha());
	
	        // 2. O Spring Security faz a MÁGICA aqui.
	        //    Ele vai automaticamente:
	        //    - Buscar o usuário no banco pelo email.
	        //    - Comparar a senha enviada (data.senha()) com a senha HASHED no banco.
	        //    - Se o login ou senha estiverem errados, ele LANÇA UMA EXCEÇÃO e o código pula para o 'catch'.
	        var auth = this.authenticationManager.authenticate(usernamePassword);
	
	        // 3. Se a linha acima NÃO deu exceção, o login foi um SUCESSO.
	        //    Agora, geramos o token JWT para o usuário autenticado.
	        var token = tokenService.geradorToken((UsersEntities) auth.getPrincipal());
	
	        // 4. Retornamos o status 200 OK com o token no corpo da resposta.
	        return ResponseEntity.ok(new LoginResponseDTO(token));
	
	    } catch (AuthenticationException e) {
	        // 5. Se o authenticate() falhou, o código cai AQUI.
	        //    Retornamos um erro 401 Unauthorized, que é o correto para falha de login.
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
	                             .body(Map.of("error", "Login ou senha inválidos."));
	    }
	}
	
	// Assumindo que você tenha um DTO para a resposta do login. Se não, pode criá-lo:
	public record LoginResponseDTO(String token) {}
}