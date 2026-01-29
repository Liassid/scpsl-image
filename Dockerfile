FROM steamcmd/steamcmd:latest

ARG BRANCH=public

USER root

RUN apt-get update && apt-get install -y libicu74 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p "/home/ubuntu/.config/SCP Secret Laboratory" && chown -R ubuntu:ubuntu /home/ubuntu/.config

ENV HOME=/home/ubuntu
ENV PORT=7777

USER ubuntu

WORKDIR /home/ubuntu

RUN steamcmd +force_install_dir /home/ubuntu/scpsl +login anonymous "+app_update 996560 -beta ${BRANCH}" validate +quit

EXPOSE ${PORT}/udp

WORKDIR /home/ubuntu/scpsl

ENTRYPOINT exec ./LocalAdmin $PORT --acceptEULA --useDefault --noTerminalTitle
