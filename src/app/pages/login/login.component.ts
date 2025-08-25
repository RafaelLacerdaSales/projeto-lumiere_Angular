import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';

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

  constructor(private http: HttpClient) {}
  onLogin() {
    if (this.loginData.email && this.loginData.senha) {
      console.log('Login enviado:', this.loginData);

      const loginJson = JSON.stringify(this.loginData);

      // duvida se é post ou get
      this.http.post('http://localhost:8080/login', loginJson).subscribe({
        next: (res) => {
          console.log('Login enviado com sucesso!', res);
        },
        error: (err) => {
          console.error('Erro ao enviar login:', err);
        },
        complete: () => {
          console.log('Requisição finalizada.');
        },
      });
    } else {
      console.warn('Email e senha são obrigatórios!');
    }
  }

  onCadastro() {
    const { nome, cpf, data_nascimento, telefone, email, senha } =
      this.cadastroData;
    if (nome && cpf && data_nascimento && telefone && email && senha) {
      console.log('Cadastro enviado:', this.cadastroData);

      const cadastroJson = JSON.stringify(this.cadastroData);
      this.http.post('http://localhost:8080/cadastro', cadastroJson).subscribe({
        next: (res) => {
          console.log('Cadastro enviado com sucesso!', res);
        },
        error: (err) => {
          console.error('Erro ao enviar cadastro:', err);
        },
        complete: () => {
          console.log('Requisição finalizada.');
        },
      });
    } else {
      console.warn('Todos os campos são obrigatórios!');
    }
  }

  onRecuperar() {
    if (this.recuperarData.email_recuperar) {
      console.log('Recuperar senha:', this.recuperarData);
      const recuperarJson = JSON.stringify(this.recuperarData);
      this.http
        .post('http://localhost:8080/recuperar', recuperarJson)
        .subscribe({
          next: (res) => {
            console.log('Pedido de recuperação enviado com sucesso!', res);
          },
          error: (err) => {
            console.error('Erro ao enviar pedido de recuperação:', err);
          },
          complete: () => {
            console.log('Requisição finalizada.');
          },
        });
    } else {
      console.warn('Email é obrigatório!');
    }
  }
}
