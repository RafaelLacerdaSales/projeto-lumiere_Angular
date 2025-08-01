import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LoginComponent } from './login.component';
import { FooterModule } from 'src/app/footer/footer.module';
import { RouterModule } from '@angular/router';

@NgModule({
  declarations: [LoginComponent],
  imports: [CommonModule, FooterModule, RouterModule],
  exports: [LoginComponent],
})
export class LoginModule {}
