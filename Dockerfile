FROM golang:1.20
WORKDIR /app
COPY . .
CMD ["tail","-f","/dev/null"]