FROM golang:1.20-alpine AS builder

RUN apk add --no-cache git

WORKDIR /go/src/github.com/maxcnunes/waitforit

RUN git clone https://github.com/maxcnunes/waitforit.git . &&\
    git checkout v2.4.1 &&\
    go mod init

RUN go test -v -cover ./...

RUN GOOS=linux GOARCH=${TARGETARCH} go build -ldflags="-extldflags=-static" -o build/waitforit


FROM alpine:3.18 AS dist

COPY --from=builder /go/src/github.com/maxcnunes/waitforit/build/waitforit /bin/waitforit

USER nobody

ENTRYPOINT ["/bin/waitforit"]
