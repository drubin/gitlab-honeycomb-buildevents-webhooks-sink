# syntax=docker/dockerfile:1

##
## Build
##
FROM golang:1.16-alpine AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=1 GOOS=linux go build -o /gitlab-honeycomb-buildevents-webhook


FROM alpine

WORKDIR /

COPY --from=build /gitlab-honeycomb-buildevents-webhook /usr/local/bin/gitlab-honeycomb-buildevents-webhook

EXPOSE 8080
