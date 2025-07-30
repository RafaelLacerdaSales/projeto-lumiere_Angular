import { Component, AfterViewInit } from '@angular/core';

declare function mostrarAlerta(): void;

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
})
export class AppComponent implements AfterViewInit {
  title = 'Angular_Lu';

  ngAfterViewInit(): void {
    mostrarAlerta();
  }
}
