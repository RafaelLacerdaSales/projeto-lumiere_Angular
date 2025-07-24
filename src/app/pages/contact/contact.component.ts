import { Component } from '@angular/core';
// Importar o bootstrap JS para manipular o modal:
import { Modal } from 'bootstrap';

@Component({
  selector: 'app-seu-componente',
  templateUrl: './contact.component.html',
  styleUrls: ['./contact.component.css'],
})
export class ContactComponent {
  abrirModal(event: Event) {
    event.preventDefault(); // evita reload da página

    // Pega o elemento modal pelo id
    const modalElement = document.getElementById('contatoModal');
    if (modalElement) {
      // Cria a instância do modal do Bootstrap
      const modal = new Modal(modalElement);
      modal.show(); // abre o modal
    }
  }
}
