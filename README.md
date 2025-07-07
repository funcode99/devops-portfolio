# Flask-Vue-CRUD DevOps Portfolio

## Deskripsi

Project ini adalah contoh aplikasi CRUD sederhana dengan backend Flask dan frontend Vue, yang di-deploy menggunakan best practice DevOps stack modern: Docker, Nginx (SSL), Prometheus, Grafana, Jenkins, dan Terraform. Cocok untuk showcase portfolio DevOps engineer.

---

## Arsitektur

- **Frontend:** Vue.js (SPA)
- **Backend:** Flask (REST API)
- **Reverse Proxy:** Nginx (SSL/TLS, routing /api ke backend)
- **Monitoring:** Prometheus (scrape metrics Flask), Grafana (dashboard)
- **CI/CD:** Jenkins (pipeline build & deploy)
- **Orkestrasi:** Docker Compose (untuk dev lokal), Terraform (provisioning Docker resource)

```
[User] ⇄ [Nginx SSL] ⇄ [Vue Frontend]
                  ⇄ [Flask API] ⇄ [Prometheus] ⇄ [Grafana]
```

---

## Fitur DevOps

- **Dockerized**: Semua service berjalan di container
- **Reverse Proxy + SSL**: Nginx dengan self-signed certificate
- **Monitoring**: Prometheus scrape metrics Flask, visualisasi di Grafana
- **CI/CD**: Jenkinsfile untuk pipeline build & deploy otomatis
- **Infrastructure as Code**: Terraform untuk provisioning stack
- **Best Practice**: Isolasi network, environment variable, port mapping, modular config

---

## Cara Setup Lokal

1. **Clone repo & build image**
   ```sh
   docker build -t flask-vue-crud-server:latest ./flask-vue-crud/server
   docker build -t flask-vue-crud-client:latest ./flask-vue-crud/client
   ```
2. **Generate SSL certificate** (lihat instruksi di dokumentasi Nginx)
3. **Jalankan stack**
   ```sh
   docker-compose up --build -d
   ```
4. **Akses aplikasi**
   - Frontend: https://localhost
   - Backend API: https://localhost/api
   - Prometheus: http://localhost:9090
   - Grafana: http://localhost:3000
   - Jenkins: http://localhost:8080

---

## Highlight Portfolio

- **End-to-end DevOps pipeline**: Build, test, deploy, monitoring, SSL, reverse proxy
- **Multi-tool orchestration**: Compose & Terraform
- **Production-like setup**: Semua best practice DevOps modern
- **Siap untuk demo interview atau showcase**

---
