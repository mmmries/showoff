# Showoff

An Elixir application for playing around with SVG drawing and sharing your images with others.

## Running the App

```
git clone <this_repo>
cd showoff
mix do deps.get, compile, phoenix.server
```

## Building For Production

The included `Dockerfile` is used to package this application up into a Docker image. To execute the build steps run a command line:

```
docker build -t hqmq/showoff:0.0.3 .
```

Then move that image to a production box where you want to run the application and start the image with a command like:

```
docker run -d --name showoff -p 8080:4000 hqmq/showoff:0.0.3
```

Then the main OS can run nginx and can reverse proxy to port 8080 for whatever requests should go to this server. The nginx config should allow the proxied connection to be upgraded to a websocket:

```
upstream showoff {
  server 127.0.0.1:8000 fail_timeout=6s;
}

server {
  server_name showoff.riesd.com;
  listen 80;
  root /home/ec2-user/www/showoff;
  try_files $uri/index.html $uri.html $uri @app;
  location @app {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_pass http://showoff;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
  }
}
```
