import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { MeuAprendizadoComponent } from './meu-aprendizado.component';
import { SharedModule } from 'src/app/shared/shared.module';

@NgModule({
  declarations: [MeuAprendizadoComponent],
  imports: [CommonModule, SharedModule],
})
export class MeuAprendizadoModule {}
