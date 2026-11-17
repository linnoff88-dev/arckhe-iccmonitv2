# CLAUDE.md

## Projeto

`iccmonit v2` é uma TUI local de monitoramento de sessões Claude Code.

## Segurança obrigatória

- O servidor web deve continuar limitado a `127.0.0.1`.
- Não adicionar bind em LAN ou `0.0.0.0`.
- Recursos que leem credenciais, transcripts, logs ou executam ações devem
  permanecer opt-in.
- Não versionar `state/`, logs, `.env`, credenciais ou dados de sessões.
- Exemplos e imagens devem usar dados fictícios.

## Comandos

```bash
./start.sh
./start.sh web
bash -n start.sh
python3 -m py_compile monitor.py serve.py
```

## Arquivos principais

- `monitor.py`: TUI e coleta local.
- `serve.py`: wrapper web somente localhost.
- `config.json`: thresholds e preferências visuais.
- `requirements.txt`: dependências fixadas.
- `SECURITY.md`: modelo de segurança público.
