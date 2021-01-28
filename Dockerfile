FROM nvidia/cudagl:11.2.0-runtime-ubuntu18.04

WORKDIR /tmp

COPY UnityHub.AppImage /tmp

RUN chmod +x UnityHub.AppImage && \
    dd if=/dev/zero bs=1 count=3 seek=8 conv=notrunc of=/tmp/UnityHub.AppImage && \
    sed -i s/archive.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list && \
    sed -i s/security.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list && \
    rm -rf /etc/apt/sources.list.d && \
    apt-get update && \
    apt-get install -y nano curl screen screenfetch git proxychains \
        alsa alsa-tools libnss3 \
        libcanberra-gtk-module libcanberra-gtk3-module \
        apt-utils fuse desktop-file-utils \
        mesa-utils xdg-utils xvfb zenity && \
    apt-get clean

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/bin/bash" ]
