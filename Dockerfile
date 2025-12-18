FROM Ubuntu:26.04

USER guest
WORKDIR /home/guest

# elan のインストール
RUN curl https://elan.lean-lang.org/elan-init.sh -sSf | sh -s -- -y --default-toolchain none

# elan のパスを通す
ENV PATH="/home/guest/.elan/bin:${PATH}"

ENTRYPOINT ["lean", "--run", "Action.lean"]