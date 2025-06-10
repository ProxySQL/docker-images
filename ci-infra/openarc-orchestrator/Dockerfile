#FROM debian:bullseye
FROM ubuntu:22.04

EXPOSE 3000

#RUN apt update && \
#    apt -y install wget && \
#    wget https://github.com/github/orchestrator/releases/download/v3.2.6/orchestrator_3.2.6_arm64.deb && \
#    apt -y install ./orchestrator_3.2.6_arm64.deb && mkdir /var/lib/orchestrator && \
#    rm -rf /var/lib/apt/lists/*

COPY orchestrator_*_*.deb .

RUN apt update && \
    apt -y full-upgrade && \
    apt -y install ./orchestrator_*_$(dpkg --print-architecture).deb && \
    mkdir /var/lib/orchestrator && \
    rm ./orchestrator_*.deb && \
    rm -rf /var/lib/apt/lists/*

CMD ["/bin/sh", "-c", "/usr/local/orchestrator/orchestrator http 2>&1 | tee /var/log/orchestrator/error.log"]
