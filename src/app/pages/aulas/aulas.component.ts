import { Component } from '@angular/core';

@Component({
  selector: 'app-aulas',
  templateUrl: './aulas.component.html',
  styleUrls: ['./aulas.component.css'],
})
export class AulasComponent {
  constructor() {
    document.addEventListener('DOMContentLoaded', () => {
      const modulosHeaders =
        document.querySelectorAll<HTMLElement>('.modulo-header');

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
}
