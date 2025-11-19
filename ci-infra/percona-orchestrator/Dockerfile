FROM debian:bookworm

EXPOSE 3000


#RUN apt update && \
#    apt -y install wget && \
#    wget https://github.com/github/orchestrator/releases/download/v3.2.6/orchestrator_3.2.6_amd64.deb && \
#    apt -y install ./orchestrator_3.2.6_amd64.deb && mkdir /var/lib/orchestrator && \
#    rm -rf /var/lib/apt/lists/*

RUN apt update && \
    apt install -y jq

COPY ./orchestrator_*_*.deb ./

RUN apt install -y ./orchestrator_*_$(dpkg --print-architecture).deb && \
    mkdir /var/lib/orchestrator && \
    rm -rf /var/lib/apt/lists/* && \
    rm ./orchestrator_*.deb

CMD ["/bin/sh", "-c", "/usr/local/orchestrator/orchestrator http 2>&1 | tee /var/log/orchestrator/error.log"]
