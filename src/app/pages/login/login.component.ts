import { Component } from '@angular/core';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent {
  sectionAtual: 'login' | 'cadastro' | 'recuperar' = 'login';

  loginData = { email: '', senha: '' };
  cadastroData = {
    nome: '',
    cpf: '',
    data_nascimento: '',
    telefone: '',
    email: '',
    senha: '',
  };
  recuperarData = { email_recuperar: '' };

  mudarSection(section: 'login' | 'cadastro' | 'recuperar') {
    this.sectionAtual = section;
  }

  onLogin() {
    if (this.loginData.email && this.loginData.senha) {
      console.log('Login enviado:', this.loginData);
    }
  }

  onCadastro() {
    const { nome, cpf, data_nascimento, telefone, email, senha } =
      this.cadastroData;
    if (nome && cpf && data_nascimento && telefone && email && senha) {
      console.log('Cadastro enviado:', this.cadastroData);
    }
  }

  onRecuperar() {
    if (this.recuperarData.email_recuperar) {
      console.log('Recuperar senha:', this.recuperarData);
    }
  }
}
