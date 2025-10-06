Contexto:
- Proyecto: leadgen-plm-prod-01 / repo plm-infra.
- Autenticación CI/CD: Workload Identity Federation con SA tf-plan-bot@leadgen-plm-prod-01.iam.gserviceaccount.com.
- Pipeline: .github/workflows/terraform.yml ya creado (plan en PR, apply al merge).
- Estado local: cambios limpios; untracked ignorados; backend GCS operativo.
- Herramientas disponibles: Gemini CLI autenticado (login con Google). Se puede invocar con inputs tipo @archivo desde el workspace.
- Archivos de referencia:
  @.github/workflows/terraform.yml
  @terraform/backend.tf
  @terraform/iam_invokers.tf
  @artifacts/pending_decisions.md
  @artifacts/diff.patch (si existe; generar con: `git fetch origin main && git diff origin/main... > artifacts/diff.patch`)

Objetivo:
- Entregar un PR listo para GitHub con TÍTULO y DESCRIPCIÓN profesionales, checklist, riesgos, rollback y próximos pasos.
- Proponer mejoras mínimas al workflow Terraform CI/CD.
- Actualizar “pending decisions” en un bloque Markdown listo para copiar/pegar.
- El agente **no ejecuta** comandos ni hace commits: solo redacta artefactos.

Instrucciones de salida:
Devuelve un único bloque Markdown con secciones en este orden y con contenido conciso y accionable:
# Título PR
## Descripción
- Bullets de cambios
- Supuestos
## Checklist (previo al merge)
- terraform fmt, init, validate, plan en Actions
- revisión de diffs sensibles (IAM, backends, etc.)
## Riesgos
## Rollback
- pasos concretos para deshacer en caso de error
## Mejoras al workflow
- justifica en 1–2 líneas c/u (matrix de TF, cache de plugins, timeouts, fail-fast, locking, labels en GHA)
## Pending decisions (propuesta de actualización)
- Decisiones abiertas
- Variables obligatorias + defaults sugeridos
- Límite IAM mínimo por SA
- Próximos PRs recomendados (lista priorizada)

Criterios:
- No incluir credenciales ni valores secretos.
- Referir archivos por ruta relativa del repo.
- Si detectas incoherencias, añádelas a “Pending decisions”.
- Considera que Gemini CLI está disponible; si sirve, sugiere un comando ejemplo de uso (solo como texto, no ejecutarlo).

Formato:
- Markdown limpio, sin HTML extra, sin intro ni cierre fuera de las secciones pedidas.
