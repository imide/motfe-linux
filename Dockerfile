FROM debian:bookworm

RUN apt update && apt install -y \
    git wget dpkg\
    gcc zlib1g-dev\
    build-essential \
    libssl-dev \
    libffi-dev \
    # install python3
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python3-venv \
    # install openjdk-11
    openjdk-11-jdk \
    axel \
    # install QGIS and imagemagick
    && apt install -y xvfb imagemagick gnupg software-properties-common\
    && mkdir -m755 -p /etc/apt/keyrings \
    && wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg \
    && echo 'deb [arch=amd64] https://qgis.org/debian bookworm main' | tee /etc/apt/sources.list.d/qgis.sources \
    && echo 'deb-src [arch=amd64] https://qgis.org/debian bookworm main' | sudo tee -a /etc/apt/sources.list.d/qgis.sources \
    && echo 'Signed-By: /etc/apt/keyrings/qgis-archive-keyring.gpg' | tee -a /etc/apt/sources.list.d/qgis.sources \
    && apt-get update \
    && apt-get install -y qgis qgis-plugin-grass\
    # install worldpainter
    && wget -O /tmp https://www.worldpainter.net/files/worldpainter_2.21.0.deb \
    && dpkg -i /tmp/worldpainter_2.21.0.deb \
    && rm /tmp/worldpainter_2.21.0.deb \
    # install Minutor
    && wget -O /tmp/Minutor.Ubuntu-22.04.zip https://github.com/mrkite/minutor/releases/download/2.20.0/Minutor.Ubuntu-22.04.zip \
    && unzip /tmp/Minutor.Ubuntu-22.04.zip \
    && mv minutor /usr/bin/ \
    && rm /tmp/Minutor.Ubuntu-22.04.zip \
    # post cleanup
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

CMD [ "bash" ]