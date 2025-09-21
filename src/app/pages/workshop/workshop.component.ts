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
    const dadosCursos = sessionStorage.getItem("dados");
    if (dadosCursos) {
      console.log("Os dados existem no cache! Carregando...");
      this.cursosParaOsCard = JSON.parse(dadosCursos);
    } else {
      console.log("Cache vazio. Buscando da API...");
      this.workshopService.buscarCursos().subscribe((dadosRecebidos: cursosInterface[]) => {
        console.log("Dados recebidos da API!");
        this.cursosParaOsCard = dadosRecebidos;
        sessionStorage.setItem("dados", JSON.stringify(this.cursosParaOsCard));
      })
    };
  }
  comprar(curso: cursosInterface) {

  let carrinho: cursosInterface[] = JSON.parse(sessionStorage.getItem("carrinho") || "[]");

  
  carrinho.push(curso);


  sessionStorage.setItem("carrinho", JSON.stringify(carrinho));


  this.router.navigate(['/pagar']);
}

}
