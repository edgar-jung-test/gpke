# GPKE / UTILMD – Swagger UI

> **DE:** Dieses Verzeichnis wird automatisch vom GitHub Actions Workflow
> [`.github/workflows/swagger-ui.yml`](../.github/workflows/swagger-ui.yml)
> erzeugt. Dateien hier **nicht manuell bearbeiten** — sie werden bei jedem
> Push auf `main` überschrieben.
>
> **EN:** This directory is generated automatically by the GitHub Actions
> workflow. Do **not** edit files here manually — they are overwritten on
> every push to `main`.

---

## DE – Swagger UI starten / EN – How to open Swagger UI

> **Hinweis:** `index.html` kann nicht direkt in GitHub geöffnet werden.
> GitHub zeigt HTML-Dateien nur als Quelltext an. Swagger UI benötigt
> außerdem einen HTTP-Server, da es die API-Spec per `fetch()` lädt —
> das funktioniert nicht über `file://`-URLs im Browser.
>
> **Note:** `index.html` cannot be opened inline on GitHub. GitHub renders
> HTML files as source only. Swagger UI also requires an HTTP server
> because it loads the API spec via `fetch()` — this does not work over
> `file://` URLs in the browser.

---

### ① GitHub Pages ← empfohlen / recommended

Die einfachste und empfohlene Methode. Einmalige Einrichtung:

1. Repository → **Settings → Pages**
2. **Source:** `Deploy from a branch`
3. **Branch:** `main` · **Folder:** `/ui`
4. **Save**

GitHub Pages ist nach ca. 1–2 Minuten aktiv. Die URL lautet dann:

```
https://<organisation>.github.io/<repository>/
```

Ab diesem Zeitpunkt wird die Swagger UI bei jedem Workflow-Run
automatisch aktualisiert.

---

The simplest and recommended method. One-time setup:

1. Repository → **Settings → Pages**
2. **Source:** `Deploy from a branch`
3. **Branch:** `main` · **Folder:** `/ui`
4. **Save**

GitHub Pages becomes active after approx. 1–2 minutes. The URL will be:

```
https://<organisation>.github.io/<repository>/
```

From then on, Swagger UI is updated automatically on every workflow run.

---

### ② Lokal / Locally — `npx serve`

Keine Installation nötig. Im Repository-Root:

```bash
npx serve ui
# → http://localhost:3000
```

---

### ③ Lokal / Locally — Python

```bash
cd ui
python3 -m http.server 8080
# → http://localhost:8080
```

---

### ④ Lokal / Locally — VS Code

Extension **Live Server** (ritwickdey.LiveServer) installieren →
Rechtsklick auf `ui/index.html` → **Open with Live Server**.

---

## DE – Inhalt dieses Verzeichnisses / EN – Directory contents

| Datei / File | Beschreibung / Description |
|---|---|
| `index.html` | Einstiegsseite der Swagger UI / Swagger UI entry page |
| `openapi-bundled.yaml` | Gebündelte API-Spec (alle `$ref`s aufgelöst) / Bundled API spec (all `$ref`s resolved) |
| `swagger-ui-bundle.js` | Swagger UI Hauptbibliothek / Swagger UI main bundle |
| `swagger-ui-standalone-preset.js` | Standalone-Layout-Preset |
| `swagger-ui.css` | Swagger UI Stylesheet |
| `swagger-initializer.js` | Konfiguration: zeigt auf `openapi-bundled.yaml` / Config: points to `openapi-bundled.yaml` |
| `.nojekyll` | Verhindert Jekyll-Verarbeitung durch GitHub Pages / Prevents Jekyll processing by GitHub Pages |

---

## DE – Quelle / EN – Source

Die gebündelte Spec wird aus folgenden Quelldateien erzeugt:

| Quelldatei / Source file | Inhalt / Content |
|---|---|
| `api/malo.yaml` | GPKE Lieferbeginn – alle 7 Prozessschritte, Prüf-IDs 55001–55038 |
| `schema/**` | BDEW UTILMD Schema-Bibliothek |
| `header/**` | EDI@Energy HTTP-Header-Definitionen |

Gebündelt mit **Redocly CLI** · Swagger UI Version **5.17.14**
