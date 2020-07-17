.PHONY: php7.2 php7.3 php7.4

php7.2:
	docker build --pull -t vision-testing-php:7.2 php-7.2
php7.3:
	docker build --pull -t vision-testing-php:7.3 php-7.3
php7.4:
	docker build --pull -t vision-testing-php:7.4 php-7.4
