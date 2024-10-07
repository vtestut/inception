# inception
setting up a small Docker-based infrastructure with multiple services on a virtual machine - July 2024

Voici un exemple de README pour ton projet **Inception**, inspiré des autres README que tu m'as fournis :

---

# Inception

Welcome to my `Inception` project!  
This project is part of the Ecole 42 curriculum and introduces containerization technologies, using Docker and Docker Compose to build a small infrastructure of multiple interconnected services.

## Project Overview

The `Inception` project focuses on understanding how Docker works, how to create multiple services in isolated containers, and how to manage them using Docker Compose. Key elements include:

- **Containers and Images:**
  - Build individual Dockerfiles for each service.
  - Create and manage Docker containers for services such as NGINX, MariaDB, and WordPress.

- **Networking:**
  - Implement a custom Docker network to allow services to communicate securely.

- **Volumes:**
  - Use Docker volumes to persist data for WordPress and MariaDB services.

- **SSL/TLS:**
  - Configure NGINX with SSL/TLS certificates for secure access via HTTPS.

## Services

- **MariaDB:** Database service, stores data for the WordPress application.
- **WordPress:** CMS service, handles the user interface and content management.
- **NGINX:** Web server that handles HTTPS requests and redirects to WordPress.

## Directory Structure

- **`/srcs/`:** Contains the service-specific files such as Dockerfiles, configuration files, and scripts.
- **`/srcs/docker-compose.yml`:** The main Docker Compose configuration file that sets up the entire infrastructure.

  Example:
  ```yaml
  services:
    mariadb:
      build: ./requirements/mariadb/
      volumes:
        - database:/var/lib/mysql/
      networks:
        - all
      env_file:
        - .env

    wordpress:
      build: ./requirements/wordpress/
      volumes:
        - wordpress_files:/var/www/inception/
      networks:
        - all
      env_file:
        - .env
      depends_on:
        - mariadb

    nginx:
      build: ./requirements/nginx/
      ports:
        - '443:443'
      networks:
        - all
      volumes:
        - wordpress_files:/var/www/inception/
      depends_on:
        - wordpress
  ```

## How to Use

1. Clone the repository.
2. Build and start the services using the Makefile:
   - `make up`: Starts the Docker services.
   - `make down`: Stops the services.
   - `make fclean`: Cleans up all containers, volumes, and images.
3. Access WordPress via the HTTPS endpoint.

## Makefile Overview

- **`make up`:** Builds and starts all services.
- **`make down`:** Stops all services.
- **`make fclean`:** Cleans up all containers, images, and volumes, and removes host entries.

## Notes

- Ensure Docker is installed and running on your system.
- SSL/TLS is set up using self-signed certificates for local testing.

---

Feel free to adjust or expand the README according to your preferences!
