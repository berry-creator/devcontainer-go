# devcontainer-go

A devcontainer base image for Go development, based on `letsdone/devcontainer-base`.

The image includes Go (default version `1.27.4`), native build tools, and common
development utilities. It supports `linux/amd64` and `linux/arm64`.

Build and publish by pushing a version tag. The GitHub Actions workflow publishes
the default image and variants with Claude, Gemini, and Codex CLI preinstalled.

To select another Go version when building locally:

```sh
docker build --build-arg GO_VERSION=1.27.4 -t devcontainer-go .
```
