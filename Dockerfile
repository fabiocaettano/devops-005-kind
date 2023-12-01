FROM golang:1.19 as base
RUN apt update
WORKDIR /app
COPY go.mod ./
#COPY go.sum ./
COPY . .
RUN go build -o server cmd/server/server.go
EXPOSE 8080
#CMD ["tail","-f","/dev/null"]
CMD ["./serve"]
