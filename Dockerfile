FROM ubuntu:26.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates curl bash gnupg \
  && rm -rf /var/lib/apt/lists/*

# gh コマンドのインストール
RUN mkdir -p /etc/apt/keyrings \
  && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | gpg --dearmor -o /etc/apt/keyrings/githubcli.gpg \
  && chmod go+r /etc/apt/keyrings/githubcli.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli.gpg] https://cli.github.com/packages stable main" \
    > /etc/apt/sources.list.d/github-cli.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends gh \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /root

# elan のインストール
RUN curl https://elan.lean-lang.org/elan-init.sh -sSf | sh -s -- -y --default-toolchain none

# elan のパスを通す
ENV PATH="/root/.elan/bin:${PATH}"

ENTRYPOINT ["lake", "exe", "action"]