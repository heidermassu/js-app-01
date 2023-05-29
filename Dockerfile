FROM node:20.2.0 AS build-env
COPY . /src
WORKDIR /src
RUN npm ci
RUN npm run build --if-present

FROM gcr.io/distroless/nodejs20-debian11
COPY --from=build-env /src /src
WORKDIR /src
CMD ["index.js"]