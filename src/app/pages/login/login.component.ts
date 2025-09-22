import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { LumiereService } from 'src/app/Service/lumiere.service';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent {
  sectionAtual: 'login' | 'cadastro' | 'recuperar' = 'login';

  constructor(
    private lumiereService: LumiereService,
    private fb: FormBuilder,
    private router: Router
  ) { }
  chaveInicial: boolean = false;
  nome: String = '';
  cpf: number = 0;
  data_nascimento: String = '';
  telefone: String = '';
  email: String = '';
  senha: String = '';
  role: String = 'USER';

  submitUser() {
    const user = {
      nome: this.nome,
      cpf: this.cpf,
      data_nascimento: this.data_nascimento,
      telefone: this.telefone,
      email: this.email,
      senha: this.senha,
      role: this.role
    }

    this.lumiereService.cadastrarUser(user).subscribe({
      next: (response) => {
        if (response.sucesso) {
          alert(response.sucesso);
        }
      },
      error: (err) => {
        if (err.error) {
          alert(err.error.error);
        }
      },
    });
  }

  recuperarData = { email_recuperar: '' };

  mudarSection(section: 'login' | 'cadastro' | 'recuperar') {
    this.sectionAtual = section;
  }

  onLogin() {
    const user = {
      loginValidar: this.chaveInicial,
      email: this.email,
      senha: this.senha,
    };

    this.lumiereService.validarUser(user).subscribe({
      next: (response) => {
        if (response.response) {
          const sessao = {
            token: response.token,      //recebo do back o token e o response, crio um date para verificar na validacao o tempo para poder limpar o localstorage
            usuario: response.response, 
            savedAt: Date.now()        
          };
          localStorage.setItem('sessao', JSON.stringify(sessao));
          console.log(response.response)

          window.dispatchEvent(new Event('storage'));
          this.router.navigate(['/workshop']);
        }
      },
      error: (error) => {
        if (error.error) {
          alert(error.error.error);
        }
      },
    });
  }

  onRecuperar() {
    if (this.recuperarData.email_recuperar) {
      console.log('estou aqui');
    }
  }
}
