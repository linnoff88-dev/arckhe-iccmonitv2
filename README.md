# iccmonit v2

Monitor local, em terminal, para sessÃµes Claude Code. Mostra cota, contexto,
uso da mÃ¡quina, processos, containers e serviÃ§os em uma TUI construÃ­da com
Textual.

Esta versÃ£o foi preparada para distribuiÃ§Ã£o pÃºblica com padrÃµes mais seguros:
servidor web somente em localhost e recursos sensÃ­veis desativados por padrÃ£o.

## Requisitos

- Python 3.10+
- Linux ou macOS
- Claude Code instalado
- suporte a `venv` no Python

## InstalaÃ§Ã£o

```bash
git clone git@github.com:inematds/iccmonitv2.git
cd iccmonitv2
./start.sh
```

O script cria `.venv` e instala as versÃµes fixadas em `requirements.txt`.

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

O servidor sempre usa `127.0.0.1`. Para acessar outra mÃ¡quina:

```bash
ssh -L 8000:127.0.0.1:8000 usuario@maquina
```

Depois abra `http://127.0.0.1:8000`.

## Recursos sensÃ­veis

Todos sÃ£o opt-in:

| VariÃ¡vel | Efeito |
|---|---|
| `ICCMONIT_ENABLE_CHAT=1` | Usa o OAuth local do Claude Code para habilitar o chat |
| `ICCMONIT_INCLUDE_TRANSCRIPT=1` | Inclui trecho recente do transcript no chat focado |
| `ICCMONIT_ENABLE_CHAT_LOG=1` | Grava conversas em `chat.log`, com permissÃ£o `0600` |
| `ICCMONIT_ALLOW_DOCKER_ACTIONS=1` | Permite logs/start/stop/restart de containers |
| `ICCMONIT_ENABLE_CODEX_PROBE=1` | Habilita consulta opcional de status de autenticaÃ§Ã£o Codex |

Exemplo consciente:

```bash
ICCMONIT_ENABLE_CHAT=1 ./start.sh
```

Compartilhar transcript exige as duas opÃ§Ãµes:

```bash
ICCMONIT_ENABLE_CHAT=1 ICCMONIT_INCLUDE_TRANSCRIPT=1 ./start.sh
```

## Privacidade

O painel lÃª arquivos locais em `~/.claude`, nomes de projetos, mÃ©tricas de
processos e informaÃ§Ãµes de Docker/systemd. O chat geral envia somente nomes
curtos dos projetos e mÃ©tricas. Caminhos completos e IDs de sessÃ£o nÃ£o sÃ£o
incluÃ­dos. Transcripts sÃ³ sÃ£o enviados quando habilitados explicitamente.

Arquivos de execuÃ§Ã£o, logs, `.env`, credenciais e diretÃ³rios de agentes sÃ£o
ignorados pelo Git.

## SeguranÃ§a

- NÃ£o exponha a porta diretamente Ã  rede.
- Prefira tÃºnel SSH para acesso remoto.
- NÃ£o habilite aÃ§Ãµes Docker em ambiente compartilhado.
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

## LicenÃ§a

MIT. Veja [LICENSE](LICENSE).

---

Projeto adaptado da comunidade INEMA TDS - Marca Arckhe