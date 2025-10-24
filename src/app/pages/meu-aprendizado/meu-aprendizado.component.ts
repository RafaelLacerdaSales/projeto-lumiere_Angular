import { Component, OnInit } from '@angular/core';

interface Curso {
  nome: string;
  imagem: string;
}

@Component({
  selector: 'app-meu-aprendizado',
  templateUrl: './meu-aprendizado.component.html',
  styleUrls: ['./meu-aprendizado.component.css'],
})
export class MeuAprendizadoComponent implements OnInit {
  cursos: Curso[] = [];

  ngOnInit() {

    const cursoSalvo = localStorage.getItem('cursoRecente');

    if (cursoSalvo) {
      const cursoBruto = JSON.parse(cursoSalvo);


      const cursoFormatado: Curso = {
        nome: cursoBruto.tituloDoCurso || cursoBruto.nome,
        imagem: cursoBruto.caminhoDaCapa
          ? 'http://localhost:8080' + cursoBruto.caminhoDaCapa
          : cursoBruto.imagem,
      };

      this.cursos = [cursoFormatado];


      localStorage.removeItem('cursoRecente');
    }
    
  }
}
