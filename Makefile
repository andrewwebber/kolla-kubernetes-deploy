IMG='kolla-kubernetes-deploy'

all: start

start: docker-image
	@docker run --rm -it --net=host $(IMG)

docker-image:
	@docker build -t $(IMG) .
