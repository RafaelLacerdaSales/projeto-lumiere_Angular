import { TestBed } from '@angular/core/testing';

import { LumiereService } from './lumiere.service';

describe('LumiereService', () => {
  let service: LumiereService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(LumiereService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
