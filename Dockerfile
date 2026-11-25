ARG GO_VERSION=1.27.4
FROM golang:${GO_VERSION}-bookworm AS golang

FROM letsdone/devcontainer-base:0.1.4-all
USER root

ARG USERNAME=dev

RUN set -euo pipefail; \
    apt-get update; \
    apt-get install -y --no-install-recommends ca-certificates curl git ripgrep; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/* /usr/local/go

COPY --from=golang /usr/local/go /usr/local/go

ENV GOPATH=/home/${USERNAME}/go
ENV PATH=/usr/local/go/bin:${GOPATH}/bin:${PATH}

USER ${USERNAME}
RUN set -euo pipefail; \
    mkdir -p "${GOPATH}/bin" "${GOPATH}/pkg"; \
    go version

ARG CLAUDE_PREINSTALLED=false
RUN if [ "${CLAUDE_PREINSTALLED}" = "true" ]; then \
      echo "==> CLAUDE_PREINSTALLED is set to true, installing Claude CLI..." \
      && source ~/.zshrc \
      && install_claude; \
    fi

ARG GEMINI_PREINSTALLED=false
RUN if [ "${GEMINI_PREINSTALLED}" = "true" ]; then \
      echo "==> GEMINI_PREINSTALLED is set to true, installing Gemini CLI..." \
      && source ~/.zshrc \
      && install_gemini_cli; \
    fi

ARG CODEX_PREINSTALLED=false
RUN if [ "${CODEX_PREINSTALLED}" = "true" ]; then \
      echo "==> CODEX_PREINSTALLED is set to true, installing Codex CLI..." \
      && source ~/.zshrc \
      && install_codex; \
    fi

USER ${USERNAME}
WORKDIR /home/${USERNAME}/workspace

ENTRYPOINT ["/bin/zsh"]
