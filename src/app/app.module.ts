import { CarouselProceduresModule } from './shared/carousel-procedures/carousel-procedures.module';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { NavMenuModule } from './shared/nav-menu/nav-menu.module';
import { CarouselModule } from './shared/carousel/carousel.module';
import { CarouselWorkshopModule } from './shared/carousel-workshop/carousel-workshop.module';
import { HomeComponent } from './pages/home/home.component';

import { ContactComponent } from './pages/contact/contact.component';
import { FooterModule } from './shared/footer/footer.module';
import { LoginModule } from './pages/login/login.module';
import { AlunoComponent } from './pages/aluno/aluno.component';

import { AulasComponent } from './pages/aulas/aulas.component';
import { WorkshopComponent } from './pages/workshop/workshop.component';
import { CarrinhoComponent } from './pages/carrinho/carrinho.component';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { SharedModule } from './shared/shared.module';
import { CommonModule } from '@angular/common';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    ContactComponent,
    AlunoComponent,
    AulasComponent,
    WorkshopComponent,
    CarrinhoComponent,
  ],
  imports: [
    SharedModule,
    BrowserModule,
    AppRoutingModule,
    NgbModule,
    NavMenuModule,
    CarouselModule,
    CarouselProceduresModule,
    CarouselWorkshopModule,
    FooterModule,
    LoginModule,
    FormsModule,
    HttpClientModule,
    CommonModule
  ],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
