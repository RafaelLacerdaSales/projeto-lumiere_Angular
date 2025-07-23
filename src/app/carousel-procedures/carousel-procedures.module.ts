import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CarouselProceduresComponent } from './carousel-procedures.component';
import { CarouselModule } from '../carousel/carousel.module';

@NgModule({
  declarations: [CarouselProceduresComponent],
  imports: [CommonModule, CarouselModule],
  exports: [CarouselProceduresComponent],
})
export class CarouselProceduresModule {}
