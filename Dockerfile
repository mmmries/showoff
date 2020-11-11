# The version of Alpine to use for the final image
# This should match the version of Alpine that the `builder` image uses
ARG ALPINE_VERSION=3.12.1

FROM hexpm/elixir:1.11.2-erlang-23.1.2-alpine-${ALPINE_VERSION} as build

ENV MIX_ENV=prod

RUN mkdir /app
WORKDIR /app

# This step installs all the build tools we'll need
RUN apk add --update nodejs npm && \
  mix local.rebar --force && \
  mix local.hex --force

COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

COPY assets assets
RUN cd assets && npm install --quiet --no-progress && npm run deploy

COPY config config
COPY lib lib
COPY priv priv
COPY rel rel

RUN mix do compile, phx.digest

RUN mix release

# From this line onwards, we're in a new image, which will be the image used in production
FROM alpine:${ALPINE_VERSION} as app

RUN apk add --update bash openssl

RUN mkdir /app
WORKDIR /app

COPY --from=build /app/_build/prod/rel/showoff ./
RUN chown -R nobody: /app
USER nobody

ENV HOME=/app
CMD bin/showoff start