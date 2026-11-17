#!/usr/bin/env python3
"""Serve o iccmonit v2 apenas na interface local.

Para acesso remoto, use um túnel SSH. O projeto não oferece bind em LAN ou
0.0.0.0 porque a TUI expõe metadados sensíveis da máquina.
"""

import sys
import threading
import time
import webbrowser

from textual_serve.server import Server

DEFAULT_PORT = 8000
HOST = "127.0.0.1"


def open_browser_after(url: str, delay: float = 1.0) -> None:
    def _open() -> None:
        time.sleep(delay)
        try:
            webbrowser.open(url)
        except Exception:
            pass

    threading.Thread(target=_open, daemon=True).start()


def main() -> None:
    try:
        port = int(sys.argv[1]) if len(sys.argv) > 1 else DEFAULT_PORT
    except ValueError as exc:
        raise SystemExit("porta deve ser um número inteiro") from exc
    if not 1 <= port <= 65535:
        raise SystemExit("porta deve estar entre 1 e 65535")

    url = f"http://{HOST}:{port}"
    print(f"Servindo somente localmente em {url} (Ctrl+C para sair)")
    print("Para acesso remoto, use túnel SSH; bind em LAN/0.0.0.0 não é suportado.")
    open_browser_after(url)
    Server(
        command=f"{sys.executable} monitor.py",
        host=HOST,
        port=port,
        title="iccmonit v2",
    ).serve()


if __name__ == "__main__":
    main()
