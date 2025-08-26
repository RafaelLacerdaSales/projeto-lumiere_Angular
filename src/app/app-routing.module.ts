import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { HomeComponent } from './pages/home/home.component';
import { WorkshopComponent } from './pages/workshop/workshop.component';
import { ContactComponent } from './pages/contact/contact.component';
import { LoginComponent } from './pages/login/login.component';
import { AulasComponent } from './pages/aulas/aulas.component';
import { CarrinhoComponent } from './pages/carrinho/carrinho.component';
import { AdmComponent } from './pages/adm/adm.component';
import { AlunoComponent } from './pages/aluno/aluno.component';

const routes: Routes = [
  { path: '', redirectTo: 'home', pathMatch: 'full' },
  { path: 'home', component: HomeComponent },
  { path: 'workshop', component: WorkshopComponent },
  { path: 'contact', component: ContactComponent },
  { path: 'login', component: LoginComponent },
  { path: 'aulas', component: AulasComponent },
  { path: 'compras', component: CarrinhoComponent },
  { path: 'adm', component: AdmComponent },
  { path: 'aluno', component: AlunoComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
