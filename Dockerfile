FROM ubuntu:26.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates curl bash \
  && rm -rf /var/lib/apt/lists/*

# gh コマンドのインストール
RUN (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && sudo mkdir -p -m 755 /etc/apt/sources.list.d \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
&& sudo apt install gh -y

WORKDIR /root

# elan のインストール
RUN curl https://elan.lean-lang.org/elan-init.sh -sSf | sh -s -- -y --default-toolchain none

# elan のパスを通す
ENV PATH="/root/.elan/bin:${PATH}"

ENTRYPOINT ["lake", "exe", "action"]