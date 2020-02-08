FROM oblique/archlinux-yay
MAINTAINER Ivan Rasikhin <i.rasikhin@gmail.com>

# install deps
RUN pacman -Syu --noconfirm nodejs npm yarn openssh docker && \
    sudo -u aur yay -S --noconfirm gradle maven protobuf protoc-gen-grpc-web terraform packer nomad consul ammonite go && \
    yarn global add standard-version && \
    go get github.com/jrasell/levant && go install github.com/jrasell/levant

