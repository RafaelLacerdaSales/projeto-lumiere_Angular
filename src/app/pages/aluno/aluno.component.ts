import { Component } from '@angular/core';

@Component({
  selector: 'app-aluno',
  templateUrl: './aluno.component.html',
  styleUrls: ['./aluno.component.css'],
})
export class AlunoComponent {
  imprimir() {
    window.print();
  }
  email = '';
  senha = '';
  modalAberto = false;
  window: any;

  salvarAlteracoes(form: any) {
    if (form.invalid) {
      form.control.markAllAsTouched();
      return;
    }
    alert('Alterações salvas!');
    form.resetForm();
  }

  abrirModal() {
    this.modalAberto = true;
  }

  fecharModal() {
    this.modalAberto = false;
  }

  baixarImagem() {
    const certificadoUrl =
      'https://via.placeholder.com/350x240.png?text=Certificado+Lumi%C3%A8re';
    const link = document.createElement('a');
    link.href = certificadoUrl;
    link.download = 'certificado-lumiere.png';
    link.click();
  }

  compartilharCertificado() {
    if (navigator.share) {
      navigator
        .share({
          title: 'Certificado Lumière Estética',
          text: 'Confira meu certificado!',
          url: window.location.href,
        })
        .catch(console.error);
    } else {
      alert('Compartilhamento não suportado neste navegador.');
    }
  }
}
