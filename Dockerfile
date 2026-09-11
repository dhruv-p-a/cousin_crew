# Stage 1: Build the Flutter web app
FROM debian:latest AS build-env

RUN apt-get update && apt-get install -y curl git wget unzip xz-utils libglu1-mesa python3
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor
RUN flutter config --enable-web

COPY . /app
WORKDIR /app
RUN flutter pub get
RUN flutter build web --release

# Stage 2: Serve the app using Nginx
FROM nginx:alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
