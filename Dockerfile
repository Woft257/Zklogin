FROM mysten/zklogin:prover-stable

USER root

RUN apt-get update \
  && apt-get install -y --no-install-recommends python3 python3-pip ca-certificates curl \
  && pip3 install --no-cache-dir gdown \
  && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

