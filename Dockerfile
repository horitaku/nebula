# builder
FROM node:18-alpine as builder
WORKDIR /app
COPY . /app
COPY package.json package-lock.json /app/
RUN npm install

RUN npm run build

# production
FROM gcr.io/distroless/nodejs:18

#ENV HOST=0.0.0.0

EXPOSE 3000:3000
WORKDIR /app
COPY --from=builder /app/.output /app/.output

CMD [".output/server/index.mjs"]