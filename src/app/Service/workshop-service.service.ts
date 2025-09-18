import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { cursosInterface } from '../interfaces/cursos-interface';

@Injectable({
  providedIn: 'root'
})
export class WorkshopServiceService {

   constructor(private httpClient: HttpClient) { }

    private readonly baseUrl = `http://localhost:8080`;

    private readonly httpOptions = {
      headers: new HttpHeaders({
        'content-Type': 'application/json'
      }) //usado quando quer receber um json para usá-lo
    };

    cadastrarCurso(cursos: any ): Observable<any> {
      return this.httpClient.post(`${this.baseUrl}/workshop/cadastrar`, cursos, this.httpOptions)
    }

    buscarCursos(): Observable<cursosInterface[]> {
      return this.httpClient.get<cursosInterface[]>(`${this.baseUrl}/workshop/buscar`, this.httpOptions)
    }

      atualizarCurso(cursosDados: any): Observable<any> {
    //nota, o repsonseType text é para quando quer receber uma STRING
    return this.httpClient.put(`${this.baseUrl}/workshop/atualizar`, cursosDados, this.httpOptions)
   }
  


}
