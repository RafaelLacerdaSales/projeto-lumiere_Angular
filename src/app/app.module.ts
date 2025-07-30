import { CarouselProceduresModule } from './carousel-procedures/carousel-procedures.module';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { NavMenuModule } from './nav-menu/nav-menu.module';
import { CarouselModule } from './carousel/carousel.module';
import { CarouselWorkshopModule } from './carousel-workshop/carousel-workshop.module';
import { HomeComponent } from './pages/home/home.component';

import { ContactComponent } from './pages/contact/contact.component';
import { FooterModule } from './footer/footer.module';
import { LoginModule } from './pages/login/login.module';
import { AlunoComponent } from './pages/aluno/aluno.component';

import { AulasComponent } from './pages/aulas/aulas.component';
import { WorkshopComponent } from './pages/workshop/workshop.component';
import { CarrinhoComponent } from './pages/carrinho/carrinho.component';

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
    BrowserModule,
    AppRoutingModule,
    NgbModule,
    NavMenuModule,
    CarouselModule,
    CarouselProceduresModule,
    CarouselWorkshopModule,
    FooterModule,
    LoginModule,
  ],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
