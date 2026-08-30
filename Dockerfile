FROM artifact.probo.inc/probo/probo:v0.271.0@sha256:2cc4016687e1b44410e2316821dc4c5e650981dc703ff157d9351b4d07887fc7

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y openssl \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /data \
    && chown probo:probo /data

COPY --chmod=0755 railway-entrypoint.sh /usr/local/bin/railway-entrypoint.sh
COPY --chown=probo:probo starter-kits/probo-iso27001 /opt/probo-starter-kits/probo-iso27001

ENTRYPOINT ["/usr/local/bin/railway-entrypoint.sh"]
