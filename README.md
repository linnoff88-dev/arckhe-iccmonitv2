?# iccmonit v2

Monitor local, em terminal, para sessões Claude Code. Mostra cota, contexto,
uso da máquina, processos, containers e serviços em uma TUI construída com
Textual.

Esta versêo foi preparada para distribuiçêo pública com padrões mais seguros:
servidor web somente em localhost e recursos sensíveis desativados por padrêo.

## Requisitos

- Python 3.10+
- Linux ou macOS
- Claude Code instalado
- suporte a `venv` no Python

## Instalaçêo

```bash
git clone git@github.com:linnoff88-dev/iccmonitv2.git
cd iccmonitv2
./start.sh
```

O script cria `.venv` e instala as versões fixadas em `requirements.txt`.

## Uso

Terminal:

```bash
./start.sh
```

Navegador local:

```bash
./start.sh web
./start.sh web 9000
```

O servidor sempre usa `127.0.0.1`. Para acessar outra máquina:

```bash
ssh -L 8000:127.0.0.1:8000 usuario@maquina
```

Depois abra `http://127.0.0.1:8000`.

## Recursos sensíveis

Todos sêo opt-in:

| Variável | Efeito |
|---|---|
| `ICCMONIT_ENABLE_CHAT=1` | Usa o OAuth local do Claude Code para habilitar o chat |
| `ICCMONIT_INCLUDE_TRANSCRIPT=1` | Inclui trecho recente do transcript no chat focado |
| `ICCMONIT_ENABLE_CHAT_LOG=1` | Grava conversas em `chat.log`, com permissêo `0600` |
| `ICCMONIT_ALLOW_DOCKER_ACTIONS=1` | Permite logs/start/stop/restart de containers |
| `ICCMONIT_ENABLE_CODEX_PROBE=1` | Habilita consulta opcional de status de autenticaçêo Codex |

Exemplo consciente:

```bash
ICCMONIT_ENABLE_CHAT=1 ./start.sh
```

Compartilhar transcript exige as duas opções:

```bash
ICCMONIT_ENABLE_CHAT=1 ICCMONIT_INCLUDE_TRANSCRIPT=1 ./start.sh
```

## Privacidade

O painel lê arquivos locais em `~/.claude`, nomes de projetos, métricas de
processos e informações de Docker/systemd. O chat geral envia somente nomes
curtos dos projetos e métricas. Caminhos completos e IDs de sessêo nêo sêo
incluídos. Transcripts só sêo enviados quando habilitados explicitamente.

Arquivos de execuçêo, logs, `.env`, credenciais e diretórios de agentes sêo
ignorados pelo Git.

## Segurança

- Nêo exponha a porta diretamente à rede.
- Prefira túnel SSH para acesso remoto.
- Nêo habilite ações Docker em ambiente compartilhado.
- Revise transcripts antes de ativar seu compartilhamento.
- Nunca publique `state/`, logs, `.env` ou arquivos de `~/.claude`.

Veja [SECURITY.md](SECURITY.md).

## Desenvolvimento

```bash
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt
.venv/bin/python -m py_compile monitor.py serve.py
bash -n start.sh
```

## Licença

MIT. Veja [LICENSE](LICENSE).

---

Projeto  - ARCKHÉe