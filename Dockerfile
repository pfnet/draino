FROM golang:1.26 AS build

WORKDIR /work

COPY go.* .
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o /draino ./cmd/draino

FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /draino /draino
