FROM node:12
COPY nodeapp /nodeapp
WORKDIR /nodeapp
RUN npm install
RUN npm update
CMD ["node", "/nodeapp/app.js"]