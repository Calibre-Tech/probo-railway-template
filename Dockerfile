ARG PROBO_VERSION=v0.271.0
FROM artifact.probo.inc/probo/probo:${PROBO_VERSION}

USER root

RUN apt-get update \
    && apt-get install --no-install-recommends -y openssl \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /data \
    && chown probo:probo /data

COPY --chmod=0755 railway-entrypoint.sh /usr/local/bin/railway-entrypoint.sh

USER probo

ENTRYPOINT ["/usr/local/bin/railway-entrypoint.sh"]
