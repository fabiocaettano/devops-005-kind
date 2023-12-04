FROM golang:1.19 as base
RUN apt update
WORKDIR /app
COPY . .
RUN go mod init fac74.com/servergo
RUN CGO_ENABLED=0 GOOS=linux go build -o server ./cmd/web
# CMD ["tail","-f","/dev/null"]

FROM alpine:3.18.5 as binary
COPY --from=base /app/server .
CMD ["./server"]



