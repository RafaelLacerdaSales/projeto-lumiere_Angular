import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';

export const alunoGuard: CanActivateFn = (route, state) => {
  
  if(sessionStorage.getItem('dadosUsuario')){
    console.log("testou")
    return true;
  }

  const router = inject(Router);
  router.navigate(['/login']);
  return false;
};
