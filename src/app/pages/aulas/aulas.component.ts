import { Component } from '@angular/core';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';

@Component({
  selector: 'app-aulas',
  templateUrl: './aulas.component.html',
  styleUrls: ['./aulas.component.css'],
})
export class AulasComponent {
  selectedLesson: number = 1;
  currentVideo!: SafeResourceUrl;

  lessons = [
    {
      id: 1,
      title: 'Boas-vindas',
      description: 'Bem-vindo ao curso! Nesta primeira aula, você conhecerá os objetivos do curso e como aproveitar melhor as aulas.',
      video: 'https://www.youtube.com/embed/tgbNymZ7vqY'
    },
    {
      id: 2,
      title: 'Apresentação do Curso',
      description: 'Nesta aula vamos apresentar o curso e mostrar como ele será estruturado.',
      video: 'https://www.youtube.com/embed/dQw4w9WgXcQ'
    },
    {
      id: 3,
      title: 'Como usar a plataforma',
      description: 'Aprenda como navegar e aproveitar os recursos da plataforma.',
      video: 'https://www.youtube.com/embed/kJQP7kiw5Fk'
    },
    {
      id: 4,
      title: 'Configuração do Ambiente',
      description: 'Veja como configurar corretamente o seu ambiente de estudo.',
      video: 'https://www.youtube.com/embed/aqz-KE-bpKQ'
    },
    {
      id: 5,
      title: 'Primeiros Passos',
      description: 'Chegou a hora de colocar a mão na massa e dar os primeiros passos!',
      video: 'https://www.youtube.com/embed/ScMzIvxBSi4'
    }
  ];

  constructor(private sanitizer: DomSanitizer) {
    this.selectLesson(1); // inicializa o primeiro vídeo

    // Mantém lógica de módulos expansíveis
    document.addEventListener('DOMContentLoaded', () => {
      const modulosHeaders = document.querySelectorAll<HTMLElement>('.modulo-header');
      modulosHeaders.forEach((header) => {
        header.addEventListener('click', () => {
          const lista = header.nextElementSibling as HTMLElement | null;
          if (!lista) return;

          lista.classList.toggle('d-none');
          header.classList.toggle('collapsed');

          const arrow = header.querySelector('.arrow');
          if (arrow) {
            arrow.textContent = lista.classList.contains('d-none') ? '▶' : '▼';
          }
        });
      });
    });
  }

  get currentLesson() {
    return this.lessons.find(l => l.id === this.selectedLesson);
  }

  selectLesson(id: number) {
    this.selectedLesson = id;
    const lesson = this.lessons.find(l => l.id === id);
    if (lesson) {
      this.currentVideo = this.sanitizer.bypassSecurityTrustResourceUrl(lesson.video);
    }
  }
}
