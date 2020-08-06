
FROM xvdp/cudagl10.0_conda:latest

SHELL ["/bin/bash", "-c"]

COPY abg8_pt1.3_tf1.14_cudagl10.0.yml abg8_pt1.3_tf1.14_cudagl10.0.yml
RUN conda env create -f abg8_pt1.3_tf1.14_cudagl10.0.yml && rm abg8_pt1.3_tf1.14_cudagl10.0.yml && conda init
RUN source activate abg8

ENV CONDA_DEFAULT_ENV=abg8
ENV CONDA_PREFIX=$HOME/miniconda/envs/$CONDA_DEFAULT_ENV
ENV PATH=$CONDA_PREFIX/bin:$PATH
RUN conda clean -ya

ENV DEF_CONDA=abg8
RUN source activate ${DEF_CONDA}

# RUN pip install pyrender==0.1.39 google-auth==1.4.2 google-colab==1.0.0 google-pasta==0.1.7 cvui==2.7 opencv-python==4.1.1.26 simplification==0.4.2 pause==0.2
# RUN pip install awscli pandas pycocotools beautifulsoup4 colour-science pyflow requests urllib3 pybind11 imageio grpcio pyglet

RUN pip install ipython requests ninja yacs cython matplotlib jupyter tqdm pandas beautifulsoup4 pyflow colour-science pycocotools awscli

#aliases
RUN echo 'alias ab="conda activate abg8"' >> ~/.bashrc && echo 'alias aa="conda deactivate"' >> ~/.bashrc &&  echo 'alias giturl="getgiturl && echo $url"'  >> ~/.bashrc \
&& echo 'alias xpwd="pwd | xclip -sel clip"' >> ~/.bashrc &&echo 'alias cinit="eval `cat $HOME/.bash_entry_point.sh`"'  >> ~/.bashrc
COPY "bash_entry_point.sh" "$HOME/.bash_entry_point.sh"

EXPOSE 8888
ENTRYPOINT ["sh", "-c", "jupyter notebook --allow-root -y --no-browser --ip=0.0.0.0 --port=8888"] 
