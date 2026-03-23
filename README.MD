# GPKE / UTILMD OpenAPI Schema Repository

> Deutsch und Englisch in einer README.  
> German and English in one README.

---

## DE – Überblick

Dieses Repository enthält einen OpenAPI-basierten Schema-Baukasten für die fachliche
Modellierung von GPKE- und UTILMD-nahen Objekten im deutschen Strommarkt.

Der Schwerpunkt liegt auf einer **modularen Struktur**, in der einzelne fachliche
Elemente als eigenständige YAML-Dateien abgelegt und per `$ref` zu größeren Objekten
und API-Sichten zusammengesetzt werden.

Die Verzeichnisse oas30-31Mig und oas31 sind zur Veranschaulichung neuer Funktionen in OAS 3.1
gedacht. Im Unterverzeichnis wird auf die Vorteile von OAS 3.1 eingegangen. Das aktuelle
Schema ist aus Gründen der Komatibiltit zur apiGIT nocht auf OAS 3.0. Der moderne
Editor Stoplight Studio kann jedoch bereits mit OAS 3.1 umgehen.

Die Swagger-UI Dokumentation erhalten Sie unter [![Swagger UI](https://img.shields.io/badge/Swagger_UI-live-85EA2D?logo=swagger)](https://edgar-jung-test.github.io/gpke/)

Abgedeckte Prozesse:

- UTILMD-Stammdatenkommunikation (MaLo, NeLo, MeLo, Bilanzierung, Marktakteure)
- GPKE Lieferbeginn / Lieferantenwechsel (alle 7 Prozessschritte, Prüf-IDs 55001–55038)

## EN – Overview

This repository contains an OpenAPI-based schema building kit for modeling GPKE- and
UTILMD-related business objects in the German electricity market domain.

The main focus is a **modular structure** in which individual business elements are
stored as standalone YAML files and composed via `$ref` into larger domain objects
and API views.

The directories oas30-31Mig and oas31 are intended to illustrate new features in OAS 3.1. 
The corresponding subdirectory explains the advantages of OAS 3.1. For compatibility reasons 
with apiGIT, the current schema is still based on OAS 3.0. However, the modern editor Stoplight Studio
already supports OAS 3.1.

Refer to Swagge-UI Documentation [![Swagger UI](https://img.shields.io/badge/Swagger_UI-live-85EA2D?logo=swagger)](https://edgar-jung-test.github.io/gpke/)

Covered processes:

- UTILMD master data communication (MaLo, NeLo, MeLo, balancing, market actors)
- GPKE supply start / supplier change (all 7 process steps, check identifiers 55001–55038)

---

## Repository-Struktur / Repository Structure

```text
.
├── api/                                  API-Spezifikationen / API specifications
│   │                                     Endpunktdefinitionen für fachliche Prozesse
│   │                                     Endpoint definitions for business processes
│   └── malo.yaml                           GPKE Lieferbeginn – 9 Endpunkte, alle 7 Prozessschritte
│                                           GPKE supply start – 9 endpoints, all 7 process steps
│
├── schema/                               Schema-Bibliothek / Schema library
│   │                                     Zentrale Sammlung aller wiederverwendbaren Fach- und Datenmodell-Schemas
│   │                                     Central collection of all reusable domain and data model schemas
│   ├── openapi.yaml                        Einstiegspunkt: registriert alle Schemas als $ref-Ziele
│   │                                       Entry point: registers all schemas as $ref targets
│   ├── README.md                           Dokumentation der Schema-Bibliothek mit Verzeichnisbaum
│   │                                       Schema library documentation with directory tree
│   │
│   ├── common/                           Gemeinsame Basistypen / Shared base types
│   │                                     Grundlegende, prozessübergreifend wiederverwendbare Datentypen
│   │                                     Fundamental data types reused across all processes
│   │
│   ├── enumerations/                     Aufzählungstypen / Enumeration types
│   │                                     Fachliche Codelisten und Enum-Werte (BDEW, EDI@Energy)
│   │                                     Domain code lists and enum values (BDEW, EDI@Energy)
│   │
│   ├── locations/                        Lokationsobjekte / Location objects
│   │                                     Marktlokation (MaLo), Netzlokation (NeLo), Messlokation (MeLo), Tranche
│   │                                     Market location (MaLo), grid location (NeLo), metering location (MeLo), tranche
│   │
│   ├── marketActors/                     Marktakteure / Market actors
│   │                                     Marktpartner, Rollen, Identifikation und Kommunikationsdaten
│   │                                     Market participants, roles, identification and communication data
│   │
│   ├── metering/                         Messeinrichtungen / Metering devices and registers
│   │                                     Zähler, Gateways, technische Ressourcen, steuerbare Ressourcen und Messregister
│   │                                     Meters, gateways, technical resources, controllable resources and measurement registers
│   │
│   ├── balancing/                        Bilanzierung / Balancing
│   │                                     Regelzonen, Bilanzierungsgebiete, Bilanzkreise, Marktgebiete und Netzkonten
│   │                                     Control areas, balancing areas, balancing groups, market areas and grid accounts
│   │
│   ├── message/                          Nachrichtenstruktur / Message structure
│   │                                     EDIFACT-UTILMD-Nachrichtenheader, Vorgänge, Statusangaben und Prüfidentifikatoren
│   │                                     EDIFACT UTILMD message headers, transactions, status codes and check identifiers
│   │
│   ├── supplyStart/                      GPKE Lieferbeginn / GPKE supply start
│   │                                     Fachdomänenobjekte für den Prozess Lieferbeginn (Anmeldung, Bilanzierung, Stammdaten)
│   │                                     Domain objects for the supply start process (registration, balancing, master data)
│   │
│   └── composed/                         Zusammengesetzte Objekte / Composed objects
│                                         Fertige API-Antwortobjekte aus kombinierten Einzelschemata (z. B. MaLo vollständig)
│                                         Ready-to-use API response objects assembled from individual schemas (e.g. full MaLo)
│
├── header/                               HTTP-Header-Definitionen / HTTP header definitions
│   │                                     Wiederverwendbare EDI@Energy-konforme Request- und Response-Header
│   │                                     Reusable EDI@Energy-compliant request and response headers
│   ├── openapi.yaml                        Einstiegspunkt der Header-Bibliothek
│   │                                       Header library entry point
│   ├── headers/                          Einzelne Header-Dateien / Individual header files
│   │                                     Je eine YAML-Datei pro Header (X-Message-ID, Idempotency-Key, ETag, …)
│   │                                     One YAML file per header (X-Message-ID, Idempotency-Key, ETag, …)
│   ├── groups/                           Header-Gruppen / Header groups
│   │                                     Vordefinierte Gruppen häufig gemeinsam verwendeter Header
│   │                                     Predefined bundles of headers commonly used together
│   └── README.md
│
├── docs/                                 Fachliche Referenzmaterialien / Domain reference materials
│   ├── gpke/                             GPKE-Prozessdiagramme / GPKE process diagrams
│   │                                     Ablaufdiagramme und DrawIO-Quellen für GPKE-Prozesse
│   │                                     Flow diagrams and DrawIO sources for GPKE processes
│   ├── models/                           BDEW-Datenmodell / BDEW data model
│   │                                     ERM-Artefakte, Diagramme und SQL-Schema des BDEW-Rollenmodells
│   │                                     ERM artifacts, diagrams and SQL schema of the BDEW role model
│   └── usage/                            Verwendungsbeispiele / Usage examples
│                                         Dokumentation und Flussdiagramme zur Idempotency-Key-Implementierung
│                                         Documentation and flow diagrams for idempotency key implementation
│
├── oas30-31Mig/                          OAS 3.0 → 3.1 Migrationshilfe / OAS 3.0 → 3.1 migration reference
│                                         Hinweise und Beispiele für die Migration von OAS 3.0 auf 3.1
│                                         Notes and examples for migrating from OAS 3.0 to 3.1
│
├── oas31/                                OAS 3.1 Schema-Varianten / OAS 3.1 schema variants
│                                         Äquivalente Schemata in OpenAPI 3.1-Syntax
│                                         Equivalent schemas expressed in OpenAPI 3.1 syntax
│
├── index.yaml                            Aggregierender Repository-Einstiegspunkt
│                                         Aggregating repository-level entry point
└── README.md                             Diese Datei / This file
```

---

## DE – Einstiegspunkte

| Datei | Zweck |
|-------|-------|
| `schema/openapi.yaml` | Zentrale Schema-Bibliothek – registriert alle Schemas als `$ref`-Ziele |
| `api/malo.yaml` | GPKE Lieferbeginn API – vollständige OpenAPI 3.0 Spezifikation |
| `header/openapi.yaml` | Wiederverwendbare HTTP-Header-Definitionen (EDI@Energy) |
| `index.yaml` | Aggregierender Einstiegspunkt auf Repository-Ebene |
| `docs/security/README.md` | Sicherheitsarchitektur mit Beispielen (DE+EN) |
| `docs/security/security-flow.html` | Interaktives Sicherheitsdiagramm |

## EN – Entry points

| File | Purpose |
|------|---------|
| `schema/openapi.yaml` | Central schema library – registers all schemas as `$ref` targets |
| `api/malo.yaml` | GPKE supply start API – complete OpenAPI 3.0 specification |
| `header/openapi.yaml` | Reusable HTTP header definitions (EDI@Energy) |
| `index.yaml` | Aggregating repository-level entry point |
| `docs/security/README.md` | Security architecture with examples (DE+EN) |
| `docs/security/security-flow.html` | Interactive security flow diagram |

---

## DE – Architekturprinzipien

1. **Atomare Schemata** – Jede fachliche Einheit lebt in einer eigenen YAML-Datei.
2. **Komposition per `$ref`** – Größere Objekte referenzieren atomare Schemata, sie duplizieren keine Inhalte.
3. **lowerCamelCase** – Alle Feldbezeichner, Datei- und Verzeichnisnamen durchgängig.
4. **Zweisprachigkeit** – Englische Feldbezeichner (API-Identifier), deutsche Beschreibungen inhaltlich führend (`x-i18n.de`).
5. **EDIFACT-Rückverfolgbarkeit** – Jedes Schema trägt `x-edifact-mapping` wo fachlich relevant.

## EN – Design principles

1. **Atomic schemas** – Every business entity lives in its own YAML file.
2. **Composition via `$ref`** – Larger objects reference atomic schemas; they never duplicate content.
3. **lowerCamelCase** – All field identifiers, file and directory names consistently.
4. **Bilingual** – English field identifiers (API identifiers), German descriptions are authoritative (`x-i18n.de`).
5. **EDIFACT traceability** – Every schema carries `x-edifact-mapping` where relevant.

---

## DE – Verwendung

```yaml
# Einzelnes Schema referenzieren (aus api/)
$ref: "../schema/locations/marketLocation/marketLocationId.yaml"

# Zusammengesetztes Objekt verwenden
$ref: "../schema/composed/locationBundle.yaml"

# HTTP-Header einbinden
- $ref: "../header/headers/xMessageId.yaml"
```

Empfohlene Werkzeuge: **Redocly CLI**, **Swagger Editor**, **Stoplight Studio**, **Spectral**

## EN – Usage

```yaml
# Reference a single schema (from api/)
$ref: "../schema/locations/marketLocation/marketLocationId.yaml"

# Use a composed object
$ref: "../schema/composed/locationBundle.yaml"

# Include an HTTP header
- $ref: "../header/headers/xMessageId.yaml"
```

Recommended tools: **Redocly CLI**, **Swagger Editor**, **Stoplight Studio**, **Spectral**

---

## DE – Empfohlene Werkzeuge / EN – Recommended Tools

| Tool | Website | Dateitypen / File types | Beispiel / Example | DE – Beschreibung | EN – Description |
|------|---------|-------------------------|--------------------|-------------------|------------------|
| **Stoplight Studio** | [stoplight.io](https://stoplight.io/studio) | `.yaml`, `.json` (OAS 3.0, OAS 3.1) | `api/malo.yaml`, `index.yaml` | Visueller OpenAPI-Editor mit Formular- und Code-Ansicht, Linting via Spectral, $ref-Auflösung und Vorschau. Empfohlener Editor für dieses Repository. | Visual OpenAPI editor with form and code view, Spectral-based linting, $ref resolution and preview. Recommended editor for this repository. |
| **apiGit** | [apigit.io](https://apigit.io) | `.yaml`, `.json` (OAS 3.0) | `index.yaml`, `api/malo.yaml` | Git-natives API-Lifecycle-Tool: versioniert OpenAPI-Spezifikationen direkt im Repository, zeigt Diffs auf Operationsebene und erzwingt Rückwärtskompatibilität. Das aktuelle Schema bleibt aus Kompatibilitätsgründen bei OAS 3.0. | Git-native API lifecycle tool: versions OpenAPI specs directly in the repository, shows operation-level diffs and enforces backwards compatibility. The current schema stays on OAS 3.0 for apiGit compatibility. |
| **Swagger Editor / UI** | [editor.swagger.io](https://editor.swagger.io) | `.yaml`, `.json` (OAS 2.0, OAS 3.0, OAS 3.1) | `api/malo.yaml` | Browser-basierter OpenAPI-Editor mit Live-Vorschau der API-Dokumentation. Swagger UI rendert die Dokumentation als interaktive HTML-Seite. | Browser-based OpenAPI editor with live documentation preview. Swagger UI renders the spec as an interactive HTML page. |
| **Redocly CLI** | [redocly.com/docs/cli](https://redocly.com/docs/cli/) | `.yaml`, `.json` (OAS 3.0, OAS 3.1), `redocly.yaml` | `index.yaml` | Kommandozeilenwerkzeug zum Bündeln (`bundle`), Validieren (`lint`) und Vorschauen (`preview-docs`) von OpenAPI-Spezifikationen. Löst `$ref`-Ketten über Dateigrenzen hinweg auf. | Command-line tool for bundling (`bundle`), validating (`lint`) and previewing (`preview-docs`) OpenAPI specifications. Resolves `$ref` chains across file boundaries. |
| **Spectral** | [stoplight.io/open-source/spectral](https://stoplight.io/open-source/spectral) | `.yaml`, `.json` (OAS), `.mjs` (Ruleset) | `.spectral.mjs` | OpenAPI-Linter mit konfigurierbaren Regelwerken. Wird in diesem Repository über `.spectral.mjs` konfiguriert. Läuft als CLI oder ist in Stoplight Studio integriert. | OpenAPI linter with configurable rulesets. Configured in this repository via `.spectral.mjs`. Runs as CLI or is integrated into Stoplight Studio. |
| **draw.io / diagrams.net** | [app.diagrams.net](https://app.diagrams.net) | `.drawio`, `.xml`, `.svg`, `.png` | `docs/gpke/*.drawio`, `gpke-utilmd.drawio` | Kostenloses Diagrammwerkzeug für Fluss-, Sequenz- und UML-Diagramme. Die GPKE-Prozessdiagramme und das UML-Datenmodell dieses Repositories liegen im `.drawio`-Format vor. | Free diagramming tool for flow, sequence and UML diagrams. The GPKE process diagrams and the UML data model of this repository are stored in `.drawio` format. |
| **Modelio** | [modelio.org](https://www.modelio.org) | `.xmi` (UML 2.x / XMI 2.1), `.eap` | `gpke-utilmd-modelio.xmi` | Kostenloser Open-Source-UML-Editor. Importiert XMI 2.1-Dateien nativ (`File → Import/Export → XMI Import`). Empfohlen zum Bearbeiten und Erweitern des Datenmodells. | Free open-source UML editor. Imports XMI 2.1 files natively (`File → Import/Export → XMI Import`). Recommended for editing and extending the data model. |
| **Enterprise Architect** | [sparxsystems.com](https://sparxsystems.com) | `.eap`, `.eapx`, `.qea`, `.xmi` (UML 2.x) | `gpke-utilmd-model.xml` | Kommerzielles UML-Modellierungswerkzeug. Importiert XMI 2.1 über `File → Import → Import Package from XMI`. Vollständige UML-2-Unterstützung inkl. Code-Generierung. | Commercial UML modelling tool. Imports XMI 2.1 via `File → Import → Import Package from XMI`. Full UML 2 support including code generation. |

---

## DE – Pflegehinweise

- Fachliche Änderungen zuerst auf Schema-Ebene (`schema/`) vornehmen.
- Neue Schemas in `schema/openapi.yaml` unter `components/schemas` registrieren.
- Bei Umbenennungen alle `$ref`-Beziehungen sofort mitpflegen.
- Zusammengesetzte Objekte nur referenzieren, nicht duplizieren.

## EN – Maintenance notes

- Make business changes at schema level (`schema/`) first.
- Register new schemas in `schema/openapi.yaml` under `components/schemas`.
- When renaming files, update all related `$ref` dependencies immediately.
- Composed objects reference only – never duplicate schema content.

---

## Normative Quellen / Normative Sources

- BDEW UTILMD Anwendungshandbuch Strom 2.1 (11.12.2025)
- BDEW GPKE – Geschäftsprozesse zur Kundenbelieferung mit Elektrizität (GPKE Teil 2)
- EDI@Energy Anwendungsübersicht der Prüfidentifikatoren v3.1 (01.08.2024)
- BDEW Codelisten (Marktrollen, Spannungsebenen, OBIS)
- EDIFACT UTILMD S2.1 · IEC 62056-21 (OBIS)
- [www.bdew-mako.de](https://www.bdew-mako.de)

---

## Lizenz / License

Aktuell ist keine explizite Lizenzdatei enthalten. Vor externer Weitergabe oder
öffentlicher Nutzung sollte die gewünschte Lizenz ergänzt werden.

No explicit license file is currently included. Before external distribution or
public use, the intended license should be added.
