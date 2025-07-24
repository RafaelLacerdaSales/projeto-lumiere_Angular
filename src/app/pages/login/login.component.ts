import { Component } from '@angular/core';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent {
  sectionAtual: 'login' | 'cadastro' | 'recuperar' = 'login';

  mudarSection(section: 'login' | 'cadastro' | 'recuperar') {
    this.sectionAtual = section;
  }
}
