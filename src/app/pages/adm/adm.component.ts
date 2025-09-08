import { Component } from '@angular/core';
import { FormBuilder, FormsModule } from '@angular/forms';
import { WorkshopServiceService } from 'src/app/Service/workshop-service.service';

@Component({
  selector: 'app-adm',
  templateUrl: './adm.component.html',
  styleUrls: ['./adm.component.css'],
})
export class AdmComponent {
  constructor(
    private workshopService: WorkshopServiceService,
    private fb: FormBuilder
  ) {}
  cursos: any[] = [];
  id: number = 0;
  tituloDoCurso: String = ``;
  descricao: String = ``;
  preco: String = ``;
  caminhoDaCapa: String = ``;

  ngAfterViewInit() {
    const cadastro = document.getElementById('Cadastro');
    const videosWorkshop = document.getElementById('videosWorkshop');
    const formCadastro = document.getElementById('formCadastro');
    const containerAddVideios = document.getElementById('containerAddVideios');
    const tabela = document.getElementById('tabela');
    const tabela_videios = document.getElementById('tabela_videios');

    videosWorkshop?.addEventListener('click', (e) => {
      e.preventDefault();
      if (formCadastro && tabela_videios && containerAddVideios) {
        tabela_videios.style.display = 'none';
        formCadastro.style.display = 'none';
        containerAddVideios.style.display = 'block';
      }
    });
    cadastro?.addEventListener('click', (e) => {
      e.preventDefault();
      if (containerAddVideios && formCadastro && tabela_videios) {
        containerAddVideios.style.display = 'none';
        formCadastro.style.display = 'block';
        tabela_videios.style.display = 'none';
      }
    });
    tabela?.addEventListener('click', (e) => {
      e.preventDefault();
      if (formCadastro && tabela_videios && containerAddVideios) {
        containerAddVideios.style.display = 'none';
        formCadastro.style.display = 'none';
        tabela_videios.style.display = 'block';
      }
    });
  }

  cadastrarCursos() {
    console.log('entrei 1 etapa');
    const dadosCursos = {
      tituloDoCurso: this.tituloDoCurso,
      descricao: this.descricao,
      preco: this.preco,
      caminhoDaCapa: this.caminhoDaCapa,
    };

    this.workshopService.cadastrarCurso(dadosCursos).subscribe({
      next: (response) => {
        console.log('entrei 2 etapa');
        if (response.sucesso) {
          console.log('entrei 3 etapa');
          alert(response.sucesso);
        }
      },
      error: (err) => {
        if (err.error) {
          alert(err.error.error);
        }
      },
    });
  }
}
