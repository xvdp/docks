
FROM xvdp/cudagl10.2_conda:latest

SHELL ["/bin/bash", "-c"]

RUN conda create -n abh2 python=3.8.5 numpy=1.19.1 && source activate abh2 && conda install pytorch torchvision cudatoolkit=10.2 -c pytorch && \
conda install cudnn=7.6.5=cuda10.2_0 accimage=0.1.1 
RUN conda install tensorflow-gpu=2.2.0 tensorboard=2.3.0
RUN conda install opencv=4.4.0 ffmpeg=4.3.1 scipy=1.5.2 h5py=2.10.0 && conda clean -ya

ENV CONDA_DEFAULT_ENV=abh2
ENV CONDA_PREFIX=$HOME/miniconda/envs/$CONDA_DEFAULT_ENV
ENV PATH=$CONDA_PREFIX/bin:$PATH
ENV DEF_CONDA=abh2

RUN pip install ipython requests ninja yacs cython matplotlib jupyter tqdm

#aliases
RUN echo 'alias ab="conda activate abh2"' >> ~/.bashrc && echo 'alias aa="conda deactivate"' >> ~/.bashrc &&  echo 'alias giturl="getgiturl && echo $url"'  >> ~/.bashrc \
&& echo 'alias xpwd="pwd | xclip -sel clip"' >> ~/.bashrc &&echo 'alias cinit="eval `cat $HOME/.bash_entry_point.sh`"'  >> ~/.bashrc

#setup jupyter
COPY "bash_entry_point.sh" "$HOME/.bash_entry_point.sh"
EXPOSE 7777
ENTRYPOINT ["sh", "-c", "jupyter notebook --allow-root -y --no-browser --ip=0.0.0.0 --port=7777"] 


# RUN jupyter notebook --generate-config
# ENV CONFIG_PATH="/root/.jupyter/jupyter_notebook_config.py"
# COPY "jupyter_notebook_config.py" ${CONFIG_PATH}
# ENTRYPOINT ["sh", "-c", "jupyter notebook --allow-root -y --no-browser --ip=0.0.0.0 --port=9999 --config=${CONFIG_PATH}"]

# RUN conda create --name abh1 python=3
# RUN conda install python=3 numpy matplotlib psutil opencv pandas h5py tensorboard networkx scipy scikit-learn scikit-image
# RUN conda clean -ya
# RUN pip install Pillow-SIMD simplification opencv-python
# RUN conda install accimage
# RUN conda install pytorch torchvision cudatoolkit=10.1 -c pytorch

# RUN sudo useradd -m docker && echo "docker:docker" | sudo chpasswd && sudo adduser docker sudo
