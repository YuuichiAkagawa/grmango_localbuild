#GR-MANGO offline build

FROM ubuntu:xenial

WORKDIR /mbed

# install dependencies
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y \
  python2.7-minimal \
  python-pip \
  curl \
  git \
  mercurial \
  libc6:i386 \
  libstdc++6:i386

# ARM GCC
ENV ARMTOOLCHAIN /opt/gcc-arm-none-eabi-6-2017-q2-update
ENV GCC_ARM_PATH $ARMTOOLCHAIN/bin
RUN curl -L https://developer.arm.com/-/media/Files/downloads/gnu-rm/6-2017q2/gcc-arm-none-eabi-6-2017-q2-update-linux.tar.bz2 | tar -xjC /opt

# mbed
RUN pip install mbed-cli && mbed import https://github.com/d-kato/RZ_A2M_Mbed_samples

# utility script
COPY prepare /usr/local/bin

# umask and alias
RUN echo "umask 000" >> /root/.bashrc
RUN echo "alias build=\"mbed compile -m GR_MANGO -t GCC_ARM --profile debug\""  >> /root/.bashrc

VOLUME ["/mbed/projects"]

CMD ["/bin/bash"]
