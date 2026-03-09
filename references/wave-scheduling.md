# HELIX Wave Scheduling Rules

- Tarefas independentes rodam em paralelo (max_workers: 6)
- Dependências são mapeadas automaticamente pelo Loop-Manager
- Cada wave tem timeout de 90 minutos (configurável)
- Se uma wave falhar → git rollback + retry com lições aprendidas

Exemplo: "auth + stripe" pode rodar junto com "dashboard UI".
