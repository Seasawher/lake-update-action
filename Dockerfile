FROM ubuntu:26.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates curl bash \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /root

# elan のインストール
RUN curl https://elan.lean-lang.org/elan-init.sh -sSf | sh -s -- -y --default-toolchain none

# elan のパスを通す
ENV PATH="/root/.elan/bin:${PATH}"

ENTRYPOINT ["lake", "exe", "action"]