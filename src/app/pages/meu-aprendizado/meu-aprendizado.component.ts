import { Component } from '@angular/core';

interface Curso {
  nome: string;
  imagem: string;
}

@Component({
  selector: 'app-meu-aprendizado',
  templateUrl: './meu-aprendizado.component.html',
  styleUrls: ['./meu-aprendizado.component.css'],
})
export class MeuAprendizadoComponent {
  // Dados mocados para os cursos. Idealmente, viriam de um serviço.
  cursos: Curso[] = [
    { nome: 'Maquiagem Profissional', imagem: '/assets/img_Maquiagem.png' },
    { nome: 'Maquiagem para Festas', imagem: '/assets/img_Maquiagem.png' },
    { nome: 'Maquiagem Artística', imagem: '/assets/img_Maquiagem.png' },
    { nome: 'Automaquiagem', imagem: '/assets/img_Maquiagem.png' },
    { nome: 'Técnicas Avançadas', imagem: '/assets/img_Maquiagem.png' },
    { nome: 'Maquiagem para Noivas', imagem: '/assets/img_Maquiagem.png' },
  ];
}
