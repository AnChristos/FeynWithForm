# Use the Jupyter base image 
FROM jupyter/minimal-notebook:latest

USER root

# 1. Install wget to fetch the binary
RUN apt-get update && apt-get install -y wget && apt-get clean

# 2. Download and install FORM 5.0
RUN wget https://github.com/form-dev/form/releases/download/v5.0.0/form-5.0.0-x86_64-linux.tar.gz && \
    tar -xzvf form-5.0.0-x86_64-linux.tar.gz && \
    mv form-5.0.0-x86_64-linux/form /usr/local/bin/form && \
    mv form-5.0.0-x86_64-linux/tform /usr/local/bin/tform && \
    chmod +x /usr/local/bin/form /usr/local/bin/tform && \
    rm -rf form-5.0.0-x86_64-linux.tar.gz form/

# 3. Python tools for the notebook
RUN pip install --no-cache-dir matplotlib numpy ipykernel matplotlib-inline

USER ${NB_USER}
WORKDIR /home/jovyan
# 3. Install Python dependencies
RUN pip install --no-cache-dir \
    matplotlib \
    numpy \
    ipykernel \
    matplotlib-inline

USER ${NB_USER}
WORKDIR /home/jovyan
