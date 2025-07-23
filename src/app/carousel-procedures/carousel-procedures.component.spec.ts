import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CarouselProceduresComponent } from './carousel-procedures.component';

describe('CarouselProceduresComponent', () => {
  let component: CarouselProceduresComponent;
  let fixture: ComponentFixture<CarouselProceduresComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [CarouselProceduresComponent]
    });
    fixture = TestBed.createComponent(CarouselProceduresComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
