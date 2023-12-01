FROM golang:1.19 as base
RUN apt update
WORKDIR /app
#COPY go.mod ./
#COPY go.sum ./
RUN go mod init github.com/fabiocaettano74/servergo
COPY . .
#RUN go build -o server cmd/server/server.go ./
RUN GOOS=linux GOARCH=amd64 go build -o server cmd/server/server.go
EXPOSE 8080
CMD ["tail","-f","/dev/null"]
#CMD ["./server"]
