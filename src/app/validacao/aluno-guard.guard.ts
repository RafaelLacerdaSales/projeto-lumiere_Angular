import { CanActivateFn } from '@angular/router';

export const alunoGuard: CanActivateFn = (route, state) => {
  return true;
};
