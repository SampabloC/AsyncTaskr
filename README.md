# AsyncTaskr ⚙️

AsyncTaskr es una API backend tipo mini SaaS para la gestión de tareas con procesamiento asíncrono.  
Está construida con Ruby on Rails y enfocada en prácticas de backend moderno como diseño de APIs, jobs en segundo plano y preparación para despliegue en la nube.

---

## 🚀 Objetivo del proyecto

Este proyecto tiene como objetivo practicar y consolidar habilidades de backend moderno:

- Desarrollo de APIs con Ruby on Rails
- Diseño de sistemas con procesamiento asíncrono
- Manejo de colas de trabajos (jobs)
- Contenerización con Docker
- Preparación para despliegue en cloud (AWS)

---

## 🧱 Stack tecnológico

- Ruby on Rails (API mode)
- PostgreSQL
- Redis (futuro para jobs)
- Sidekiq (futuro para background jobs)
- Docker (en implementación)
- Amazon Web Services (AWS) (objetivo de deploy)

---

## 📦 Estado actual del proyecto

- [x] Inicialización del proyecto Rails
- [x] Configuración base del repositorio
- [ ] Autenticación de usuarios
- [ ] CRUD de tareas
- [ ] Sistema de estados de tareas (pending, processing, done)
- [ ] Jobs en segundo plano
- [ ] Dockerización del proyecto
- [ ] Deploy en AWS

---

## 🏗️ Arquitectura (en progreso)

El sistema está diseñado con una arquitectura backend modular:

- API REST en Rails
- Base de datos PostgreSQL
- Workers para procesamiento asíncrono (pendiente)
- Redis como broker de colas (pendiente)
- Contenedores con Docker (pendiente)

---

## ⚙️ Instalación local

```bash
bundle install
rails db:create db:migrate
rails server
