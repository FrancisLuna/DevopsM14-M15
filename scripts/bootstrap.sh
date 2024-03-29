# !/bin/bash

##### DOCKER ####
# Add Docker's official GPG key:
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

# Install the Docker packages latest
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Agregar el usuario vagrant al grupo docker para ejecutar comandos sin sudo
sudo usermod -aG docker $USER
sudo usermod -aG docker vagrant

# Verify that the Docker Engine installation is successful by running the hello-world image.
sudo docker run hello-world

#DOCKER COMPOSE
sudo apt-get install -y docker-compose-plugin
docker compose version

#### JENKINMS ####
# Install prerequisites: JAVA
sudo apt install -y openjdk-11-jdk

# Install jenkins
# Añade el repositorio de Jenkins y su clave GPG
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Actualiza e instala Jenkins
sudo apt-get update
sudo apt-get install -y jenkins

# Inicia el servicio de Jenkins y habilita el inicio automático
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Agregar el usuario jenkins al grupo docker para ejecutar comandos sin sudo
sudo usermod -aG docker jenkins
