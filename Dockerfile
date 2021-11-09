FROM swift:5.3
WORKDIR /build
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && apt-get -q update && \
    apt-get -q install -y libssl-dev libssh2-1 libssh2-1-dev libcurl4-openssl-dev

# Copy entire repo into container
COPY . .
ARG BOT_ID
ENV ENV_BOT_ID=$BOT_ID

RUN echo ".build/release/MBWatcher --bot-id $BOT_ID" > run.sh

# Compile with optimizations
RUN export LDFLAGS="-L/usr/lib/x86_64-linux-gnu" && \
    export CPPFLAGS="-I/usr/include" && \
    export PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig" && \
    swift build \
    --enable-test-discovery \
    -c release \
    -Xswiftc -g

ENTRYPOINT ["/bin/bash", "run.sh"]
