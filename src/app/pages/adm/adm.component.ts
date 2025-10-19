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

// Interface para administradores
export interface AdministradorInterface {
  id: number;
  nome: string;
  email: string;
  telefone: string;
  cpf: string;
  data_nascimento: string;
  rg: string;
  senha?: string;
  role?: string;
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

  // Para puxar os administradores
  administradores: AdministradorInterface[] = [];

  // Propriedades para exclusão
  cursoSelecionadoParaExcluir: number = 0;
  funcionarioIdParaExcluir: number = 0;
  administradorIdParaExcluir: number = 0;

  // Dados dos cursos
  id: number = 0;
  tituloDoCurso: string = '';
  descricao: string = '';
  preco: string = '';
  caminhoDaCapa: string = '';

  // Para armazenar o arquivo de imagem selecionado para upload
  selectedFile: File | null = null;
  // Para armazenar o ID do curso em edição
  cursoEmEdicaoId: number | null = null;

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

  // Dados do administrador (para cadastro)
  nomeAdministrador: string = '';
  cpfAdministrador: string = '';
  telefoneAdministrador: string = '';
  senhaAdministrador: string = '';
  emailAdministrador: string = '';
  roleAdministrador: string = 'SUPER_ADMIN';
  data_nascimentoAdministrador: string = '';
  rgAdministrador: string = '';

  // Funcionário em edição
  funcionarioEditando: FuncionarioInterface = {
    id: 0,
    nome: '',
    email: '',
    telefone: '',
    cpf: '',
    data_nascimento: '',
    rg: '',
  };

  // Administrador em edição
  administradorEditando: AdministradorInterface = {
    id: 0,
    nome: '',
    email: '',
    telefone: '',
    cpf: '',
    data_nascimento: '',
    rg: '',
  };

  constructor(
    private workshopService: WorkshopServiceService,
    private fb: FormBuilder,
    private admService: AdmServiceService
  ) {}

  ngOnInit(): void {
    this.carregarCursosNaTabela();
    this.carregarFuncionarios();
    this.carregarAdministradores();
    this.mostrarSecao('formCadastro');
  }

  ngAfterViewInit() {
    this.configurarEventosBotoes();
  }

  mostrarSecao(secaoId: string) {
    const secoes = [
      'formCadastro',
      'formCadastroAdministrador',
      'tabela_funcionarios',
      'tabela_administradores',
      'containerAddVideios',
      'container_aulas',
      'tabela_videios',
    ];

    secoes.forEach((id) => {
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
    const tabelaAdministrador = document.getElementById('tabelaadministrador');
    const videosWorkshop = document.getElementById('videosWorkshop');
    const tabela = document.getElementById('tabela');
    const tabelafuncionarios = document.getElementById('tabelafuncionarios');
    const addAula = document.querySelector('.addAula');
    const addCurso = document.querySelector('.addCurso');

    cadastro?.addEventListener('click', () => this.mostrarSecao('formCadastro'));
    tabelaAdministrador?.addEventListener('click', () => this.mostrarSecao('formCadastroAdministrador'));
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
  onFileSelectedCadastro(event: any): void {
    const fileList: FileList = event.target.files;
    if (fileList && fileList.length > 0) {
      this.selectedFile = fileList[0];
    } else {
      this.selectedFile = null;
    }
  }

  onFileSelectedEdicao(event: any): void {
    const fileList: FileList = event.target.files;
    if (fileList && fileList.length > 0) {
      this.selectedFile = fileList[0];
    } else {
      this.selectedFile = null;
    }
  }

  editar(curso: any) {
    this.id = curso.id;
    this.tituloDoCurso = curso.tituloDoCurso;
    this.descricao = curso.descricao;
    this.preco = curso.preco;
    this.caminhoDaCapa = curso.caminhoDaCapa;
    this.selectedFile = null;
    this.cursoEmEdicaoId = curso.id;
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
    };

    this.workshopService.atualizarCurso(this.id, dadosCursos, this.selectedFile).subscribe({
      next: (response) => {
        if (response.sucesso) {
          alert(response.sucesso);
          this.carregarCursosNaTabela();
          this.selectedFile = null;
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
    if (!this.selectedFile) {
      alert('Por favor, selecione uma imagem de capa.');
      return;
    }

    const dadosCursos = {
      tituloDoCurso: this.tituloDoCurso,
      descricao: this.descricao,
      preco: this.preco,
    };

    this.workshopService.cadastrarCurso(dadosCursos, this.selectedFile).subscribe({
      next: (response) => {
        if (response.sucesso) {
          alert(response.sucesso);
          this.carregarCursosNaTabela();
          this.tituloDoCurso = '';
          this.descricao = '';
          this.preco = '';
          this.selectedFile = null;
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

  // MÉTODOS PARA FUNCIONÁRIOS
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
        } else if (response.dados) {
          this.funcionarios = response.dados;
        } else {
          this.funcionarios = response;
        }
      },
      error: (err) => {
        console.error('Erro ao carregar funcionários:', err);
        this.funcionarios = [];
      },
    });
  }

  editarFuncionario(funcionario: FuncionarioInterface) {
    this.funcionarioEditando = {
      id: funcionario.id,
      nome: funcionario.nome,
      email: funcionario.email,
      telefone: funcionario.telefone,
      cpf: funcionario.cpf,
      data_nascimento: funcionario.data_nascimento,
      rg: funcionario.rg,
    };
  }

  selecionarFuncionarioParaExcluir(id: number) {
    this.funcionarioIdParaExcluir = id;
    console.log('Funcionário selecionado para excluir:', id);
  }

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

  // MÉTODOS PARA ADMINISTRADORES
  cadastrarAdministrador() {
    const dadosAdministrador = {
      nome: this.nomeAdministrador,
      cpf: this.cpfAdministrador,
      telefone: this.telefoneAdministrador,
      senha: this.senhaAdministrador,
      email: this.emailAdministrador,
      role: this.roleAdministrador,
      data_nascimento: this.data_nascimentoAdministrador,
      rg: this.rgAdministrador,
    };

    this.admService.cadastrarAdministrador(dadosAdministrador).subscribe({
      next: (response) => {
        if (response.sucesso) {
          alert(response.sucesso);
          this.nomeAdministrador = '';
          this.cpfAdministrador = '';
          this.telefoneAdministrador = '';
          this.senhaAdministrador = '';
          this.emailAdministrador = '';
          this.data_nascimentoAdministrador = '';
          this.rgAdministrador = '';
          this.carregarAdministradores();
        }
      },
      error: (err) => {
        if (err.error) {
          alert(err.error.error);
        }
      },
    });
  }

  carregarAdministradores() {
    this.admService.buscarAdministradores().subscribe({
      next: (response: any) => {
        if (Array.isArray(response)) {
          this.administradores = response;
        } else if (response.dados) {
          this.administradores = response.dados;
        } else {
          this.administradores = response;
        }
      },
      error: (err) => {
        console.error('Erro ao carregar administradores:', err);
        this.administradores = [];
      },
    });
  }

  editarAdministrador(administrador: AdministradorInterface) {
    this.administradorEditando = {
      id: administrador.id,
      nome: administrador.nome,
      email: administrador.email,
      telefone: administrador.telefone,
      cpf: administrador.cpf,
      data_nascimento: administrador.data_nascimento,
      rg: administrador.rg,
    };
  }

  selecionarAdministradorParaExcluir(id: number) {
    this.administradorIdParaExcluir = id;
    console.log('Administrador selecionado para excluir:', id);
  }

  atualizarAdministrador() {
    if (!this.administradorEditando.id) {
      alert('Erro: ID do administrador não encontrado');
      return;
    }

    this.admService.atualizarAdministrador(this.administradorEditando.id, this.administradorEditando).subscribe({
      next: (response) => {
        if (response.sucesso) {
          alert(response.sucesso);
          this.carregarAdministradores();
          const modal = document.getElementById('editarAdministradorModal');
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

  excluirAdministrador() {
    if (!this.administradorIdParaExcluir) {
      alert('Erro: ID do administrador não encontrado');
      return;
    }

    this.admService.excluirAdministrador(this.administradorIdParaExcluir).subscribe({
      next: (response) => {
        if (response.sucesso) {
          alert(response.sucesso);
          this.carregarAdministradores();
          this.administradorIdParaExcluir = 0;
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