FROM oblique/archlinux-yay
MAINTAINER Ivan Rasikhin <i.rasikhin@gmail.com>

# install deps
RUN sudo pacman -Syu --noconfirm nodejs npm yarn openssh docker && \
    sudo -u aur yay -S --noconfirm gradle maven protobuf protoc-gen-grpc-web terraform packer nomad-bin consul ammonite go && \
    yarn global add standard-version && \
    yarn cache clean && \
    curl -L https://github.com/jrasell/levant/releases/download/0.2.8/linux-amd64-levant -o /usr/local/bin/levant && \
    chmod +x /usr/local/bin/levant && \
    sudo pacman --noconfirm -Sc && \
    sudo yay --noconfirm -R go jdk && \
    sudo -u aur yay --noconfirm -Sc

RUN sudo archlinux-java set java-14-jdk

COPY entrypoint.sh /bin/entrypoint.sh
COPY daemon.json /etc/docker/daemon.json
ENTRYPOINT ["entrypoint.sh"]
