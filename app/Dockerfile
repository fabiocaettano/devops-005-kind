FROM golang:1.19 as base
RUN apt update
WORKDIR /app
RUN go mod init github.com/fabiocaettano/servergo
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o server ./cmd/server
#CMD ["tail","-f","/dev/null"]

FROM scratch as binary
WORKDIR /app
COPY --from=base /app/server .
EXPOSE 8080
CMD ["./server"]



