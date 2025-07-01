FROM openjdk:24-jdk-alpine

# Install Erlang and dependencies using apk
RUN apk add --no-cache erlang

# Copy all files and folders from current directory to /app inside container
COPY . /app
WORKDIR /app

# Check versions (optional)
RUN java --version && erl -version

# Keep container running by default
CMD ["tail", "-f", "/dev/null"]
