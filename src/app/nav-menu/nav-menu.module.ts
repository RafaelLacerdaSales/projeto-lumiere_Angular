import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NavMenuComponent } from './nav-menu.component'; // certifique-se que o caminho está certo
import { RouterModule } from '@angular/router';

@NgModule({
  declarations: [NavMenuComponent],
  imports: [CommonModule, RouterModule],
  exports: [NavMenuComponent],
})
export class NavMenuModule {}
