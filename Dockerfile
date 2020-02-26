FROM hyperized/scratch:latest as trigger
# Used to trigger Docker hubs auto build, which it wont do on the official images

FROM php:7.4-cli-alpine as builder

COPY --from=hyperized/prestissimo:latest /usr/bin/composer /usr/bin/composer
WORKDIR /opt/phpstan
RUN composer require phpstan/phpstan

FROM php:7.4-cli-alpine

LABEL maintainer="Gerben Geijteman <gerben@hyperized.net>"
LABEL description="A PHP7.4 CLI based phpstan/phpstan image"

COPY --from=builder /opt/phpstan /opt/phpstan
RUN chmod +x /opt/phpstan/vendor/bin/phpstan

ENTRYPOINT ["/opt/phpstan/vendor/bin/phpstan"]
CMD ["-h"]

