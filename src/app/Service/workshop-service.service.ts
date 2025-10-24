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

// httpOptions não é mais necessário para cadastrar/atualizar,
 // mas mantido caso precise para outros métodos.
 private readonly httpOptions = {
 headers: new HttpHeaders({
 'content-Type': 'application/json'
 })
 };

 // MÉTODO ATUALIZADO para usar FormData
 cadastrarCurso(cursosDados: any, capaFile: File): Observable<any> {
const formData = new FormData();

// 'file' e 'cursoData' DEVE bater com o Controller Spring Boot
 formData.append('file', capaFile, capaFile.name);
 formData.append('cursoData', JSON.stringify(cursosDados));

 return this.httpClient.post(`${this.baseUrl}/workshop/cadastrar`, formData)
 }

 buscarCursos(): Observable<cursosInterface[]> {
 // Mantido como estava
return this.httpClient.get<cursosInterface[]>(`${this.baseUrl}/workshop/buscar`, this.httpOptions)
 }

 // MÉTODO ATUALIZADO para usar FormData e receber File opcional
 atualizarCurso(id: number, cursosDados: any, capaFile: File | null): Observable<any> {
 const formData = new FormData();

// 'cursoData' DEVE bater com o Controller Spring Boot
 formData.append('cursoData', JSON.stringify(cursosDados));

if (capaFile) {
// 'file' DEVE bater com o Controller Spring Boot
 formData.append('file', capaFile, capaFile.name);
}

return this.httpClient.put(`${this.baseUrl}/workshop/atualizar/${id}`, formData)
}

deletarCurso(id: number): Observable<any> {
// Endpoint do controller ajustado para 'delete/{id}'
return this.httpClient.delete(`${this.baseUrl}/workshop/delete/${id}`, this.httpOptions)
}
}
