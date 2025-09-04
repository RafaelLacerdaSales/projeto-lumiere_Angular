import { Component } from '@angular/core';

@Component({
  selector: 'app-adm',
  templateUrl: './adm.component.html',
  styleUrls: ['./adm.component.css'],
})
export class AdmComponent {
  ngAfterViewInit() {
    const cadastro = document.getElementById('Cadastro');
    const videosWorkshop = document.getElementById('videosWorkshop');
    const formCadastro = document.getElementById('formCadastro');
    const containerAddVideios = document.getElementById('containerAddVideios');

    videosWorkshop?.addEventListener('click', (e) => {
      e.preventDefault();
      if (formCadastro && containerAddVideios) {
        formCadastro.style.display = 'none';
        containerAddVideios.style.display = 'block';
      }
    });
    cadastro?.addEventListener('click', (e) => {
      e.preventDefault();
      if (containerAddVideios && formCadastro) {
        containerAddVideios.style.display = 'none';
        formCadastro.style.display = 'block';
      }
    });
  }


  
}
