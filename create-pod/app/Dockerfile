FROM golang:1.19 as base
RUN apt update
WORKDIR /app
COPY . .
#RUN CGO_ENABLED=0 GOOS=linux go build -o server ./cmd/web
# CMD ["tail","-f","/dev/null"]

FROM alpine:3.18 as binary
WORKDIR /app
COPY --from=base /app/server .
EXPOSE 8080
CMD ["./server"]