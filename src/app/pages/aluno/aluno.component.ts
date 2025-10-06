import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-aluno',
  templateUrl: './aluno.component.html',
  styleUrls: ['./aluno.component.css'],
})
export class AlunoComponent implements OnInit {
  public nomeUsuario: string = 'Nome Não Encontrado';
  public emailUsuario: string = 'email@naoencontrado.com';

  public modalAberto: boolean = false;
  public modalCertName: string = '';
  public modalCertLink: string = '';

  public certificados = [
    {
      nome: 'Curso Essencial de Estética',
      data: '15/03/2024',
      icon: 'bi-gem',
      link: 'https://via.placeholder.com/350x240.png?text=Certificado+Estetica+1',
      id: 1,
    },
    {
      nome: 'Microagulhamento Avançado',
      data: '20/01/2024',
      icon: 'bi-stars',
      link: 'https://via.placeholder.com/350x240.png?text=Certificado+Microagulhamento',
      id: 2,
    },
    {
      nome: 'Fundamentos de Cosmetologia',
      data: '10/05/2024',
      icon: 'bi-magic',
      link: 'https://via.placeholder.com/350x240.png?text=Certificado+Cosmetologia',
      id: 3,
    },
  ];

  ngOnInit(): void {
    const dadosUsuarioString = localStorage.getItem('dadosUsuario');

    if (dadosUsuarioString) {
      try {
        const dadosUsuario = JSON.parse(dadosUsuarioString);
        this.nomeUsuario = dadosUsuario.nome || this.nomeUsuario;
        this.emailUsuario = dadosUsuario.email || this.emailUsuario;
      } catch (e) {
        console.error('Erro ao ler dados do usuário:', e);
      }
    }
  }

  public openCertificadoModal(cert: any): void {
    this.modalCertName = cert.nome;
    this.modalCertLink = cert.link;
    this.modalAberto = true;
  }

  public fecharModal(): void {
    this.modalAberto = false;
    this.modalCertName = '';
    this.modalCertLink = '';
  }

  public imprimir(): void {
    window.print();
    this.fecharModal();
  }

  public baixarCertificado(): void {
    if (this.modalCertLink) {
      const link = document.createElement('a');
      link.href = this.modalCertLink;
      link.download = `${this.modalCertName.replace(/\s/g, '-')}.png`;
      link.click();
      this.fecharModal();
    }
  }

  public compartilharCertificado(): void {
    if (navigator.share) {
      navigator
        .share({
          title: `Meu Certificado: ${this.modalCertName}`,
          text: `Confira meu certificado de ${this.modalCertName}!`,
          url: this.modalCertLink || window.location.href,
        })
        .catch(console.error);
    }
    this.fecharModal();
  }
}
