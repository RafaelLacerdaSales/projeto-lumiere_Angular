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

  // CADASTRAR FUNCIONÁRIO (já existe)
  cadastrarFuncionario(funcionario: any): Observable<any> {
    return this.httpClient.post(`${this.baseUrl}/funcionario/cadastrar`, funcionario, this.httpOptions)
  }

  // BUSCAR TODOS OS FUNCIONÁRIOS (NOVO)
  buscarFuncionarios(): Observable<any> {
    return this.httpClient.get(`${this.baseUrl}/funcionarios`, this.httpOptions);
  }

  // BUSCAR FUNCIONÁRIO POR ID (NOVO - útil para edição)
  buscarFuncionarioPorId(id: number): Observable<any> {
    return this.httpClient.get(`${this.baseUrl}/funcionario/${id}`, this.httpOptions);
  }

  // ATUALIZAR FUNCIONÁRIO (NOVO)
  atualizarFuncionario(id: number, funcionario: any): Observable<any> {
    return this.httpClient.put(`${this.baseUrl}/funcionario/atualizar/${id}`, funcionario, this.httpOptions);
  }

  // EXCLUIR FUNCIONÁRIO (NOVO)
  excluirFuncionario(id: number): Observable<any> {
    return this.httpClient.delete(`${this.baseUrl}/funcionario/excluir/${id}`, this.httpOptions);
  }
}