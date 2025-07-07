# Jenkins Lokal

1. Build image Jenkins:
   docker build -t jenkins-local .

2. Jalankan Jenkins:
   docker run -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock --name jenkins jenkins-local

3. Buka http://localhost:8080 untuk setup awal Jenkins.

4. Buat pipeline untuk build & deploy flask-vue-crud. 