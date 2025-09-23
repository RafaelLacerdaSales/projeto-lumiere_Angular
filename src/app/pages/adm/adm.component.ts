import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { AdmServiceService } from 'src/app/Service/adm-service.service';
import { WorkshopServiceService } from 'src/app/Service/workshop-service.service';
import { cursosInterface } from 'src/app/interfaces/cursos-interface';

@Component({
  selector: 'app-adm',
  templateUrl: './adm.component.html',
  styleUrls: ['./adm.component.css'],
})
export class AdmComponent implements OnInit {
  constructor(
    private workshopService: WorkshopServiceService,
    private fb: FormBuilder,
    private admService: AdmServiceService
  ) {}

  // Para puxar os cursos
  buscarCursos: cursosInterface[] = [];

  // Propriedade para o modal de exclusão de curso
  cursoSelecionadoParaExcluir: number = 0;

  // Dados dos cursos
  id: number = 0;
  tituloDoCurso: string = '';
  descricao: string = '';
  preco: string = '';
  caminhoDaCapa: string = '';

  // Dados do funcionário
  nome: string = '';
  cpf: string = '';
  telefone: string = '';
  senha: string = '';
  email: string = '';
  role: string = 'ADMIN';
  data_nascimento: string = '';
  rg: string = '';
  caminhoDoArquivo: string = '';

  // Novas propriedades para funcionários
  funcionarios: any[] = [];
  funcionarioEditando: any = {};
  funcionarioIdParaExcluir: number = 0;

  ngOnInit(): void {
    this.carregarCursosNaTabela();
    // Mostrar formulário de cadastro por padrão
    this.mostrarSecao('formCadastro');
  }

  ngAfterViewInit() {
    this.configurarEventosBotoes();
  }

  configurarEventosBotoes() {
    // Configurar eventos de clique para os botões de navegação
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

  mostrarSecao(secaoId: string) {
    // Esconder todas as seções
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

    // Mostrar a seção específica
    const secaoAtiva = document.getElementById(secaoId);
    if (secaoAtiva) {
      secaoAtiva.style.display = 'block';
    }
  }

  // MÉTODOS PARA CURSOS
  editar(curso: any) {
    console.log('Objeto CURSO completo recebido:', curso);
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
          // Fechar modal (você pode adicionar lógica para fechar o modal Bootstrap)
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
          // Limpar formulário
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
          // Limpar formulário
          this.nome = '';
          this.cpf = '';
          this.telefone = '';
          this.senha = '';
          this.email = '';
          this.data_nascimento = '';
          this.rg = '';
          this.caminhoDoArquivo = '';
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
    // Dados de exemplo para demonstração
    this.funcionarios = [
      {
        id: 1,
        nome: 'João Silva',
        email: 'joao@empresa.com',
        telefone: '(11) 99999-9999',
        cpf: '123.456.789-00',
        data_nascimento: '1990-01-15',
        rg: '12.345.678-9'
      },
      {
        id: 2,
        nome: 'Maria Santos',
        email: 'maria@empresa.com',
        telefone: '(11) 88888-8888',
        cpf: '987.654.321-00',
        data_nascimento: '1985-05-20',
        rg: '98.765.432-1'
      }
    ];

    // Quando tiver o serviço real, descomente:
    /*
    this.admService.buscarFuncionarios().subscribe({
      next: (response: any) => {
        this.funcionarios = response;
      },
      error: (err) => {
        console.error('Erro ao carregar funcionários:', err);
        alert('Erro ao carregar funcionários');
      }
    });
    */
  }

  editarFuncionario(funcionario: any) {
    this.funcionarioEditando = { ...funcionario };
  }

  selecionarFuncionarioParaExcluir(id: number) {
    this.funcionarioIdParaExcluir = id;
  }

  atualizarFuncionario() {
    // Implementação real quando tiver o serviço
    console.log('Atualizando funcionário:', this.funcionarioEditando);
    alert('Funcionário atualizado com sucesso!');
    this.carregarFuncionarios();
  }

  excluirFuncionario() {
    if (this.funcionarioIdParaExcluir) {
      // Implementação real quando tiver o serviço
      console.log('Excluindo funcionário ID:', this.funcionarioIdParaExcluir);
      alert('Funcionário excluído com sucesso!');
      this.carregarFuncionarios();
      this.funcionarioIdParaExcluir = 0;
    }
  }
}