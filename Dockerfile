FROM golang:1.12.4-stretch AS BUILD

#now build source code
RUN mkdir /sample
WORKDIR /sample

ADD go.mod .
ADD go.sum .
RUN go mod download

ADD main.go .
RUN go test -v

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o /go/bin/sample .

CMD [ "/go/bin/sample" ]
