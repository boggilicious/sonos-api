FROM node:lts-alpine

WORKDIR /app

COPY . .

RUN yarn install --production

CMD ["yarn", "start"]

EXPOSE 5005
