import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MeuAprendizadoComponent } from './meu-aprendizado.component';

describe('MeuAprendizadoComponent', () => {
  let component: MeuAprendizadoComponent;
  let fixture: ComponentFixture<MeuAprendizadoComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [MeuAprendizadoComponent]
    });
    fixture = TestBed.createComponent(MeuAprendizadoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
