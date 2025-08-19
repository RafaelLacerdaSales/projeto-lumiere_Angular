import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LoginComponent } from './login.component';
import { FooterModule } from 'src/app/footer/footer.module';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';

@NgModule({
  declarations: [LoginComponent],
  imports: [CommonModule, FooterModule, RouterModule, FormsModule],
  exports: [LoginComponent],
})
export class LoginModule {}
