import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CarouselWorkshopComponent } from './carousel-workshop.component';

describe('CarouselWorkshopComponent', () => {
  let component: CarouselWorkshopComponent;
  let fixture: ComponentFixture<CarouselWorkshopComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [CarouselWorkshopComponent]
    });
    fixture = TestBed.createComponent(CarouselWorkshopComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
