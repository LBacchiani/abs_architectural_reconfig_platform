FROM openjdk:24-jdk

# Install dependencies for Erlang install and wget, gnupg for repo keys
RUN apt-get update && apt-get install -y curl gnupg apt-transport-https && \
    curl -fsSL https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | apt-key add - && \
    echo "deb https://packages.erlang-solutions.com/ubuntu $(lsb_release -cs) contrib" > /etc/apt/sources.list.d/erlang.list && \
    apt-get update && apt-get install -y erlang && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy your current folder contents into /app inside the container
COPY . /app

WORKDIR /app

# Just verify versions for debug (optional)
RUN java --version && erl -version

# Default command (can be overridden)
CMD ["bash"]
