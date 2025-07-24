import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class ModalService {
  private abrirContatoSubject = new Subject<void>();
  abrirContato$ = this.abrirContatoSubject.asObservable();

  abrirContato() {
    this.abrirContatoSubject.next();
  }
}
