FROM alpine:3.21

COPY .build_date /etc/.build_date

RUN apk --no-cache add openssh

VOLUME /ssh

EXPOSE 22

ADD start.sh /start.sh
RUN chmod u+x /start.sh
CMD /start.sh
