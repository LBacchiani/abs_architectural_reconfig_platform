# Use a recent Ubuntu base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    wget \
    unzip \
    build-essential \
    libssl-dev \
    libncurses-dev \
    libwxgtk3.0-gtk3-dev \
    libgl1-mesa-dev \
    libpng-dev \
    libssh-dev \
    unixodbc-dev \
    libxml2-dev \
    libexpat1-dev \
    libz-dev \
    libgmp-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# -------------------------------
# Install Java 24 (via OpenJDK binary)
# -------------------------------
# Install Java 24 from Adoptium (Eclipse Temurin)
ENV JAVA_VERSION=24

RUN mkdir -p /opt/java && \
    curl -fsSL https://api.adoptium.net/v3/binary/latest/${JAVA_VERSION}/ga/linux/x64/jdk/hotspot/normal/eclipse \
    -o /tmp/openjdk.tar.gz && \
    tar -xzf /tmp/openjdk.tar.gz -C /opt/java && \
    rm /tmp/openjdk.tar.gz && \
    ln -s /opt/java/jdk-* /opt/java/latest

ENV JAVA_HOME=/opt/java/latest
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# -------------------------------
# Install Erlang 28 (via source)
# -------------------------------
ENV ERLANG_VERSION=28.0

RUN git clone -b OTP-${ERLANG_VERSION} https://github.com/erlang/otp.git /usr/local/src/otp && \
    cd /usr/local/src/otp && \
    ./configure && \
    make -j$(nproc) && \
    make install

# Cleanup
RUN rm -rf /usr/local/src/otp

# Confirm installations
RUN java -version && erl -version

COPY . /app
WORKDIR /app

RUN sed -i 's/\r$//' compile.sh




CMD ["tail", "-f", "/dev/null"]