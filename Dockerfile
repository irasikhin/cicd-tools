FROM oblique/archlinux-yay
MAINTAINER Ivan Rasikhin <i.rasikhin@gmail.com>

# install deps
RUN pacman -Syu --noconfirm nodejs npm yarn openssh docker && \
    sudo -u aur yay -S --noconfirm gradle maven protobuf protoc-gen-grpc-web terraform packer nomad consul ammonite go silver-searcher-git && \
    yarn global add standard-version && \
    yarn cache clean && \
    curl -L https://github.com/jrasell/levant/releases/download/0.2.8/linux-amd64-levant -o /usr/local/bin/levant && \
    chmod +x /usr/local/bin/levant && \
    sudo pacman --noconfirm -Sc && \
    sudo yay --noconfirm -R go && \
    sudo -u aur yay --noconfirm -Sc

# Front dependencies
RUN apt-get update && \
  apt-get install --no-install-recommends -y \
  libgtk2.0-0 \
  libgtk-3-0 \
  libnotify-dev \
  libgconf-2-4 \
  libnss3 \
  libxss1 \
  libasound2 \
  libxtst6 \
  xauth \
  xvfb \

# Chrome dependencies
RUN apt-get update
RUN apt-get install -y fonts-liberation libappindicator3-1 xdg-utils

# install Chrome browser
ENV CHROME_VERSION 80.0.3987.116
RUN wget -O /usr/src/google-chrome-stable_current_amd64.deb "http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}-1_amd64.deb" && \
  dpkg -i /usr/src/google-chrome-stable_current_amd64.deb ; \
  apt-get install -f -y && \
  rm -f /usr/src/google-chrome-stable_current_amd64.deb
RUN google-chrome --version

COPY entrypoint.sh /bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
