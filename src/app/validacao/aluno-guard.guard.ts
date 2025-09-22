import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';

export const alunoGuard: CanActivateFn = (route, state) => {
  const sessaoString = localStorage.getItem('sessao');

  if (!sessaoString) {
    const router = inject(Router);
    router.navigate(['/login']);
    return false;
  }
  const sessao = JSON.parse(sessaoString);

  const tempoDeExpiracao = 60 * 60 * 1000; // 60 minutos em milissegundos

  const tempoPassado = Date.now() - sessao.savedAt;

  if (tempoPassado > tempoDeExpiracao) {
    //faço uma verificação para ve se o usuario n excedeu o tempo de login
    console.log("Sessão expirada. Redirecionando para o login...");
    localStorage.removeItem('sessao'); 
    const router = inject(Router);
    router.navigate(['/login']);
    return false;
  }
  return true;
};
