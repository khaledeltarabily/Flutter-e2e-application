build:
	docker build . -t flutter_docker
up:
	docker run -i -p 8080:5000 -td flutter_docker