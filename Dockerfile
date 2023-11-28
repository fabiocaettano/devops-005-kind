FROM golang:1.19 as base
RUN apt update
WORKDIR /app
COPY go.mod ./
COPY . .
RUN go build -o server ./cmd/server
EXPOSE 8080
CMD ["./server"]
