FROM openjdk:8-jre-alpine

ARG VERSION="1.4.0"

ENV SERVER_PORT 8090

WORKDIR /apollo-adminservice

RUN echo "http://mirrors.aliyun.com/alpine/v3.8/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.8/community" >> /etc/apk/repositories \
    && apk update upgrade \
    && apk add --no-cache curl unzip \
    && curl -L https://github.com/ctripcorp/apollo/releases/download/v${VERSION}/apollo-adminservice-${VERSION}-github.zip -o apollo-adminservice-github.zip \
    && unzip -q apollo-adminservice-github.zip \
    && rm -rf apollo-adminservice-github.zip \
    && apk del curl unzip \
    && sed -i '$d' scripts/startup.sh \
    && chmod +x scripts/startup.sh \
    && echo "tail -f /dev/null" >> scripts/startup.sh

EXPOSE $SERVER_PORT

ENTRYPOINT ["scripts/startup.sh"]
