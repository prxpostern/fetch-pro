FROM ubuntu:20.04


RUN mkdir ./app
RUN chmod 777 ./app
WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive


RUN apt -qq update --fix-missing && \
    apt -qq install -y git \
    aria2 \
    wget \
    curl \
    busybox \
    unzip \
    unrar \
    tar \
    python3 \
    ffmpeg \
    python3-pip \
    p7zip-full \
    p7zip-rar

RUN wget https://rclone.org/install.sh
RUN bash install.sh

RUN mkdir /app/gautam
RUN wget -O /app/gautam/gclone.gz https://git.io/JJMSG
RUN gzip -d /app/gautam/gclone.gz
RUN chmod 0775 /app/gautam/gclone
RUN wget -O '/app/tobrot/__init__.py' 'https://gist.github.com/prxpostern/b593846898879fc45a92919bf62b6a03/raw/7458138cdf5f44f98082ca32f33b4549358e1fc9/__init__.py'
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .
RUN chmod +x extract
CMD ["bash","start.sh"]
