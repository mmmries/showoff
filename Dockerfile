FROM hqmq/docker-elixir:1.0.3.1
MAINTAINER Michael Ries <michael@riesd.com>

EXPOSE 4000

ADD . /showoff
WORKDIR /showoff
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN MIX_ENV=prod mix do compile, compile.protocols

CMD /showoff/phoenix_start.sh
