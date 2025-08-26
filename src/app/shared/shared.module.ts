import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CarouselModule } from './carousel/carousel.module';
import { CarouselProceduresModule } from './carousel-procedures/carousel-procedures.module';
import { CarouselWorkshopModule } from './carousel-workshop/carousel-workshop.module';
import { FooterModule } from './footer/footer.module';
import { NavMenuModule } from './nav-menu/nav-menu.module';



@NgModule({
  declarations: [],
  imports: [
    CommonModule
  ],
  exports:[
    CarouselModule,
    CarouselProceduresModule,
    CarouselWorkshopModule,
    FooterModule,
    NavMenuModule
  ]
})
export class SharedModule { }
