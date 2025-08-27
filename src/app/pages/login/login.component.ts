import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { LumiereService } from 'src/app/LoginService/lumiere.service';
import { FormBuilder } from '@angular/forms';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent {
  sectionAtual: 'login' | 'cadastro' | 'recuperar' = 'login';

  constructor (private lumiereService: LumiereService, private fb: FormBuilder) {}

    nome: String = '';
    cpf: number = 0;
    data_nascimento: String = '';
    telefone: String = '';
    email: String = '';
    senha: String = '';

    submitUser(){

    const user = {
      nome: this.nome,
      cpf: this.cpf,
      data_nascimento: this.data_nascimento,
      telefone: this.telefone,
      email: this.email,
      senha: this.senha
    }

    this.lumiereService.cadastrarUser(user).subscribe({
      next: (response) => {
        if(response.sucesso){
          alert(response.sucesso)
        }
      },
      error: (err) => {
        if(err.error){
            alert(err.error.error )
        }
      }
    })
  }
  

  recuperarData = { email_recuperar: '' };

  mudarSection(section: 'login' | 'cadastro' | 'recuperar') {
    this.sectionAtual = section;
  }
  
  onLogin() {
   const user = {
      email: this.email,
      senha: this.senha
    }

    this.lumiereService.validarUser(user).subscribe({
      next: (response) => {
        console.log("foi")
         if(response.aceito){
         alert(response.aceito)
        }
      },
      error: (error) => {
         console.log("não foi")
        if(error.error){
          alert(error.error.error)
        }
      }
    })
  }

  onRecuperar() {
    if (this.recuperarData.email_recuperar) {
      console.log("estou aqui")
  }
  }}
