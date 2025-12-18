FROM quay.io/toolbx/arch-toolbox:latest
LABEL com.github.containers.toolbox="true" \
      name="dune-toolbox" \
      version="base" \
      usage="This image is meant to be used within Dune OS" \
      summary="Default image run in Dune OS toolboxes" \
      maintainer="givensuman <givensuman@duck.com>"

# Update the system and install git
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm git base-devel && \
    pacman -Scc --noconfirm

RUN useradd -m -G wheel aur && \
    # Allow the 'aur' user to run sudo without a password
    echo "aur ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/aur

USER aur
WORKDIR /home/aur

# Clone the yay repository and build it
RUN git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -si --noconfirm && \
    cd .. && \
    rm -rf yay
