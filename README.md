<div align="center">
  <img src="https://github.com/givensuman/goose-linux/blob/main/assets/goose.png" width="250" />
</div>

<div align="center">
  <img src="https://img.shields.io/github/actions/workflow/status/givensuman/goose-toolbox/build.yml?labelColor=purple" />
</div>

## About

This is a custom Fedora image comparable to [Ultramarine Linux](https://ultramarine-linux.org). It is set to act as a mutable overlay for the otherwise immutable [goose linux](https://github.com/givensuman/goose-linux).

## Installation

Verify the image signature with `cosign`:

```bash
cosign verify --key \
https://github.com/givensuman/goose-toolbox/raw/main/cosign.pub \
ghcr.io/givensuman/goose-toolbox:stable
```

then pull 'er down:

```bash
podman pull ghcr.io/givensuman/goose-toolbox:stable
```

As used in goose linux, this acts as the default Distrobox container. Run `distrobox create` to build. Generally speaking, Distrobox is more powerful and allows us better control of the resulting development environment.

You can set this as your default as well by mimicking goose linux's `/usr/share/distrobox/distrobox.conf`:

```conf
container_image_default="ghcr.io/givensuman/goose-toolbox"
container_name_default="goose-toolbox"
```

This image is can also be used with the [Toolbx](https://github.com/containers/toolbox) utility. To set this as your default toolbox, edit `$HOME/.config/containers/toolbox.conf` to contain the following:

```ini
[general]
image = "ghcr.io/givensuman/goose-toolbox:stable"
```

<div align="center">
  <img src="https://github.com/givensuman/goose-linux/blob/main/assets/banner.png" />
</div>
