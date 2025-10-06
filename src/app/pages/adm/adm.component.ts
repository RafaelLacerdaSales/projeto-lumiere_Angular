import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { AdmServiceService } from 'src/app/Service/adm-service.service';
import { WorkshopServiceService } from 'src/app/Service/workshop-service.service';
import { cursosInterface } from 'src/app/interfaces/cursos-interface';

// Interface para funcionários
export interface FuncionarioInterface {
  id: number;
  nome: string;
  email: string;
  telefone: string;
  cpf: string;
  data_nascimento: string;
  rg: string;
  senha?: string;
  role?: string;
  caminhoDoArquivo?: string;
}

@Component({
  selector: 'app-adm',
  templateUrl: './adm.component.html',
  styleUrls: ['./adm.component.css'],
})
export class AdmComponent implements OnInit {
  
  // Para puxar os cursos
  buscarCursos: cursosInterface[] = [];

  // Para puxar os funcionários
  funcionarios: FuncionarioInterface[] = [];

  // Propriedades para exclusão
  cursoSelecionadoParaExcluir: number = 0;
  funcionarioIdParaExcluir: number = 0;

  // Dados dos cursos
  id: number = 0;
  tituloDoCurso: string = '';
  descricao: string = '';
  preco: string = '';
  caminhoDaCapa: string = '';

  // Dados do funcionário (para cadastro)
  nome: string = '';
  cpf: string = '';
  telefone: string = '';
  senha: string = '';
  email: string = '';
  role: string = 'ADMIN';
  data_nascimento: string = '';
  rg: string = '';
  caminhoDoArquivo: string = '';

  // Funcionário em edição
  funcionarioEditando: FuncionarioInterface = {
    id: 0,
    nome: '',
    email: '',
    telefone: '',
    cpf: '',
    data_nascimento: '',
    rg: ''
  };

  constructor(
    private workshopService: WorkshopServiceService,
    private fb: FormBuilder,
    private admService: AdmServiceService
  ) {}

  ngOnInit(): void {
    this.carregarCursosNaTabela();
    this.carregarFuncionarios();
    this.mostrarSecao('formCadastro');
  }

  ngAfterViewInit() {
    this.configurarEventosBotoes();
  }

  mostrarSecao(secaoId: string) {
    const secoes = [
      'formCadastro',
      'tabela_funcionarios',
      'containerAddVideios',
      'container_aulas',
      'tabela_videios'
    ];
    
    secoes.forEach(id => {
      const elemento = document.getElementById(id);
      if (elemento) {
        elemento.style.display = 'none';
      }
    });

    const secaoAtiva = document.getElementById(secaoId);
    if (secaoAtiva) {
      secaoAtiva.style.display = 'block';
    }
  }

  configurarEventosBotoes() {
    const cadastro = document.getElementById('Cadastro');
    const videosWorkshop = document.getElementById('videosWorkshop');
    const tabela = document.getElementById('tabela');
    const tabelafuncionarios = document.getElementById('tabelafuncionarios');
    const addAula = document.querySelector('.addAula');
    const addCurso = document.querySelector('.addCurso');

    cadastro?.addEventListener('click', () => this.mostrarSecao('formCadastro'));
    videosWorkshop?.addEventListener('click', () => this.mostrarSecao('containerAddVideios'));
    tabela?.addEventListener('click', () => this.mostrarSecao('tabela_videios'));
    tabelafuncionarios?.addEventListener('click', () => {
      this.mostrarSecao('tabela_funcionarios');
      this.carregarFuncionarios();
    });
    addAula?.addEventListener('click', () => this.mostrarSecao('container_aulas'));
    addCurso?.addEventListener('click', () => this.mostrarSecao('containerAddVideios'));
  }

  // MÉTODOS PARA CURSOS
  editar(curso: any) {
    this.id = curso.id;
    this.tituloDoCurso = curso.tituloDoCurso;
    this.descricao = curso.descricao;
    this.preco = curso.preco;
  }

  deletar() {
    if (this.cursoSelecionadoParaExcluir) {
      this.workshopService.deletarCurso(this.cursoSelecionadoParaExcluir).subscribe({
        next: (response) => {
          if (response.sucesso) {
            alert(response.sucesso);
            this.carregarCursosNaTabela();
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

  atualizarCursos() {
    const dadosCursos = {
      tituloDoCurso: this.tituloDoCurso,
      descricao: this.descricao,
      preco: this.preco,
      caminhoDaCapa: this.caminhoDaCapa,
    };
    
    this.workshopService.atualizarCurso(this.id, dadosCursos).subscribe({
      next: (response) => {
        if (response.sucesso) {
          alert(response.sucesso);
          this.carregarCursosNaTabela();
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
    const dadosCursos = {
      tituloDoCurso: this.tituloDoCurso,
      descricao: this.descricao,
      preco: this.preco,
      caminhoDaCapa: this.caminhoDaCapa,
    };
    
    this.workshopService.cadastrarCurso(dadosCursos).subscribe({
      next: (response) => {
        if (response.sucesso) {
          alert(response.sucesso);
          this.carregarCursosNaTabela();
          this.tituloDoCurso = '';
          this.descricao = '';
          this.preco = '';
          this.caminhoDaCapa = '';
        }
      },
      error: (err) => {
        if (err.error) {
          alert(err.error.error);
        }
      },
    });
  }

  carregarCursosNaTabela() {
    this.workshopService.buscarCursos().subscribe((dadosRecebidos: cursosInterface[]) => {
      this.buscarCursos = dadosRecebidos;
    });
  }

  // MÉTODOS PARA FUNCIONÁRIOS - CORRIGIDOS
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
        if (response.sucesso) {
          alert(response.sucesso);
          this.nome = '';
          this.cpf = '';
          this.telefone = '';
          this.senha = '';
          this.email = '';
          this.data_nascimento = '';
          this.rg = '';
          this.caminhoDoArquivo = '';
          this.carregarFuncionarios();
        }
      },
      error: (err) => {
        if (err.error) {
          alert(err.error.error);
        }
      },
    });
  }

  carregarFuncionarios() {
    this.admService.buscarFuncionarios().subscribe({
      next: (response: any) => {
        if (Array.isArray(response)) {
          this.funcionarios = response;
        } 
        else if (response.dados) {
          this.funcionarios = response.dados;
        }
        else {
          this.funcionarios = response;
        }
      },
      error: (err) => {
        console.error('Erro ao carregar funcionários:', err);
        this.funcionarios = [];
      }
    });
  }

  // CORREÇÃO: Garantir que o funcionárioEditando tenha todos os dados
  editarFuncionario(funcionario: FuncionarioInterface) {
    this.funcionarioEditando = { 
      id: funcionario.id,
      nome: funcionario.nome,
      email: funcionario.email,
      telefone: funcionario.telefone,
      cpf: funcionario.cpf,
      data_nascimento: funcionario.data_nascimento,
      rg: funcionario.rg
    };
  }

  // CORREÇÃO: Garantir que o ID está sendo setado
  selecionarFuncionarioParaExcluir(id: number) {
    this.funcionarioIdParaExcluir = id;
    console.log('Funcionário selecionado para excluir:', id);
  }

  // CORREÇÃO: Verificar se o ID existe antes de atualizar
  atualizarFuncionario() {
    if (!this.funcionarioEditando.id) {
      alert('Erro: ID do funcionário não encontrado');
      return;
    }

    this.admService.atualizarFuncionario(this.funcionarioEditando.id, this.funcionarioEditando).subscribe({
      next: (response) => {
        if (response.sucesso) {
          alert(response.sucesso);
          this.carregarFuncionarios();
          // Fechar o modal (opcional)
          const modal = document.getElementById('editarFuncionarioModal');
          if (modal) {
            const bootstrapModal = (window as any).bootstrap.Modal.getInstance(modal);
            if (bootstrapModal) {
              bootstrapModal.hide();
            }
          }
        }
      },
      error: (err) => {
        if (err.error) {
          alert(err.error.error);
        }
      },
    });
  }

  // CORREÇÃO: Verificar se o ID existe antes de excluir
  excluirFuncionario() {
    if (!this.funcionarioIdParaExcluir) {
      alert('Erro: ID do funcionário não encontrado');
      return;
    }

    this.admService.excluirFuncionario(this.funcionarioIdParaExcluir).subscribe({
      next: (response) => {
        if (response.sucesso) {
          alert(response.sucesso);
          this.carregarFuncionarios();
          this.funcionarioIdParaExcluir = 0;
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