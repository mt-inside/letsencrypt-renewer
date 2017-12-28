build:
	docker build . -t letsencrypt-renewer

run:
	docker run --name letsencrypt-renewer --rm --publish 80:80 --publish 443:443 --volume /var/www/ssl:/etc/letsencrypt --network system_service_net letsencrypt-renewer

.PHONY: build run
