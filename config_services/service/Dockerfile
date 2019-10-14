ARG VERSION=1.4.0

ARG PORTAL_PORT=8070
ARG DEV_ADMIN_PORT=8090
ARG FAT_ADMIN_PORT=8091
ARG UAT_ADMIN_PORT=8092
ARG PRO_ADMIN_PORT=8093
ARG DEV_CONFIG_PORT=8080
ARG FAT_CONFIG_PORT=8081
ARG UAT_CONFIG_PORT=8082
ARG PRO_CONFIG_PORT=8083


FROM maven:alpine as builder

ARG VERSION

ARG PORTAL_PORT
ARG DEV_ADMIN_PORT
ARG FAT_ADMIN_PORT
ARG UAT_ADMIN_PORT
ARG PRO_ADMIN_PORT
ARG DEV_CONFIG_PORT
ARG FAT_CONFIG_PORT
ARG UAT_CONFIG_PORT
ARG PRO_CONFIG_PORT

ARG APOLLO_URL=https://github.com/ctripcorp/apollo/archive/v${VERSION}.tar.gz

WORKDIR /apollo

RUN wget -O- "${APOLLO_URL}" | tar -zx && \
    sed -e "s/^dev_meta.*/dev_meta=http:\/\/localhost:${DEV_CONFIG_PORT}/" \
        -e "s/^fat_meta.*/fat_meta=http:\/\/localhost:${FAT_CONFIG_PORT}/" \
        -e "s/^uat_meta.*/uat_meta=http:\/\/localhost:${UAT_CONFIG_PORT}/" \
        -e "s/^pro_meta.*/pro_meta=http:\/\/localhost:${PRO_CONFIG_PORT}/" -i apollo-${VERSION}/scripts/build.sh && \
    bash apollo-${VERSION}/scripts/build.sh && \
    mkdir apollo-admin/dev \
        apollo-admin/fat \
        apollo-admin/uat \
        apollo-admin/pro \
        apollo-config/dev \
        apollo-config/fat \
        apollo-config/uat \
        apollo-config/pro \
        apollo-portal -p && \
    unzip apollo-${VERSION}/apollo-adminservice/target/apollo-adminservice-${VERSION}-github.zip -d apollo-admin/dev && \
    unzip apollo-${VERSION}/apollo-adminservice/target/apollo-adminservice-${VERSION}-github.zip -d apollo-admin/fat && \
    unzip apollo-${VERSION}/apollo-adminservice/target/apollo-adminservice-${VERSION}-github.zip -d apollo-admin/uat && \
    unzip apollo-${VERSION}/apollo-adminservice/target/apollo-adminservice-${VERSION}-github.zip -d apollo-admin/pro && \
    unzip apollo-${VERSION}/apollo-configservice/target/apollo-configservice-${VERSION}-github.zip -d apollo-config/dev && \
    unzip apollo-${VERSION}/apollo-configservice/target/apollo-configservice-${VERSION}-github.zip -d apollo-config/fat && \
    unzip apollo-${VERSION}/apollo-configservice/target/apollo-configservice-${VERSION}-github.zip -d apollo-config/uat && \
    unzip apollo-${VERSION}/apollo-configservice/target/apollo-configservice-${VERSION}-github.zip -d apollo-config/pro && \
    unzip apollo-${VERSION}/apollo-portal/target/apollo-portal-${VERSION}-github.zip -d apollo-portal && \
    rm -r apollo-${VERSION}


FROM openjdk:8-jre-alpine

ARG PORTAL_PORT
ARG DEV_ADMIN_PORT
ARG FAT_ADMIN_PORT
ARG UAT_ADMIN_PORT
ARG PRO_ADMIN_PORT
ARG DEV_CONFIG_PORT
ARG FAT_CONFIG_PORT
ARG UAT_CONFIG_PORT
ARG PRO_CONFIG_PORT

COPY --from=builder /apollo /apollo

WORKDIR /apollo

COPY healthcheck.sh ./
COPY apollo.sh ./

RUN echo 123 && \
    chmod +x healthcheck.sh apollo.sh

# HEALTHCHECK --interval=5m --timeout=3s CMD bash ./healthcheck

EXPOSE ${PORTAL_PORT} \
    ${DEV_ADMIN_PORT} \
    ${FAT_ADMIN_PORT} \
    ${UAT_ADMIN_PORT} \
    ${PRO_ADMIN_PORT} \
    ${DEV_CONFIG_PORT} \
    ${FAT_CONFIG_PORT} \
    ${UAT_CONFIG_PORT} \
    ${PRO_CONFIG_PORT}

ENTRYPOINT [ "sh", "./apollo.sh" ]
