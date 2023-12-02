FROM golang:1.19 as base
RUN apt update
WORKDIR /app
COPY . .

FROM alpine:3.16 as binary
COPY --from=base /app .
EXPOSE 8080
CMD ["./server"]
