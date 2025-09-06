import { TestBed } from '@angular/core/testing';

import { WorkshopServiceService } from './workshop-service.service';

describe('WorkshopServiceService', () => {
  let service: WorkshopServiceService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(WorkshopServiceService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
