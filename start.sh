#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

VENV_DIR=".venv"
PYTHON="$VENV_DIR/bin/python"
DEFAULT_WEB_PORT=8000

ensure_deps() {
    if [ ! -x "$PYTHON" ]; then
        python3 -m venv "$VENV_DIR"
    fi
    if ! "$PYTHON" -c "import anthropic, textual" 2>/dev/null; then
        "$PYTHON" -m pip install --upgrade pip
        "$PYTHON" -m pip install -r requirements.txt
    fi
}

usage() {
    cat <<EOF
Uso:
  ./start.sh                 roda a TUI no terminal
  ./start.sh web [porta]     abre a TUI no navegador, somente em 127.0.0.1
  ./start.sh -h              mostra esta ajuda

Opções sensíveis são opt-in:
  ICCMONIT_ENABLE_CHAT=1
  ICCMONIT_INCLUDE_TRANSCRIPT=1
  ICCMONIT_ENABLE_CHAT_LOG=1
  ICCMONIT_ALLOW_DOCKER_ACTIONS=1
  ICCMONIT_ENABLE_CODEX_PROBE=1

Para acesso remoto, mantenha o bind local e use um túnel SSH:
  ssh -L 8000:127.0.0.1:8000 usuario@maquina
EOF
}

case "${1:-}" in
    web)
        ensure_deps
        exec "$PYTHON" serve.py "${2:-$DEFAULT_WEB_PORT}"
        ;;
    -h|--help|help)
        usage
        ;;
    "")
        ensure_deps
        exec "$PYTHON" monitor.py
        ;;
    *)
        echo "Comando desconhecido: $1" >&2
        usage >&2
        exit 2
        ;;
esac
