
# 🎨 Second Angular App – Color Change Feature

This project demonstrates a simple **Angular color changer application** where a user can click buttons to dynamically change the background color of a box.

---

## 📁 Project Overview

This is your second Angular application created using the Angular CLI. The app contains a color box and color control buttons (Red, Blue, Green, Purple). Clicking any button changes the box's color dynamically using Angular property binding and event binding.

---

## 🔧 Tech Stack
- Angular 16+
- HTML
- CSS
- TypeScript

---

## ▶️ How to Run the App

1. **Navigate to the project folder**
   ```bash
   cd second-app
   ```

2. **Run the development server**
   ```bash
   ng serve
   ```

3. Open your browser and visit:  
   👉 `http://localhost:4200`

---

## 📂 Folder Structure (Key Files)

```
second-app/
├── src/
│   ├── app/
│   │   ├── app.component.html      # UI template
│   │   ├── app.component.css       # Styling
│   │   ├── app.component.ts        # Component logic
│   └── ...
└── ...
```

---

## 📄 Code Summary

### 🔸 `app.component.html`

```html
<div class="container">
  <h1> Second Angular App</h1>
  <p> This is a second Angular App</p>
  <div class="color-change">
    <h2>Color Change</h2>
    <div class="color-box" [style.backgroundColor]="currentColor"></div>
    <div class="color-controls">
      <button (click)="changeColor('red')">Red</button>
      <button (click)="changeColor('blue')">Blue</button>
      <button (click)="changeColor('green')">Green</button>
      <button (click)="changeColor('purple')">Purple</button>
    </div>
  </div>
</div>
```

---

### 🔸 `app.component.css`

```css
.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
}

.color-change {
  text-align: center;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.color-box {
  width: 100px;
  height: 100px;
  margin: 20px auto;
  border-radius: 5px;
  border: 1px solid #ccc;
  transition: background-color 0.3s ease;
}

.color-controls {
  margin-top: 10px;
  display: flex;
  justify-content: center;
  gap: 10px;
}

button {
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-weight: bold;
  transition: background-color 0.3s ease;
}

button:hover {
  background-color: #333;
  color: #fff;
  transform: scale(1.05);
}

button:nth-child(1) {
  background-color: #ff0000;
  color: white;
}

button:nth-child(2) {
  background-color: #0000ff;
  color: white;
}

button:nth-child(3) {
  background-color: #00ff00;
  color: white;
}

button:nth-child(4) {
  background-color: #800080;
  color: white;
}
```

---

### 🔸 `app.component.ts`

```ts
import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'second-app';
  currentColor = '#cccccc'; // Default box color

  changeColor(color: string) {
    this.currentColor = color;
  }
}
```

---

## ✅ Output Preview

> ![App Screenshot](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%205/Day%2023/second-project.png)

*This is how the color changer UI looks with buttons and color box.*

---

## 📌 Key Concepts Covered
- Angular Event Binding: `(click)="changeColor('color')"`
- Angular Property Binding: `[style.backgroundColor]="currentColor"`
- Dynamic styling via component state
- Component structure and modular styling

---

## 📎 Summary

This app introduces basic Angular binding concepts and how to dynamically interact with the DOM using Angular’s reactive programming model. It's a great beginner project to get hands-on experience with Angular events, bindings, and styling.

---

## 🙌 Next Steps (Suggestions)
- Add more color options
- Use dropdown or color picker
- Store selected color in local storage
- Animate the color transition more smoothly

---

