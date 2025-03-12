# 🚀 Angular Notes – Beginner - How to Start

## 📌 What is Angular?
Angular is a **TypeScript-based front-end framework** developed by Google. It’s used to build **Single Page Applications (SPAs)**.

---

## ✅ Angular Features
- Component-based architecture
- Two-way data binding
- Routing
- Dependency Injection
- Directives
- Services
- Angular CLI (Command Line Interface)

---

## ⚙️ Environment Setup (Ubuntu)
```bash
sudo apt update
sudo apt install nodejs npm -y
sudo npm install -g @angular/cli
ng version
```

## ⚙️ Writing first-hello-world program
```bash
sudo apt update
sudo apt upgrade
sudo npm install -g @angular/cli
ng version
cd new_python
ng new hello-world-app
cd hello-world-app
code .
```
## to make it just a hello world remove everything from app.component.ts and write:
```bash
<h1> Hello World <h1>
```
# save it and then run 
```bash
ng build OR ng serve
```
# Angular will provide you with a local host and just open it in your browser
