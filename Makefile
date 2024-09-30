up:
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

re:	clean up

clean:	
	rm -rf /home/mvallhon/data/mariadb/*
	rm -rf /home/mvallhon/data/wordpress/*
	docker system prune -a --volumes

.PHONY: up down clean re
