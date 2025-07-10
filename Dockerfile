FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y squid apache2-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create folders
RUN mkdir -p /squid/cache /squid/logs /squid/run && \
    chmod -R 777 /squid

# Add user: strproxy / cocacolaproxy
RUN htpasswd -cb /etc/squid/passwd strproxy cocacolaproxy

COPY squid.conf /etc/squid/squid.conf

EXPOSE 7860

CMD ["squid", "-N", "-f", "/etc/squid/squid.conf"]
