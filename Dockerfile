FROM ubuntu:18.04
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    uidmap gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping libsdl1.2-dev xterm tar locales pxz cmake gdb\
    libboost-all-dev ninja-build qt5-default git libqt5serialport5-dev libqt5charts5-dev \
    qtdeclarative5-dev qtdeclarative5-private-dev libqt5websockets5-dev libqt5test5 \
    libqt5svg5-dev qtquickcontrols2-5-dev qtbase5-private-dev libqt5x11extras5-dev \
    qml-module-qtqml-statemachine qml-module-qt-labs-settings qml-module-qt-labs-platform \
    qml-module-qtquick-controls2 qml-module-qtquick2 qml-module-qttest \
    libssl-dev libxml2-dev lcov xvfb p7zip tzdata libxss-dev libkf5networkmanagerqt-dev

RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV USER_NAME jenkins

ARG host_uid=1000
ARG host_gid=1000
RUN groupadd -g $host_gid $USER_NAME && useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME

RUN mkdir -p /etc/sudoers.d \
 && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USER_NAME \
 && chmod 0440 /etc/sudoers.d/$USER_NAME 
        
RUN echo "#/bin/sh\\n/usr/bin/xvfb-run -a -s '-screen 0 800x600x24+32' \$@" > /usr/bin/xvfb_run
RUN chmod +x /usr/bin/xvfb_run

USER $USER_NAME

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["cat"]
