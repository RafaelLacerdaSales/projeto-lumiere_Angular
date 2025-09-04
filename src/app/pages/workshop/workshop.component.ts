import { Component } from '@angular/core';
import { cursosInterface } from 'src/app/interfaces/cursos-interface';
import { WorkshopServiceService } from 'src/app/Service/workshop-service.service';

@Component({
  selector: 'app-workshop',
  templateUrl: './workshop.component.html',
  styleUrls: ['./workshop.component.css'],
})
export class WorkshopComponent {
  constructor(private workshopService: WorkshopServiceService) { }
  id: number = 0;
  tituloDoCurso: String = ``;
  descricao: String = ``;
  preco: String = ``;
  caminhoDaCapa: String = ``;

  cursosParaOsCard: cursosInterface[] = [];

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
}
