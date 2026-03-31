# Use the Jupyter base image 
FROM jupyter/minimal-notebook:latest

USER root

# 1. Install wget to fetch the binary
RUN apt-get update && apt-get install -y wget && apt-get clean

# 2. Download and install the pre-compiled FORM 5.0 binary
RUN wget https://github.com/form-dev/form/releases/download/v5.0.0/form-5.0.0-x86_64-linux.tar.gz && \
    tar -xzvf form-5.0.0-x86_64-linux.tar.gz && \
    mv form /usr/local/bin/form && \
    chmod +x /usr/local/bin/form && \
    rm form-5.0.0-x86_64-linux.tar.gz

# 3. Install Python dependencies
RUN pip install --no-cache-dir \
    matplotlib \
    numpy \
    ipykernel \
    matplotlib-inline

USER ${NB_USER}
WORKDIR /home/jovyan
