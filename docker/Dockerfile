FROM crystallang/crystal:latest

WORKDIR /app

RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libsqlite3-dev \
    libssl-dev \
    libpcre2-dev \
    libevent-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

COPY . .



EXPOSE 3000

CMD ["sh -c shards install && crystal run src/web/server.cr"]