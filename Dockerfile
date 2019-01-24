FROM varunbatrait/svim

USER root

RUN apk --no-cache add autoconf automake gcc g++ clang make php7

RUN cd $UHOME/ && wget "https://github.com/shawncplus/phpcomplete.vim/raw/master/misc/ctags-5.8_better_php_parser.tar.gz" -O ctags-5.8_better_php_parser.tar.gz \
    && tar xvf ctags-5.8_better_php_parser.tar.gz \
    && cd ctags \
    && autoreconf -fi \
    && ./configure \
    && make && make install

RUN apk --no-cache add php-openssl php-json php-phar php-mbstring php-iconv php-session php-pdo php-pcntl php-tokenizer

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

RUN rm -rf \
    /var/cache/* \
    /var/log/* \
    /var/tmp/* \
    && mkdir /var/cache/apk


USER $UNAME

RUN cd $UHOME/bundle/ \
    && git clone --depth 1 https://github.com/Shougo/unite.vim.git \
    && git clone --depth 1 https://github.com/lvht/phpcd.vim.git \
    && cd phpcd.vim && composer install

COPY run /usr/local/bin/
