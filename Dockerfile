FROM golang:1.9.0

RUN go version

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apt-get install -y build-essential nodejs
RUN apt-get install -y sqlite3 libsqlite3-dev
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
RUN wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add -
RUN apt-get install -y postgresql postgresql-contrib libpq-dev
RUN apt-get install -y -q mysql-client
RUN apt-get install -y vim

ENV BP=$GOPATH/src/github.com/gobuffalo/buffalo

RUN go get -u github.com/gobuffalo/buffalo/...
# RUN go get -v -t ./...

# cache yarn packages to an offline mirror so they're faster to load. hopefully.
# COPY ./generators/assets/webpack/templates/package.json.tmpl ./package.json
#RUN sed -i "s/{{.name}}/Buffalo/" package.json
#RUN yarn install --no-progress

COPY docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh

RUN buffalo version
WORKDIR $GOPATH/src

ENTRYPOINT ["/docker-entrypoint.sh"]


# example: docker run --rm build-gobuffalo -v "$PWD":"/go/src/aqtrain" aqtrain -o bin/heroku
