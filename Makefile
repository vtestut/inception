NAME		= inception
SRCS		= ./srcs
HOST_URL	= vtestut.42.fr

all: $(NAME)

$(NAME): up

up:
	@mkdir -p /home/vtestut/data/database
	@mkdir -p /home/vtestut/data/wordpress_files
	@sudo sh -c "echo '127.0.0.1 $(HOST_URL)' >> /etc/hosts"
	@docker compose -p $(NAME) -f ./srcs/docker-compose.yml up --build

down:
	@docker compose -p $(NAME) down
	@echo "\nContainers stopped"

check:
	@docker ps -a
	@docker volume ls
	@docker images
	@docker network ls

clean:
	@docker ps -qa | xargs -r docker stop
	@docker ps -qa | xargs -r docker rm
	@docker images -qa | xargs -r docker rmi -f
	@docker volume ls -q | xargs -r docker volume rm
	@docker network ls --filter "name=inception_all" -q | xargs -r docker network rm
	@echo "\nclean complete ! containers, images, volumes, and networks removed."

fclean: clean
	@sudo rm -rf /home/vtestut/data
	@sudo sed -i "/127.0.0.1 $(HOST_URL)/d" /etc/hosts
	@echo "\nfclean complete ! data directory and host entry removed."


re: fclean all

.PHONY: all up down clean fclean re
