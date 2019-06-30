# Selete the base image
FROM golang:latest as GOLANG-BUILDER

# Copy in out source file
COPY /src/* /src/

WORKDIR /src

RUN go mod tidy

# Compile the code
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /hwassign/main main.go

FROM alpine

COPY --from=GOLANG-BUILDER /hwassign/main /app/main

