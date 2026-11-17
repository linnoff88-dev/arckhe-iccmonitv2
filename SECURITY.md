# Security policy

## Supported version

Only the latest release on the default branch is supported.

## Security model

iccmonit v2 reads local Claude Code session metadata, process information and,
when explicitly enabled, OAuth credentials and transcript excerpts. For this
reason:

- the web server binds only to `127.0.0.1`;
- remote access must use an authenticated SSH tunnel;
- chat, transcript sharing, chat logging, Docker actions and the Codex probe
  are disabled by default;
- runtime data under `state/` and local logs are excluded from Git.

Never expose the application port directly to a LAN or the internet.

## Reporting a vulnerability

Open a private GitHub security advisory in this repository. Do not publish
credentials, transcripts, hostnames, internal paths or session identifiers in
a public issue.
