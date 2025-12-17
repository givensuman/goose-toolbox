<div align="center">
  <img src="https://github.com/givensuman/dune-os/blob/main/assets/readme_header.png" />

  <img src="https://img.shields.io/github/actions/workflow/status/givensuman/dune-os/build.yml?labelColor=purple" />
  <img src="https://img.shields.io/github/actions/workflow/status/givensuman/dune-os/build_iso.yml?label=build%20iso&labelColor=blue" />
  <img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/dune-os" />
</div>

## About

This is a custom Arch Linux image preconfigured with the [yay](https://github.com/jguer/yay) AUR utility. It is set to act as a mutable overlay for the otherwise immutable [Dune OS](https://github.com/givensuman/dune-os).

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
