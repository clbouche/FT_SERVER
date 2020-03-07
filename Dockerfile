# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: clbouche <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/04 18:23:03 by clbouche          #+#    #+#              #
#    Updated: 2020/03/07 13:55:36 by clbouche         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#IMAGE
FROM debian:buster

#container owner
MAINTAINER clbouche@student.42.fr

# update the software repository
RUN apt-get update && apt-get install -y procps && apt-get install -y nano

#install EngineX
RUN apt-get -y install nginx

#install PHPmyAdmin
RUN apt-get -y install php7.3-fpm php7.3-mysql php7.3-common php7.3-gd php7.3-json php7.3-cli php7.3-curl php7.3-xml php7.3-zip php7.3-mbstring

#install mariaDB (database)
RUN apt-get -y install mariadb-server

COPY ./srcs/init.sh ./
COPY ./srcs/nginx.conf ./tmp/
#COPY ./srcs/... ./tmp/

EXPOSE 80 443 

CMD bash init.sh 
