import { Component, AfterViewInit } from '@angular/core';
import { Router, NavigationEnd } from '@angular/router';
import { filter } from 'rxjs/operators';
import * as bootstrap from 'bootstrap';

@Component({
  selector: 'app-nav-menu',
  templateUrl: './nav-menu.component.html',
  styleUrls: ['./nav-menu.component.css'],
})
export class NavMenuComponent implements AfterViewInit {
  modalContato: bootstrap.Modal | undefined;

  ngAfterViewInit() {
    const Btn_visible = document.querySelector('.Btn_visible');
    const btnLogin_block = document.querySelector(
      '.btn-login_block'
    ) as HTMLElement;
    const BtnNoneVisible = document.querySelector('.BtnNoneVisible');

    if (Btn_visible && btnLogin_block) {
      Btn_visible.addEventListener('click', function () {
        btnLogin_block.style.pointerEvents = 'auto';
        btnLogin_block.style.backgroundColor = '#007bff';
        btnLogin_block.style.color = 'white';

        btnLogin_block.addEventListener('mouseenter', () => {
          btnLogin_block.style.backgroundColor = '#0056b3';
        });

        btnLogin_block.addEventListener('mouseleave', () => {
          btnLogin_block.style.backgroundColor = '#007bff';
        });
      });
    }
    if (BtnNoneVisible && btnLogin_block) {
      BtnNoneVisible.addEventListener('click', function () {
        btnLogin_block.style.pointerEvents = 'none';
        btnLogin_block.style.backgroundColor = 'transparent';
        btnLogin_block.style.color = 'transparent';
      });
    }

    const modalElement = document.getElementById('modalContato');
    if (modalElement) {
      this.modalContato = new bootstrap.Modal(modalElement);
    }
  }

  abrirModalContato(event: Event) {
    event.preventDefault();
    this.modalContato?.show();
  }
}
