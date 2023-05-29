FROM node:20.2.0 AS build-env
COPY . /src
WORKDIR /src
RUN npm ci
RUN npm run build --if-present
RUN npm test

FROM gcr.io/distroless/nodejs20-debian11
COPY --from=build-env /src /src
WORKDIR /src
CMD ["server.js", "tail", "-f", "/dev/null"]
