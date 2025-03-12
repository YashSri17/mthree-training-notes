# Angular Project Structure Explained

## 📌 Project Initialization

```bash
ng new my-angular-app
cd my-angular-app
```

## 📂 Project Folder Structure

```
my-angular-app/
├── node_modules/
├── src/
├── .editorconfig
├── .gitignore
├── angular.json
├── package.json
├── package-lock.json
├── README.md
├── tsconfig.json
└── tsconfig.app.json
```

---

## 1. Project Root Files & Folders

| File/Folder            | Purpose                                                                 |
|------------------------|-------------------------------------------------------------------------|
| `node_modules/`         | All installed dependencies (auto-managed by npm)                        |
| `package.json`          | Lists app dependencies and scripts (e.g., `ng serve`, `ng build`)       |
| `package-lock.json`     | Exact versions of installed packages (auto-generated)                   |
| `angular.json`          | Angular workspace configuration — defines build, serve, test settings   |
| `tsconfig.json`         | TypeScript compiler configuration for the entire project                |
| `tsconfig.app.json`     | TypeScript settings for the application code                            |
| `.editorconfig`         | Code style rules for editors                                            |
| `.gitignore`            | Files/folders ignored by Git (e.g., `node_modules/`)                    |
| `README.md`             | Project overview or documentation                                       |

---

## 2. Inside `src/` Folder (Main Application Code)

```
src/
├── app/
│   ├── app.component.css
│   ├── app.component.html
│   ├── app.component.ts
│   ├── app.component.spec.ts
│   └── app.module.ts
│
├── assets/
├── environments/
│   ├── environment.ts
│   └── environment.prod.ts
├── favicon.ico
├── index.html
├── main.ts
├── polyfills.ts
├── styles.css
└── test.ts
```

---

## 📘 Explanation of `src/` Files

| File/Folder              | Purpose                                                              |
|--------------------------|----------------------------------------------------------------------|
| `app/`                   | Your application code (components, modules, services)                |
| `app.component.ts`       | Main component class (AppComponent logic)                            |
| `app.component.html`     | Main template (UI view)                                              |
| `app.component.css`      | Styles for the AppComponent                                          |
| `app.module.ts`          | Main module for registering components and services                  |
| `assets/`                | Store static files like images, fonts                                |
| `environments/`          | Environment settings for dev and production                          |
| `index.html`             | Main HTML wrapper file for Angular app                               |
| `main.ts`                | Entry point of Angular app (bootstraps AppModule)                    |
| `polyfills.ts`           | Provides browser compatibility support                               |
| `styles.css`             | Global CSS styles applied across the app                             |
| `test.ts`                | Test entry file (can be ignored initially)                           |

---

## 🔗 How Everything Connects

```bash
index.html → loads <app-root> → app.component.html renders the UI
main.ts → bootstraps AppModule → AppModule loads AppComponent
```

---

## Sample: `app.module.ts`

```ts
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppComponent } from './app.component';

@NgModule({
  declarations: [AppComponent],
  imports: [BrowserModule],
  bootstrap: [AppComponent]
})
export class AppModule {}
```

---

## Summary

| Component/File         | Description                                  |
|------------------------|----------------------------------------------|
| `main.ts`              | App entry point                              |
| `AppModule`            | Main module of the app                       |
| `AppComponent`         | First component to load                      |
| `index.html`           | Wrapper HTML file for Angular app           |
| `angular.json`         | Global Angular configuration                 |
| `package.json`         | Dependencies and npm scripts                 |
| `node_modules/`        | Folder containing installed libraries        |
