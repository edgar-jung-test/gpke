# docs/ – Fachliche Dokumentation / Domain Documentation

> Deutsch und Englisch in einer README.  
> German and English in one README.

---

## DE – Überblick

Dieses Verzeichnis enthält die begleitende Dokumentation zum GPKE/UTILMD-OpenAPI-Repository.
Es umfasst Prozessdiagramme, Sicherheitsarchitektur, Datenmodelle und Implementierungsanleitungen.
Alle Inhalte ergänzen die normativen Spezifikationen in `api/` und `schema/` — bei Abweichungen
gelten die YAML-Dateien.

## EN – Overview

This directory contains the companion documentation for the GPKE/UTILMD OpenAPI repository.
It covers process diagrams, security architecture, data models and implementation guides.
All content supplements the normative specifications in `api/` and `schema/` — in case of
discrepancy, the YAML files take precedence.

---

## Verzeichnisstruktur / Directory Structure

```
docs/
├── gpke/               GPKE Prozessdiagramme / GPKE process diagrams
├── security/           API-Sicherheitsarchitektur / API security architecture
├── models/             BDEW Datenmodell & ERM / BDEW data model & ERM
└── usage/              Verwendungsanleitungen & API-Architektur / Usage guides & API architecture
```

---

## gpke/ — GPKE Prozessdokumentation

**SD: Lieferbeginn (Lieferantenwechsel) · GPKE Teil 2 · Prüf-IDs 55001–55038**

| Datei / File | Typ | Beschreibung / Description |
|---|---|---|
| [lieferbeginn-sequenz.html](https://htmlpreview.github.io/?https://github.com/edgar-jung-test/gpke/blob/main/docs/gpke/lieferbeginn-sequenz.html) | Lieferbeginn | Sequenzdiagramm aller 7 Prozessschritte. Pfeile zeigen Kommunikationsrichtung (LFNeu ↔ NB ↔ LFAlt/LFZ). Jeden Pfeil anklicken für Endpunkt-Details. / Sequence diagram of all 7 process steps. Click any arrow for endpoint details. |
| [`supplierchange.drawio`](gpke/supplierchange.drawio) | Draw.io | Ursprüngliches BPMN-Swimlane-Diagramm des Lieferantenwechselprozesses. / Original BPMN swimlane diagram of the supplier change process. |
| [`lieferbeginn-api.drawio`](gpke/lieferbeginn-api.drawio) | Draw.io | API-Endpunkte als Swimlane-Darstellung (alle 9 Endpunkte, alle 4 Rollen). / API endpoints as swimlane visualization (all 9 endpoints, all 4 roles). |
| [`README.md`](gpke/README.md) | Dokumentation | Schritt-Tabelle, Rollenerklärung, Zusammenhang zu `api/malo.yaml`. / Step table, role descriptions, relation to `api/malo.yaml`. |

**Beteiligte Rollen / Involved roles:**

| Kürzel | Rolle | Description |
|---|---|---|
| LFNeu (LFN) | Neuer Lieferant | New supplier |
| NB | Netzbetreiber | Grid operator |
| LFAlt (LFA) | Alter Lieferant | Previous/old supplier |
| LFZ | Zukünftiger Lieferant | Future supplier (step 7 only) |

> Normative Spezifikation: [`api/malo.yaml`](../api/malo.yaml)  
> Interactive diagram online: [htmlpreview.github.io](https://htmlpreview.github.io/?https://github.com/edgar-jung-test/gpke/blob/main/docs/gpke/lieferbeginn-sequenz.html)

---

## security/ — API-Sicherheitsarchitektur

**HTTP Message Signatures · JWS · JWE · OAuth 2.0**

| Datei / File | Typ | Beschreibung / Description |
|---|---|---|
| [`security-flow.html`](security/security-flow.html) | HTML interaktiv | Interaktives Sicherheitsdiagramm mit 7 Tabs: Übersicht (Schichtenarchitektur), Schichten (aufklappbar), GET-Beispiel, POST+JWS, POST+JWE, Header-Referenz, Fehlercodes. / Interactive security diagram with 7 tabs. |
| [`README.md`](security/README.md) | Dokumentation | Vollständige Beschreibung aller 4 Sicherheitsschichten mit Beispielen, Schlüsselverwaltung, Verarbeitungsreihenfolge und Fehlercodes (DE+EN). / Full description of all 4 security layers (DE+EN). |
| [`20260202_API_Security.pptx`](security/20260202_API_Security.pptx) | Präsentation | Ursprüngliche Sicherheitspräsentation (Quellmaterial). / Original security presentation (source material). |

**Sicherheitsschichten / Security layers:**

| Layer | Mechanismus | RFC | Wo / Where |
|---|---|---|---|
| 1 | OAuth 2.0 Bearer JWT | RFC 7519 | `Authorization` header — alle Anfragen |
| 2 | JWS Payload-Signatur | RFC 7515 | Request Body — POST/PATCH |
| 3 | JWE Payload-Verschlüsselung | RFC 7516 | Request Body — optional, `Content-Type: application/jose` |
| 4 | HTTP Message Signature | RFC 9421 | `Signature` + `Signature-Input` + `Content-Digest` — alle Anfragen |

> Header-Definitionen: [`header/headers/signature.yaml`](../header/headers/signature.yaml) · [`signatureInput.yaml`](../header/headers/signatureInput.yaml) · [`contentDigest.yaml`](../header/headers/contentDigest.yaml)

---

## models/ — BDEW Datenmodell & ERM

**BDEW Rollenmodell v2.2 · Entity-Relationship-Modell**

| Datei / File | Typ | Beschreibung / Description |
|---|---|---|
| [`BDEW_Datenmodell_v2.2_ERM.jpg`](models/BDEW_Datenmodell_v2.2_ERM.jpg) | Bild / Image | Vollständiges ERM des BDEW-Rollenmodells v2.2 als Übersichtsgrafik. / Complete ERM of the BDEW role model v2.2 as overview graphic. |
| [`BDEW_Datenmodell_v2.2_ERM.drawio`](models/BDEW_Datenmodell_v2.2_ERM.drawio) | Draw.io | Editierbare Draw.io-Quelle des ERM. / Editable Draw.io source of the ERM. |
| [`BDEW_Rollenmodell_v2.2_erweitert.sql`](models/BDEW_Rollenmodell_v2.2_erweitert.sql) | SQL | SQL-Schema des erweiterten Rollenmodells (alle Entitäten und Relationen). / SQL schema of the extended role model (all entities and relations). |
| [`BDEW_ERM_Verbinder.pptx`](models/BDEW_ERM_Verbinder.pptx) | Präsentation | Erläuterung der ERM-Verbinder und Kardinalitäten (Crow's Foot Notation). / Explanation of ERM connectors and cardinalities (Crow's Foot notation). |
| [`README_ERM_Verbinder.md`](models/README_ERM_Verbinder.md) | Dokumentation | Legende aller 52 ERM-Verbindungstypen mit Symbol, Bedeutung und Beispielen. / Legend of all 52 ERM connection types with symbol, meaning and examples. |
| [`README.MD`](models/README.MD) | Dokumentation | Verzeichnisübersicht. / Directory overview. |

> Werkzeug / Tool: [app.diagrams.net](https://app.diagrams.net) (kostenlos, online und Desktop)

---

## usage/ — Verwendungsanleitungen & API-Architektur

**Implementierungsdetails, Muster und Architekturentscheidungen / Implementation details, patterns and architecture decisions**

| Datei / File | Typ | Beschreibung / Description |
|---|---|---|
| [`api-ansaetze-vergleich.html`]([usage](https://htmlpreview.github.io/?https://github.com/edgar-jung-test/gpke/blob/main/docs/api-ansaetze-vergleich.html) | API Ansätze | Interaktiver Vergleich der drei API-Architekturansätze (REST · RPC · Frankenstein). 5 Tabs: Kommunikationsfluss je Ansatz, vollständiger Kriterienkatalog, Fazit mit Empfehlung. / Interactive comparison of three API architecture approaches with flow diagrams, criteria table and summary. |
| [`Idempotency_Key_Documentation.md`](usage/Idempotency_Key_Documentation.md) | Dokumentation | Vollständige Beschreibung des `Idempotency-Key`-Headers: Funktionsweise, Server-Verarbeitung, Retry-Semantik, Fehlerszenarien und OpenAPI-Schema (DE+EN). / Full description of the `Idempotency-Key` header including retry semantics and error scenarios (DE+EN). |
| [`Idempotency_Key_Process_Flow.drawio`](usage/Idempotency_Key_Process_Flow.drawio) | Draw.io | Prozessablauf-Diagramm für Idempotency-Key-Verarbeitung inkl. Retry-Pfade. / Process flow diagram for Idempotency-Key handling including retry paths. |
| [`Idempotency_Key_Process_Flow-Retry Process.jpg`](usage/Idempotency_Key_Process_Flow-Retry%20Process.jpg) | Bild / Image | Exportierte Grafik des Retry-Prozessablaufs. / Exported graphic of the retry process flow. |

### API-Architekturansätze im Überblick / API Architecture Approaches Overview

| Ansatz / Approach | Prinzip | Empfehlung |
|---|---|---|
| **REST API** | Ressourcen + HTTP-Verben · Request-Response · ETag-Zustand | Empfohlen |
| **RPC API** | Prozeduraufrufe · aktionsorientiert · gRPC/JSON-RPC | Situationsabhängig |
| **Frankenstein API** | UTILMD-Nachrichten per POST · HTTP als reines Transportmedium | Nicht empfohlen |

> Der Frankenstein-Ansatz tauscht nur den Transportweg (AS4/E-Mail → HTTPS), behält aber EDIFACT-Prozesslogik und -Datenstrukturen vollständig bei. HTTP degeneriert zum reinen Transportrohr — alle Vorteile moderner APIs (Request-Response, sofortige Validierung, Zustandsverwaltung, Caching, Tooling) gehen verloren.
>
> The Frankenstein approach only replaces the transport channel (AS4/e-mail → HTTPS) while keeping EDIFACT process logic and data structures intact. HTTP degrades to a mere pipe — all benefits of modern APIs are lost.

---

## Zusammenhang mit dem Repository / Relation to the Repository

```
docs/                        ←  Begleitdokumentation / Companion documentation
  gpke/                      ←  GPKE-Prozessdiagramme (Lieferbeginn, 7 Schritte)
  security/                  ←  Sicherheitsarchitektur (JWS, JWE, RFC 9421)
  models/                    ←  BDEW Datenmodell (ERM v2.2)
  usage/                     ←  Implementierungsanleitungen + API-Architekturentscheidungen

api/
  malo.yaml                  ←  Normative OpenAPI 3.0 Spezifikation (GPKE Lieferbeginn)

schema/                      ←  Wiederverwendbare Schema-Bibliothek (MaLo, NeLo, UTILMD)
header/                      ←  HTTP-Header-Definitionen (inkl. Sicherheits-Header RFC 9421)
index.yaml                   ←  Repository-Einstiegspunkt (aggregiert alle APIs und Schemas)
```

**Grundsatz / Principle:** Dokumentation beschreibt — YAML-Spezifikationen schreiben vor.  
Bei Widersprüchen zwischen `docs/` und `api/`/`schema/` gelten immer die YAML-Dateien.

*Documentation describes — YAML specifications prescribe.  
In case of contradiction between `docs/` and `api/`/`schema/`, the YAML files always take precedence.*

---

## Öffnen der Dateien / Opening Files

| Format | Werkzeug / Tool |
|---|---|
| `.html` | Jeder moderne Browser (Firefox, Chrome, Safari, Edge) — Dark Mode automatisch |
| `.drawio` | [app.diagrams.net](https://app.diagrams.net) (Web) oder [Draw.io Desktop](https://www.drawio.com) |
| `.pptx` | Microsoft PowerPoint oder [LibreOffice Impress](https://www.libreoffice.org) |
| `.sql` | Jeder SQL-Editor (DBeaver, DataGrip, psql, …) |
| `.md` | GitHub rendert direkt · VS Code + Markdown Preview · Obsidian |

---

## Normative Quellen / Normative Sources

| Quelle / Source | Relevanz / Relevance |
|---|---|
| BDEW GPKE – Geschäftsprozesse zur Kundenbelieferung mit Elektrizität (Teil 2) | `gpke/` |
| EDI@Energy Anwendungsübersicht der Prüfidentifikatoren v3.1 (01.08.2024) | `gpke/` |
| BDEW UTILMD Anwendungshandbuch Strom 2.1 (11.12.2025) | `models/` |
| RFC 9421 – HTTP Message Signatures | `security/` |
| RFC 7515 / 7516 – JWS / JWE | `security/` |
| RFC 9530 – Digest Fields | `security/` |
| RFC 8694 – Idempotency-Key | `usage/` |
| [www.bdew-mako.de](https://www.bdew-mako.de) | Alle / All |
