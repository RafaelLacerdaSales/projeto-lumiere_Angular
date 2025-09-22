import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { cursosInterface } from 'src/app/interfaces/cursos-interface';
import { WorkshopServiceService } from 'src/app/Service/workshop-service.service';

@Component({
  selector: 'app-workshop',
  templateUrl: './workshop.component.html',
  styleUrls: ['./workshop.component.css'],
})
export class WorkshopComponent implements OnInit {
  constructor(private workshopService: WorkshopServiceService,
    private router: Router
  ) { }

  // Propriedades existentes
  id: number = 0;
  tituloDoCurso: String = ``;
  descricao: String = ``;
  preco: String = ``;
  caminhoDaCapa: String = ``;
  cursosParaOsCard: cursosInterface[] = [];

  // Nova propriedade para o carrinho - valor fixo temporário
  cartItemCount: number = 0; // Ou 3 para ver o contador funcionando

  ngOnInit(): void {
    this.carregarCursosNoCard();
  }

  carregarCursosNoCard() {
    this.workshopService.buscarCursos().subscribe((dadosRecebidos: cursosInterface[]) => {
      console.log("Dados recebidos da API!");
      this.cursosParaOsCard = dadosRecebidos;
      localStorage.setItem("dados", JSON.stringify(this.cursosParaOsCard));
      console.log("teste")
    })
  }

  comprar(curso: cursosInterface) {

    let carrinho: cursosInterface[] = JSON.parse(sessionStorage.getItem("carrinho") || "[]");


    carrinho.push(curso);


    sessionStorage.setItem("carrinho", JSON.stringify(carrinho));


    this.router.navigate(['/pagar']);
  }

}
