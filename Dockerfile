FROM golang:1.19 as build
WORKDIR /app
COPY . .
# RUN GCO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server
# source: https://crg.eti.br/post/compilacao-estatica-com-golang/
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server -ldflags '-extldflags "-static" -s -w'

FROM scratch
WORKDIR /app
COPY --from=build /app/server .
ENTRYPOINT ["./server"]
