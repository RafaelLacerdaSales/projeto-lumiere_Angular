import { Component } from '@angular/core';
import { ModalService } from '../services/modal.service';

@Component({
  selector: 'app-nav-menu',
  templateUrl: './nav-menu.component.html',
  styleUrls: ['./nav-menu.component.css'],
})
export class NavMenuComponent {
  constructor(private modalService: ModalService) {}

  abrirModalContato(event: Event) {
    event.preventDefault();
    this.modalService.abrirContato();
  }
}
