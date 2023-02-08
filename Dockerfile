FROM ubuntu
COPY setup_julia.jl /tmp
RUN apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y python3 python3-pip wget 

RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.3-linux-x86_64.tar.gz -P /tmp \
&& tar -xvzf /tmp/julia-1.7.3-linux-x86_64.tar.gz \
&& mv julia-1.7.3 /opt/julia 
ENV PATH $PATH:/opt/julia/bin 

RUN wget  https://github.com/quarto-dev/quarto-cli/releases/download/v1.2.335/quarto-1.2.335-linux-amd64.deb \
&& apt-get install -y /quarto-1.2.335-linux-amd64.deb \
&& python3 -m pip install jupyter \
&& julia /tmp/setup_julia.jl \
&& quarto install tinytex 

COPY quarto-template /tmp/quarto-template
RUN quarto render /tmp/quarto-template/template.qmd
