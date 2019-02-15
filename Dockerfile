FROM varunbatrait/svim

USER root

RUN apk --no-cache add autoconf automake gcc g++ clang make php7

RUN cd $UHOME/ && wget "https://github.com/shawncplus/phpcomplete.vim/raw/master/misc/ctags-5.8_better_php_parser.tar.gz" -O ctags-5.8_better_php_parser.tar.gz \
    && tar xvf ctags-5.8_better_php_parser.tar.gz \
    && cd ctags \
    && autoreconf -fi \
    && ./configure \
    && make && make install

RUN apk --no-cache add php-openssl php-json php-phar php-mbstring php-iconv php-session php-pdo php-pcntl php-tokenizer php-curl php-dom php-xml php-xmlwriter

RUN php -r "copy('https://getcomposer.org/download/1.8.4/composer.phar', 'composer.phar');" \
    && php -r "if (hash_file('sha256', 'composer.phar') === '1722826c8fbeaf2d6cdd31c9c9af38694d6383a0f2bf476fe6bbd30939de058a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer.phar'); } echo PHP_EOL;" \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer

RUN rm -rf \
    /var/cache/* \
    /var/log/* \
    /var/tmp/* \
    && mkdir /var/cache/apk


USER $UNAME

RUN cd $UHOME/bundle/ \
    && rm -rf unite.vim && git clone --depth 1 https://github.com/Shougo/unite.vim.git \
    && rm -rf phpactor && git clone --depth 1 https://github.com/phpactor/phpactor.git \
    && cd phpactor && composer install

COPY run /usr/local/bin/
