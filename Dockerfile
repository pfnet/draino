FROM golang:1.24-alpine AS build

RUN apk update && apk add git && apk add curl

WORKDIR /go/src/github.com/planetlabs/draino

COPY go.* .
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o /draino ./cmd/draino

FROM alpine:3.21

RUN apk update && apk add ca-certificates
RUN addgroup -g 65532 -S nonroot && adduser -u 65532 -S nonroot -G nonroot
USER 65532
COPY --from=build /draino /draino
