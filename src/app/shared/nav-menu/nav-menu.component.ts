import {
  Component,
  OnInit,
  AfterViewInit,
  ChangeDetectorRef,
} from '@angular/core';
import { Router, NavigationEnd } from '@angular/router';
import { filter } from 'rxjs/operators';
import * as bootstrap from 'bootstrap';

@Component({
  selector: 'app-nav-menu',
  templateUrl: './nav-menu.component.html',
  styleUrls: ['./nav-menu.component.css'],
})
export class NavMenuComponent implements OnInit, AfterViewInit {
  isAuthenticated = false;
  isWorkshopRoute: boolean = false;
  modalContato: bootstrap.Modal | undefined;

  constructor(private router: Router, private cdr: ChangeDetectorRef) {}

  ngOnInit(): void {
    this.checkAuthentication();
    this.router.events
      .pipe(filter((event) => event instanceof NavigationEnd))
      .subscribe(() => {
        this.checkCurrentRoute();
      });

    window.addEventListener('storage', (event) => {
      if (event.key === 'token') {
        this.checkAuthentication();
        this.cdr.detectChanges();
      }
    });
  }

  private checkAuthentication(): void {
    this.isAuthenticated = localStorage.getItem('token') === 'validado';
  }

  private checkCurrentRoute(): void {
    this.isWorkshopRoute = this.router.url.includes('/workshop');
  }
  redirectToLogin() {
    this.router.navigate(['/login']);
  }

  logout() {
    localStorage.removeItem('token');
    this.isAuthenticated = false;
    this.router.navigate(['/home']);
  }

  ngAfterViewInit() {
    const modalElement = document.getElementById('modalContato');
    if (modalElement) {
      this.modalContato = new bootstrap.Modal(modalElement);
    }
  }

  abrirModalContato(event: Event) {
    event.preventDefault();
    this.modalContato?.show();
  }
}
