FROM hqmq/docker-elixir:1.0.3.1
MAINTAINER Michael Ries <michael@riesd.com>

EXPOSE 4000

ADD . /showoff
WORKDIR /showoff
RUN MIX_ENV=prod mix do local.hex --force, local.rebar --force, deps.get, compile, compile.protocols

CMD /showoff/phoenix_start.sh
