FROM nvidia/cudagl:9.2-devel-ubuntu18.04

SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y apt-utils apt-transport-https ca-certificates software-properties-common && rm -rf /var/lib/apt/lists/* && \
apt-get update && apt-get install -y --no-install-recommends apt-utils gnupg2 curl lsof xclip wget nano locate

RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" && apt install -y code && apt-get update

# Create a non-root user and switch to it.
RUN adduser --disabled-password --gecos '' --shell /bin/bash z
#RUN echo "z ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-z
USER z

# All users can use /home/z as their home directory.
ENV HOME=/home/z
RUN chmod 777 /home/z

# access 'work' folder, if it is passed by run else create
RUN [ ! -d /home/z/work ] && mkdir /home/z/work
WORKDIR /home/z/work
RUN chown -R z:z /home/z/work

# Install Miniconda.
RUN curl -so ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
 && chmod +x ~/miniconda.sh && ~/miniconda.sh -b -p ~/miniconda && rm ~/miniconda.sh
ENV PATH=/home/z/miniconda/bin:$PATH
ENV CONDA_AUTO_UPDATE_CONDA=false

RUN conda config --add channels conda-forge && conda init bash
# && conda create --name abh python=3

ENTRYPOINT ["/bin/bash"]




