# Use Ubuntu as base
FROM ubuntu:22.04

# Install dependencies for Unity headless server
RUN apt-get update && \
    apt-get install -y \
    libgtk2.0-0 \
    libglib2.0-0 \
    libglu1-mesa \
    libxcursor1 \
    libxrandr2 \
    libxinerama1 \
    libxi6 \
    libasound2 \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Copy Unity server build files into container
COPY ./FishNetServer.x86_64 .
COPY ./FishNetServer_Data ./FishNetServer_Data

# Make the server executable
RUN chmod +x ./FishNetServer.x86_64

# Expose FishNet port
EXPOSE 7777

# Run the server in headless mode
CMD ["./FishNetServer.x86_64", "-batchmode", "-nographics", "-port", "7777"]
