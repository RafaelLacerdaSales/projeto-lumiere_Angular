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
    }) //usado quando quer receber um json para usá-lo
  };

  cadastrarFuncionario(funcionario: any): Observable<any> {
    //nota, o repsonseType text é para quando quer receber uma STRING
    return this.httpClient.post(`${this.baseUrl}/funcionario/cadastrar`, funcionario, this.httpOptions)
  }



}
