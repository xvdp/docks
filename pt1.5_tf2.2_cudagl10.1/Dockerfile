
FROM xvdp/cudagl10.1_conda:latest

SHELL ["/bin/bash", "-c"]

COPY abh1_environment.yml abh1_environment.yml
RUN conda env create -f abh1_environment.yml && rm abh1_environment.yml && source activate abh1 && conda clean -ya

ENV CONDA_DEFAULT_ENV=abh1
ENV CONDA_PREFIX=$HOME/miniconda/envs/$CONDA_DEFAULT_ENV
ENV PATH=$CONDA_PREFIX/bin:$PATH
ENV DEF_CONDA=abh1 

RUN pip install ipython requests ninja yacs cython matplotlib jupyter tqdm

#aliases
RUN echo 'alias ab="conda activate abh1"' >> ~/.bashrc && echo 'alias aa="conda deactivate"' >> ~/.bashrc &&  \
echo "alias giturl='grep \"url\" .git/config | cut -d\"=\" -f2 | tr -d \" \t\n\r\" | xclip -sel clip && grep \"url\" .git/config | cut -d\"=\" -f2'"  >> ~/.bashrc \
&& echo 'alias xpwd="pwd | xclip -sel clip"' >> ~/.bashrc &&echo 'alias init="eval `cat $HOME/.bash_entry_point.sh`"'  >> ~/.bashrc
COPY "bash_entry_point.sh" "$HOME/.bash_entry_point.sh"

# associate port with image in ../ports.sh
EXPOSE 9999
ENTRYPOINT ["sh", "-c", "jupyter notebook --allow-root -y --no-browser --ip=0.0.0.0 --port=9999" ] 

# RUN sudo useradd -m docker && echo "docker:docker" | sudo chpasswd && sudo adduser docker sudo
