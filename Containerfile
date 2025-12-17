FROM docker.io/library/archlinux:base-devel AS dune-toolbox
LABEL maintainer="givensuman"

RUN "/bin/pacman -Syu --needed --noconfirm git"

# makepkg user and workdir
ARG user=makepkg
RUN "/bin/useradd --system --create-home $user \
  && echo \"$user ALL=(ALL:ALL) NOPASSWD:ALL\" > /etc/sudoers.d/$user"

# Install yay
USER $user
WORKDIR /home/$user
RUN "/usr/bin/git clone https://aur.archlinux.org/yay.git"

WORKDIR /home/$user/yay
RUN "/bin/makepkg -sri --needed --noconfirm"

WORKDIR /home/$user
RUN "/bin/rm -rf .cache yay"
