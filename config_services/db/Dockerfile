ARG VERSION=1.6.1

FROM mariadb:10.5

ARG VERSION

RUN cd /docker-entrypoint-initdb.d && \
    apt-get update && \
    apt-get install -y curl && \
    curl -L "https://github.com/ctripcorp/apollo/raw/v${VERSION}/scripts/sql/apolloconfigdb.sql" -o apolloconfigdb.sql && \
    curl -L "https://github.com/ctripcorp/apollo/raw/v${VERSION}/scripts/sql/apolloportaldb.sql" -o apolloportaldb.sql && \
    apt-get purge -y curl && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY apollo.cnf /etc/mysql/conf.d/
