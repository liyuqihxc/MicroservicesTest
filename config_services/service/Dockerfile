ARG VERSION=1.6.1

ARG PORTAL_PORT=8070
ARG CONFIG_PORT=8080
ARG ADMIN_PORT=8090


FROM maven:alpine as builder

ARG VERSION

ARG PORTAL_PORT
ARG CONFIG_PORT
ARG ADMIN_PORT

WORKDIR /apollo

RUN wget -O- "https://github.com/ctripcorp/apollo/archive/v${VERSION}.tar.gz" | tar -zx && \
    sed -e "s/^dev_meta.*/dev_meta=http:\/\/localhost:${DEV_CONFIG_PORT}/" \
        -e "s/^fat_meta.*/fat_meta=http:\/\/localhost:${FAT_CONFIG_PORT}/" \
        -e "s/^uat_meta.*/uat_meta=http:\/\/localhost:${UAT_CONFIG_PORT}/" \
        -e "s/^pro_meta.*/pro_meta=http:\/\/localhost:${PRO_CONFIG_PORT}/" -i apollo-${VERSION}/scripts/build.sh && \
    bash apollo-${VERSION}/scripts/build.sh && \
    mkdir apollo-admin apollo-config apollo-portal && \
    unzip apollo-${VERSION}/apollo-adminservice/target/apollo-adminservice-${VERSION}-github.zip -d apollo-admin && \
    unzip apollo-${VERSION}/apollo-configservice/target/apollo-configservice-${VERSION}-github.zip -d apollo-config && \
    unzip apollo-${VERSION}/apollo-portal/target/apollo-portal-${VERSION}-github.zip -d apollo-portal && \
    rm -r apollo-${VERSION}


FROM openjdk:8-jre-alpine

ARG VERSION
ARG PORTAL_PORT
ARG CONFIG_PORT
ARG ADMIN_PORT

COPY --from=builder /apollo /apollo

WORKDIR /apollo

COPY healthcheck.sh ./
COPY apollo.sh ./

RUN sed -e "s/%%APOLLO_VERSION%%/${VERSION}/g" -i apollo.sh && \
    chmod +x healthcheck.sh apollo.sh

HEALTHCHECK --interval=5m --timeout=3s CMD bash ./healthcheck.sh


EXPOSE ${PORTAL_PORT} \
    ${ADMIN_PORT} \
    ${CONFIG_PORT}

ENTRYPOINT [ "bash", "./apollo.sh" ]
