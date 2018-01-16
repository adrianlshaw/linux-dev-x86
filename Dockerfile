FROM ubuntu:16.04
RUN apt-get update -qq && apt-get install -y build-essential qemu-system-x86 git bc debootstrap
RUN git clone https://github.com/torvalds/linux.git --depth=1 --branch=v4.7
COPY *.sh /linux/
COPY config /linux/.config
RUN cd /linux && make -j4
WORKDIR /linux
RUN ./setup.sh && ./boot.sh
ENTRYPOINT [ "/bin/bash", "-c", "/linux/boot.sh" ]
