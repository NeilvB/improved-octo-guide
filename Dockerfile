FROM node

COPY ./script.sh /script.sh

CMD ["sh", "-u", "./script.sh"]