FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \ 
	libgsl27 \
	libgsl-dev \
	libfftw3-bin \
	libfftw3-dev \
	git \
	gcc-11 \
	g++-11 \
        python3 \
        python3-pip \
	wget \
	unzip \
	make \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install cython numpy scipy

RUN wget https://github.com/lesgourg/class_public/archive/refs/heads/master.zip && \
    unzip master.zip && \
    sed -i 's/np\.int_t/np.int64_t/g' class_public-master/python/classy.pyx && \
    cd class_public-master && \
    export PYTHON=python3 make all && \
    make
    
RUN git clone https://github.com/jordanflitter/21cmFirstCLASS.git && \
    cd 21cmFirstCLASS && \
    python3 setup.py clean && \
    python3 setup.py install && \
    pip3 install . 

RUN pip3 install jupyter 

EXPOSE 8888
