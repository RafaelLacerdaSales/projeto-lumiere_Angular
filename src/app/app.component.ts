import { Component, AfterViewInit } from '@angular/core';
import { ModalService } from './services/modal.service';
import * as bootstrap from 'bootstrap';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
})
export class AppComponent implements AfterViewInit {
  title = 'Angular_Lu';
  modalContato: bootstrap.Modal | undefined;

  constructor(private modalService: ModalService) {}

  ngAfterViewInit() {
    const modalElement = document.getElementById('contatoModal');
    if (modalElement) {
      this.modalContato = new bootstrap.Modal(modalElement);
    }

    this.modalService.abrirContato$.subscribe(() => {
      this.modalContato?.show();
    });
  }
}
