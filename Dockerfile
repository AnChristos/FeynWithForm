# Use a Jupyter-compatible base image
FROM jupyter/minimal-notebook:latest

USER root

# Install build dependencies for FORM 5.0
RUN apt-get update && apt-get install -y \
    wget \
    gcc \
    g++ \
    make \
    cmake \
    libgmp-dev \
    zlib1g-dev \
    && apt-get clean

# Download and Build FORM 5.0
# We use 'ls' logic to catch the directory name regardless of minor version naming
RUN wget https://github.com/vermaseren/form/releases/download/v5.0.0/form-5.0.0.tar.gz \
    && tar -xzvf form-5.0.0.tar.gz \
    && cd form-5.0.0 \
    && mkdir build \
    && cd build \
    && cmake .. -DENABLE_FORMLIB=ON \
    && make -j$(nproc) \
    && make install \
    && cd ../.. \
    && rm -rf form-5.0.0*

# Ensure the notebook user has permissions and the right tools
RUN pip install --upgrade pip && \
    pip install "matplotlib>=3.8.0" "ipykernel>=6.29.0" "matplotlib-inline>=0.1.6" "numpy"

USER ${NB_USER}
