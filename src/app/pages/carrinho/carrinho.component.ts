import { CarrinhoModule } from './carrinho.module';
import {
  AfterViewInit,
  Component,
  ElementRef,
  Renderer2,
  ViewChild,
} from '@angular/core';

@Component({
  selector: 'app-carrinho',
  templateUrl: './carrinho.component.html',
  styleUrls: ['./carrinho.component.css'], // Pode estar vazio se você for estilizar só por código
})
export class CarrinhoComponent implements AfterViewInit {
  @ViewChild('modalContent', { static: false }) modalContentRef!: ElementRef;

  constructor(
    private renderer: Renderer2,
    private el: ElementRef,
  ) {}

  ngAfterViewInit(): void {
    const form = document.getElementById('payment-form') as HTMLFormElement;
    const modal = document.getElementById('payment-modal') as HTMLElement;

    this.estilizarModal(modal);

    form?.addEventListener('submit', (e) => {
      e.preventDefault();

      const selected = document.querySelector(
        'input[name="payment"]:checked',
      ) as HTMLInputElement;

      if (!selected) {
        alert('Por favor, selecione uma forma de pagamento.');
        return;
      }

      let content = '';
      switch (selected.value) {
        case 'credit':
        case 'debit':
          content = `
            <h3>Dados do Cartão</h3>
            <label>Número do Cartão</label>
            <input type="text" placeholder="0000 0000 0000 0000" />
            <label>Nome no Cartão</label>
            <input type="text" placeholder="Nome completo" />
            <label>Validade</label>
            <input type="text" placeholder="MM/AA" />
            <label>CVV</label>
            <input type="text" placeholder="123" />
            <button class="close-modal">Fechar</button>
          `;
          break;
        case 'pix':
          content = `
            <h3>Pagamento via Pix</h3>
            <p>Escaneie o QR Code abaixo:</p>
            <img class="qr" src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=chavepix123" alt="QR Code Pix" />
            <button class="close-modal">Fechar</button>
          `;
          break;
        case 'boleto':
          content = `
            <h3>Gerar Boleto Bancário</h3>
            <label>Informe seu e-mail</label>
            <input type="email" placeholder="seu@email.com" />
            <button class="close-modal">Fechar</button>
          `;
          break;
      }

      this.modalContentRef.nativeElement.innerHTML = content;
      this.estilizarConteudoModal();

      modal.style.display = 'flex';
    });
  }

  closeModal(): void {
    const modal = document.getElementById('payment-modal');
    if (modal) {
      modal.style.display = 'none';
    }
  }

  handleBackdropClick(event: MouseEvent): void {
    const modal = document.getElementById('payment-modal');
    if (event.target === modal) {
      this.closeModal();
    }
  }

  private estilizarModal(modal: HTMLElement): void {
    Object.assign(modal.style, {
      display: 'none',
      position: 'fixed',
      zIndex: '9999',
      left: '0',
      top: '0',
      width: '100vw',
      height: '100vh',
      backgroundColor: 'rgba(0, 0, 0, 0.6)',
      justifyContent: 'center',
      alignItems: 'center',
      padding: '1rem',
    });
  }

  private estilizarConteudoModal(): void {
    setTimeout(() => {
      const content = this.modalContentRef.nativeElement as HTMLElement;
      Object.assign(content.style, {
        backgroundColor: '#fff',
        borderRadius: '12px',
        maxWidth: '400px',
        width: '100%',
        padding: '24px',
        boxShadow: '0 8px 24px rgba(0, 0, 0, 0.2)',
        fontFamily: 'Arial, sans-serif',
      });

      const inputs = content.querySelectorAll('input');
      inputs.forEach((input) => {
        Object.assign((input as HTMLElement).style, {
          width: '100%',
          padding: '10px',
          fontSize: '14px',
          border: '1px solid #ccc',
          borderRadius: '6px',
          marginBottom: '12px',
          boxSizing: 'border-box',
        });
      });

      const labels = content.querySelectorAll('label');
      labels.forEach((label) => {
        Object.assign((label as HTMLElement).style, {
          display: 'block',
          margin: '8px 0 4px',
          fontSize: '14px',
          color: '#555',
        });
      });

      const qr = content.querySelector('.qr') as HTMLImageElement;
      if (qr) {
        Object.assign(qr.style, {
          display: 'block',
          margin: '12px auto',
          maxWidth: '150px',
        });
      }

      const closeButton = content.querySelector('.close-modal') as HTMLElement;
      if (closeButton) {
        Object.assign(closeButton.style, {
          marginTop: '12px',
          backgroundColor: '#dc3545',
          color: 'white',
          border: 'none',
          padding: '10px 16px',
          fontSize: '14px',
          borderRadius: '6px',
          cursor: 'pointer',
          width: '100%',
        });

        closeButton.addEventListener('click', () => this.closeModal());
      }
    }, 0);
  }
}
