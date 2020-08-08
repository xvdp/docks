
FROM xvdp/cudagl10.2_conda:latest

SHELL ["/bin/bash", "-c"]

RUN conda create -n abh2 python=3.8.5 numpy=1.18.5 opencv=4.4.0 accimage=0.1.1 
RUN source activate abh2 && conda install pytorch torchvision cudatoolkit=10.2 -c pytorch
RUN source activate abh2 && pip install tensorflow_gpu

RUN conda clean -ya

ENV CONDA_DEFAULT_ENV=abh2
ENV CONDA_PREFIX=$HOME/miniconda/envs/$CONDA_DEFAULT_ENV
ENV PATH=$CONDA_PREFIX/bin:$PATH
ENV DEF_CONDA=abh2

RUN pip install ipython requests ninja yacs cython matplotlib jupyter tqdm

#aliases
RUN echo 'alias ab="conda activate abh2"' >> ~/.bashrc && echo 'alias aa="conda deactivate"' >> ~/.bashrc &&  \
echo "alias giturl='grep \"url\" .git/config | cut -d\"=\" -f2 | tr -d \" \t\n\r\" | xclip -sel clip && grep \"url\" .git/config | cut -d\"=\" -f2'"  >> ~/.bashrc \
&& echo 'alias xpwd="pwd | xclip -sel clip"' >> ~/.bashrc &&echo 'alias init="eval `cat $HOME/.bash_entry_point.sh`"'  >> ~/.bashrc
COPY "bash_entry_point.sh" "$HOME/.bash_entry_point.sh"

# associate port with image in ../ports.sh
EXPOSE 7777
ENTRYPOINT ["sh", "-c", "jupyter notebook --allow-root -y --no-browser --ip=0.0.0.0 --port=7777"] 


# RUN pip install pandas h5py networkx nltk scipy scikit-learn scikit-image
# RUN sudo useradd -m docker && echo "docker:docker" | sudo chpasswd && sudo adduser docker sudo
