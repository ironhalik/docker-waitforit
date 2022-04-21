FROM alpine:3.15

RUN wget https://github.com/maxcnunes/waitforit/releases/download/v2.4.1/waitforit-linux_amd64 -qO /usr/local/bin/waitforit &&\
    sha256sum /usr/local/bin/waitforit | grep -q 9568b783a28a14dfc4e9278dc123348bcb3d0c941a37a4057e6ed37a39a1db11 &&\
    chmod +x /usr/local/bin/waitforit

USER nobody

ENTRYPOINT ["/usr/local/bin/waitforit"]