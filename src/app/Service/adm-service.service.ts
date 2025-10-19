import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AdmServiceService {

  constructor(private httpClient: HttpClient) { }

  private readonly baseUrl = `http://localhost:8080`;

  private readonly httpOptions = {
    headers: new HttpHeaders({
      'content-Type': 'application/json'
    })
  };

  // ========== MÉTODOS PARA FUNCIONÁRIOS ==========

  // CADASTRAR FUNCIONÁRIO
  cadastrarFuncionario(funcionario: any): Observable<any> {
    return this.httpClient.post(`${this.baseUrl}/funcionario/cadastrar`, funcionario, this.httpOptions)
  }

  // BUSCAR TODOS OS FUNCIONÁRIOS
  buscarFuncionarios(): Observable<any> {
    return this.httpClient.get(`${this.baseUrl}/funcionarios`, this.httpOptions);
  }

  // BUSCAR FUNCIONÁRIO POR ID (útil para edição)
  buscarFuncionarioPorId(id: number): Observable<any> {
    return this.httpClient.get(`${this.baseUrl}/funcionario/${id}`, this.httpOptions);
  }

  // ATUALIZAR FUNCIONÁRIO
  atualizarFuncionario(id: number, funcionario: any): Observable<any> {
    return this.httpClient.put(`${this.baseUrl}/funcionario/atualizar/${id}`, funcionario, this.httpOptions);
  }

  // EXCLUIR FUNCIONÁRIO
  excluirFuncionario(id: number): Observable<any> {
    return this.httpClient.delete(`${this.baseUrl}/funcionario/excluir/${id}`, this.httpOptions);
  }

  // ========== MÉTODOS PARA ADMINISTRADORES ==========

  // CADASTRAR ADMINISTRADOR
  cadastrarAdministrador(administrador: any): Observable<any> {
    return this.httpClient.post(`${this.baseUrl}/administrador/cadastrar`, administrador, this.httpOptions)
  }

  // BUSCAR TODOS OS ADMINISTRADORES
  buscarAdministradores(): Observable<any> {
    return this.httpClient.get(`${this.baseUrl}/administradores`, this.httpOptions);
  }

  // BUSCAR ADMINISTRADOR POR ID (útil para edição)
  buscarAdministradorPorId(id: number): Observable<any> {
    return this.httpClient.get(`${this.baseUrl}/administrador/${id}`, this.httpOptions);
  }

  // ATUALIZAR ADMINISTRADOR
  atualizarAdministrador(id: number, administrador: any): Observable<any> {
    return this.httpClient.put(`${this.baseUrl}/administrador/atualizar/${id}`, administrador, this.httpOptions);
  }

  // EXCLUIR ADMINISTRADOR
  excluirAdministrador(id: number): Observable<any> {
    return this.httpClient.delete(`${this.baseUrl}/administrador/excluir/${id}`, this.httpOptions);
  }

  // ========== MÉTODO ALTERNATIVO PARA BUSCAR TODOS OS USUÁRIOS (OPCIONAL) ==========
  
  // Caso seu backend tenha um endpoint que retorne todos os usuários (funcionários e administradores)
  buscarTodosUsuarios(): Observable<any> {
    return this.httpClient.get(`${this.baseUrl}/usuarios`, this.httpOptions);
  }
}