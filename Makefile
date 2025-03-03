IMG_REG ?= ghcr.io/pfnet/draino
IMG_TAG ?= $(shell git describe --always --tags --dirty)

.PHONY: build
build:
	go build -o draino ./cmd/draino

.PHONY: test
test:
	go vet ./...
	go test -v ./...

.PHONY: build-image
build-image:
	docker build --progress plain -t $(IMG_REG):$(IMG_TAG) .

.PHONY: push-image
push-image: build-image
	docker tag $(IMG_REG):$(IMG_TAG) $(IMG_REG):latest
	docker push $(IMG_REG):$(IMG_TAG)
	docker push $(IMG_REG):latest
