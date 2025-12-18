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
https://github.com/givensuman/dune-os/raw/main/cosign.pub \
ghcr.io/givensuman/dune-toolbox:stable
```

then pull 'er down:

```bash
podman pull ghcr.io/givensuman/dune-toolbox:stable
```

This image is meant to be used with the [Toolbx](https://github.com/containers/toolbox) utility. To set this as your default toolbox, edit `$XDG_CONFIG_HOME/containers/toolbox.conf` to contain the following:

```ini
[general]
image = "ghcr.io/givensuman/dune-toolbox:stable"
```

<div align="center">
  <img src="https://github.com/givensuman/dune-os/blob/main/assets/readme_footer.png" />
</div>
