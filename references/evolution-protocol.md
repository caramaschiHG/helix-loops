# HELIX Evolution Protocol (Nível 5)

Após cada execução (sucesso ou falha):
1. Analisa execution-report.json + failures.json
2. Calcula calibration factor para cost-predictor.md
3. Atualiza templates/ (ralph-optimized, gsd-phases, etc.)
4. Commits na própria skill: git commit -m "HELIX self-evolution v1.x after project X"
5. Registra em evolution/evolution-log-$(date +%Y%m%d).md

Depois de 5+ runs a HELIX já conhece seu estilo de código.
