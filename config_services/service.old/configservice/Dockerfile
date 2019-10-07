FROM openjdk:8-jre-alpine

ARG VERSION="1.4.0"

ENV SERVER_PORT 8080

WORKDIR /apollo-configservice

RUN echo "http://mirrors.aliyun.com/alpine/v3.8/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.8/community" >> /etc/apk/repositories \
    && apk update upgrade \
    && apk add --no-cache curl unzip \
    && curl -L https://github.com/ctripcorp/apollo/releases/download/v${VERSION}/apollo-configservice-${VERSION}-github.zip -o apollo-configservice-github.zip \
    && unzip -q apollo-configservice-github.zip \
    && rm -rf apollo-configservice-github.zip \
    && apk del curl unzip \
    && sed -i '$d' scripts/startup.sh \
    && chmod +x scripts/startup.sh \
    && echo "tail -f /dev/null" >> scripts/startup.sh

EXPOSE $SERVER_PORT

ENTRYPOINT ["scripts/startup.sh"]
