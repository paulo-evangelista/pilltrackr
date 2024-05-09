FROM golang:alpine as builder

WORKDIR /app

COPY . .

RUN go mod tidy

RUN CGO_ENABLED=0 GOOS=linux go build -o server

FROM alpine:latest  
WORKDIR /root/

COPY --from=builder /app/server .

EXPOSE 8081

ENTRYPOINT ["./server"]
