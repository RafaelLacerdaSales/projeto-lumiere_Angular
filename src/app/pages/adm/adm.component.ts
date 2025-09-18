import { Component } from '@angular/core';
import { FormBuilder, FormsModule } from '@angular/forms';
import { AdmServiceService } from 'src/app/Service/adm-service.service';
import { WorkshopServiceService } from 'src/app/Service/workshop-service.service';
import { cursosInterface } from 'src/app/interfaces/cursos-interface';

@Component({
  selector: 'app-adm',
  templateUrl: './adm.component.html',
  styleUrls: ['./adm.component.css'],
})
export class AdmComponent {
  constructor(
    private workshopService: WorkshopServiceService,
    private fb: FormBuilder,
    private admService: AdmServiceService
  ) {}
  //para puxar os cursos
  buscarCursos: cursosInterface[] = [];

  // NOVA PROPRIEDADE PARA O MODAL DE EXCLUSÃO
  cursoSelecionadoParaExcluir: number = 0;

  // DADOS DOS CURSOS
  cursos: any[] = [];
  id: number = 0;
  tituloDoCurso: String = ``;
  descricao: String = ``;
  preco: String = ``;
  caminhoDaCapa: String = ``;

  // DADOS DO FUNCIONÁRIO
  nome: String = ``;
  cpf: String = ``;
  telefone: String = ``;
  senha: String = ``;
  email: String = ``;
  role: String = `ADMIN`;
  data_nascimento: String = ``;
  rg: String = ``;
  caminhoDoArquivo: String = ``;

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
  //REQUISIÇÕES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  editar(curso: any){
    console.log('Objeto CURSO completo recebido:', curso);
    this.id = curso;
  }

  deletar(){
      this.workshopService.deletarCurso(this.cursoSelecionadoParaExcluir).subscribe({
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

  atualizarCursos() {
    const dadosCursos = {
      tituloDoCurso: this.tituloDoCurso,
      descricao: this.descricao,
      preco: this.preco,
      caminhoDaCapa: this.caminhoDaCapa,
    };

    this.workshopService.atualizarCurso(this.id, dadosCursos).subscribe({
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

  ngOnInit(): void {
    this.carregarCursosNaTabela();
  }

  carregarCursosNaTabela() {
    const dadosCursos = sessionStorage.getItem('dados');
    if (dadosCursos) {
      console.log('Os dados existem no cache! Carregando...');
      this.buscarCursos = JSON.parse(dadosCursos);
    } else {
      console.log('Cache vazio. Buscando da API...');
      this.workshopService
        .buscarCursos()
        .subscribe((dadosRecebidos: cursosInterface[]) => {
          console.log('Dados recebidos da API!');
          this.buscarCursos = dadosRecebidos;
          sessionStorage.setItem('dados', JSON.stringify(this.buscarCursos));
        });
    }
  }

  cadastrarFuncionario() {
    const dadosFuncionarios = {
      nome: this.nome,
      cpf: this.cpf,
      telefone: this.telefone,
      senha: this.senha,
      email: this.email,
      role: this.role,
      data_nascimento: this.data_nascimento,
      rg: this.rg,
      caminhoDoArquivo: this.caminhoDoArquivo,
    };
    this.admService.cadastrarFuncionario(dadosFuncionarios).subscribe({
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