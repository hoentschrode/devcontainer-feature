# NeoVIM

This devcontainer feature installs neoVIM from source.

## Usage

Copy this to your devcontainer.json to use:

```
"features": {
    "ghcr.io/hoentsch-rode/devcontainer-features/neovim:1": {}
}
```

## Options

| Options Id | Description                                                            | Type   | Default Value |
| ---------- | ---------------------------------------------------------------------- | ------ | ------------- |
| version    | neovim version (stable, nightly, or specific version MAJOR.MINOR.PATH) | string | stable        |

## OS support

Currently this feature assumes a debian based container including `apt` package manager with installed `bash`.
