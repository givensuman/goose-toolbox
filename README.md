<div align="center">
  <img src="https://github.com/givensuman/dune-os/blob/main/assets/readme_header.png" />

  <img src="https://img.shields.io/github/actions/workflow/status/givensuman/dune-toolbox/build.yml?labelColor=purple" />
</div>

## About

This is a custom Fedora image comparable to [Ultramarine Linux](https://ultramarine-linux.org). It is set to act as a mutable overlay for the otherwise immutable [Dune OS](https://github.com/givensuman/dune-os).

## Installation

Verify the image signature with `cosign`:

```bash
cosign verify --key \
https://github.com/givensuman/dune-toolbox/raw/main/cosign.pub \
ghcr.io/givensuman/dune-toolbox:stable
```

then pull 'er down:

```bash
podman pull ghcr.io/givensuman/dune-toolbox:stable
```

There is also an install script:

```bash
git clone https://github.com/givensuman/dune-toolbox
cd dune-toolbox && chmod +x ./scripts/install.sh
./scripts/install.sh
```

As used in Dune OS, this replaces the `toolbox` command shipped with Fedora. Run `toolbox create` to build the first container specified in `$HOME/.config/dune-toolbox/toolbox.ini` meeting the [Distrobox assemble](https://distrobox.it/usage/distrobox-assemble/) specification, or this default:

```ini
[dune-toolbox]
image="ghcr.io/givensuman/dune-toolbox:stable"
volume="/home/linuxbrew:/home/linuxbrew:rslave"
volume="/usr/bin/:/usr/local/bin"
entry=false
```

Generally speaking, Distrobox is more powerful and allows us better control of the resulting development environment.

This image is can also be used with the [Toolbx](https://github.com/containers/toolbox) utility. To set this as your default toolbox, edit `$HOME/.config/containers/toolbox.conf` to contain the following:

```ini
[general]
image = "ghcr.io/givensuman/dune-toolbox:stable"
```

<div align="center">
  <img src="https://github.com/givensuman/dune-os/blob/main/assets/readme_footer.png" />
</div>
