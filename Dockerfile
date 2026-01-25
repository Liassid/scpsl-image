FROM steamcmd/steamcmd:latest

ARG BRANCH=public

USER root

RUN apt-get update && apt-get install -y libicu74 && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 server && useradd -u 1000 -g 1000 -m -s /bin/bash server

RUN mkdir -p "/home/server/.config/SCP Secret Laboratory" && chown -R server:server /home/server/.config

ENV HOME=/home/server

USER server

WORKDIR /home/server

RUN steamcmd +force_install_dir /home/server/scpsl +login anonymous "+app_update 996560 -beta ${BRANCH}" validate +quit

EXPOSE 7777/udp

WORKDIR /home/server/scpsl

ENTRYPOINT ["./LocalAdmin", "7777", "--acceptEULA", "--useDefault", "--noTerminalTitle"]
