<img src="https://raw.githubusercontent.com/ctripcorp/apollo/master/doc/images/logo/logo-simple.png" alt="apollo-logo" width="60%">

# Apollo Config Services

## MariaDB

``` bash
$ docker build -t liyuqihxc/apollo-mariadb:1.6.1-10.5 .
$ docker run -it -v $(pwd):/var/lib/mysql -p 13306:3306/tcp -e MYSQL_ROOT_PASSWORD=root liyuqihxc/apollo-mariadb:1.6.1-10.5
```

### Apollo Services

```bash
$ docker build -t liyuqihxc/apollo:1.6.1-openjdk-8-jre-alpine
```
