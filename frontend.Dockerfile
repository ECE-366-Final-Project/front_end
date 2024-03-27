# Flutter dockerfile
# Evan Rosenfeld, James Ryan

#stage0 deps
FROM debian:latest AS deps

RUN apt-get update
# Install necessary dependencies for running Flutter on web
RUN apt-get install -y libxi6 libgtk-3-0 libxrender1 libxtst6 libxslt1.1 curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set Flutter path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor
RUN flutter doctor -v
RUN flutter channel master
RUN flutter upgrade

#stage1 build
FROM deps AS build
# Copy files to container and build
ADD ./frontend /app
WORKDIR /app/

RUN flutter pub upgrade
RUN flutter config --enable-web

RUN flutter build web --release --web-renderer html

#stage2 host
FROM nginx:1.25.4-alpine AS deploy

COPY --from=build /app/build/web /usr/share/nginx/html
#fix nginx to host on nonstandard port
#EXPOSE 12345
EXPOSE 80
