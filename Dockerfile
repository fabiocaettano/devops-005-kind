FROM golang:1.19 as base
RUN apt update
WORKDIR /app
COPY go.mod ./
COPY . .
RUN go build -o serve cmd/server/server.go
EXPOSE 8080
#CMD ["tail","-f","/dev/null"]
CMD ["./serve"]
