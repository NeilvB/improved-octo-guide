FROM node

COPY ./script.js /script.js

CMD ["node", "./script.js"]