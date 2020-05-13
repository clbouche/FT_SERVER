# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: clbouche <clbouche@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/26 19:38:18 by clbouche          #+#    #+#              #
#    Updated: 2020/05/13 13:54:52 by clbouche         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#IMAGE
FROM debian:buster

#OWNER
MAINTAINER clbouche@student.42.fr

#UPDATE
RUN apt-get update && apt dist-upgrade && apt-get install nano && apt-get install -y wget

#NGINX
RUN apt-get -y install nginx

#SSL
RUN apt-get -y install openssl

#MySQL
RUN apt-get -y install mariadb-server

#PHP
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap

COPY ./srcs/init.sh ./
COPY ./srcs/nginx.conf ./tmp

CMD bash init.sh
