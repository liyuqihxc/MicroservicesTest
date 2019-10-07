FROM maven:alpine

ARG VERSION=1.4.0
ARG APOLLO_URL=https://github.com/ctripcorp/apollo/archive/v${VERSION}.tar.gz

ENV CONFIG_DB_URL=jdbc:mysql://loaclhost:3306/ApolloConfigDB?characterEncoding=utf8
ENV CONFIG_DB_USERNAME=root
ENV CONFIG_DB_PASSWORD=toor

ENV PORTAL_DB_URL=jdbc:mysql://loaclhost:3306/ApolloPortalDB?characterEncoding=utf8
ENV PORTAL_DB_USERNAME=root
ENV PORTAL_DB_PASSWORD=toor

ENV PORTAL_PORT=8070 \
    DEV_ADMIN_PORT=8090 \
    FAT_ADMIN_PORT=8091 \
    UAT_ADMIN_PORT=8092 \
    PRO_ADMIN_PORT=8093 \
    DEV_CONFIG_PORT=8080 \
    FAT_CONFIG_PORT=8081 \
    UAT_CONFIG_PORT=8082 \
    PRO_CONFIG_PORT=8083

WORKDIR /apollo

COPY healthcheck.sh ./
COPY apollo.sh ./

RUN wget -O- "${APOLLO_URL}" | tar -zx && \
    sed -e "s/^apollo_config_db_url.*/apollo_config_db_url=${CONFIG_DB_URL}" \
        -e "s/^apollo_config_db_username.*/apollo_config_db_username=${CONFIG_DB_USERNAME}" \
        -e "s/^apollo_config_db_password.*/apollo_config_db_password=${CONFIG_DB_PASSWORD}" \
        -e "s/^apollo_portal_db_url.*/apollo_portal_db_url=${PORTAL_DB_URL}" \
        -e "s/^apollo_portal_db_username.*/apollo_portal_db_username=${PORTAL_DB_USERNAME}" \
        -e "s/^apollo_portal_db_password.*/apollo_portal_db_password=${PORTAL_DB_PASSWORD}" \
        -e "s/^dev_meta.*/dev_meta=http:\/\/localhost:${DEV_CONFIG_PORT}/" \
        -e "s/^fat_meta.*/fat_meta=http:\/\/localhost:${FAT_CONFIG_PORT}/" \
        -e "s/^uat_meta.*/uat_meta=http:\/\/localhost:${UAT_CONFIG_PORT}/" \
        -e "s/^pro_meta.*/pro_meta=http:\/\/localhost:${PRO_CONFIG_PORT}/" -i apollo-${VERSION}/scripts/build.sh && \
    bash apollo-${VERSION}/scripts/build.sh && rm -rf /root/.m2 && \
    mkdir /apollo-admin/dev \
        /apollo-admin/fat \
        /apollo-admin/uat \
        /apollo-admin/pro \
        /apollo-config/dev \
        /apollo-config/fat \
        /apollo-config/uat \
        /apollo-config/pro \
        /apollo-portal -p && \
    unzip apollo-${VERSION}/apollo-adminservice/target/apollo-adminservice-${VERSION}-github.zip -d /apollo-admin/dev && \
    unzip apollo-${VERSION}/apollo-adminservice/target/apollo-adminservice-${VERSION}-github.zip -d /apollo-admin/fat && \
    unzip apollo-${VERSION}/apollo-adminservice/target/apollo-adminservice-${VERSION}-github.zip -d /apollo-admin/uat && \
    unzip apollo-${VERSION}/apollo-adminservice/target/apollo-adminservice-${VERSION}-github.zip -d /apollo-admin/pro && \
    unzip apollo-${VERSION}/apollo-configservice/target/apollo-configservice-${VERSION}-github.zip -d /apollo-config/dev && \
    unzip apollo-${VERSION}/apollo-configservice/target/apollo-configservice-${VERSION}-github.zip -d /apollo-config/fat && \
    unzip apollo-${VERSION}/apollo-configservice/target/apollo-configservice-${VERSION}-github.zip -d /apollo-config/uat && \
    unzip apollo-${VERSION}/apollo-configservice/target/apollo-configservice-${VERSION}-github.zip -d /apollo-config/pro && \
    unzip apollo-${VERSION}/apollo-portal/target/apollo-portal-${VERSION}-github.zip -d /apollo-portal && \
    rm -rf apollo-${VERSION} && \
    chmod +x /usr/local/bin/healthcheck /usr/local/bin/apollo

# HEALTHCHECK --interval=5m --timeout=3s CMD bash /usr/local/bin/healthcheck

EXPOSE 8070 8080 8081 8082 8083 8090 8091 8092 8093

ENTRYPOINT [ "bash", "/usr/local/bin/apollo" ]
