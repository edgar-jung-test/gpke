# GPKE / UTILMD OpenAPI Schema Repository

> Deutsch und Englisch in einer README.  
> German and English in one README.

---

## DE – Überblick

Dieses Repository enthält einen OpenAPI-basierten Schema-Baukasten für die fachliche Modellierung von GPKE- bzw. UTILMD-nahen Objekten im Strommarktumfeld.  
Der Schwerpunkt liegt auf einer **modularen Struktur**, in der einzelne fachliche Elemente als eigenständige YAML-Dateien abgelegt und anschließend zu größeren Objekten und API-Sichten zusammengesetzt werden.

Die Struktur ist dafür ausgelegt,

- Schemakomponenten wiederzuverwenden,
- zusammengesetzte Geschäftsobjekte sauber zu referenzieren,
- OpenAPI-Dokumente iterativ weiterzuentwickeln,
- und Fachmodell, technische API und Dokumentation klar voneinander zu trennen.

Die im Repository enthaltenen Inhalte orientieren sich an den vorhandenen GPKE-/UTILMD-Artefakten, den Schema-Dateien im Projekt sowie den dokumentierten Fachreferenzen im Ordner `docs/`.

---

## EN – Overview

This repository contains an OpenAPI-based schema building kit for modeling GPKE- and UTILMD-related business objects in the German electricity market domain.  
The main focus is a **modular structure** in which individual business elements are stored as standalone YAML files and then composed into larger domain objects and API views.

The repository structure is intended to

- maximize schema reuse,
- support clean composition of larger business objects,
- enable iterative evolution of OpenAPI documents,
- and separate domain modeling, technical API design, and documentation.

The content in this repository is aligned with the GPKE/UTILMD artifacts, schema files, and supporting reference material contained in the `docs/` directory.

---

## Repository-Struktur / Repository Structure

```text
.
├── api/
│   └── malo.yaml
├── docs/
│   ├── BDEW_Datenmodell_v2.2_ERM.drawio
│   ├── BDEW_Datenmodell_v2.2_ERM.jpg
│   ├── BDEW_ERM_Verbinder.pptx
│   ├── README.MD
│   └── gpke/
├── header/
│   └── X-Message-Id.yaml
├── schema/
│   ├── balancing/
│   ├── common/
│   ├── composed/
│   ├── enumerations/
│   ├── locations/
│   ├── marketActors/
│   ├── message/
│   ├── metering/
│   ├── openapi.yaml
│   └── README.md
├── index.yaml
└── README.md / README.MD
```

### DE – Bedeutung der wichtigsten Verzeichnisse

- `schema/` enthält die fachlichen und technischen Schemakomponenten.
- `schema/common/` enthält wiederverwendbare Basistypen.
- `schema/enumerations/` enthält fachliche Codelisten und Enum-Typen.
- `schema/locations/` bündelt Lokationsobjekte wie MaLo, MeLo, NeLo und Tranche.
- `schema/marketActors/` beschreibt Marktpartner, Rollen und Kommunikationsdaten.
- `schema/metering/` enthält Messgeräte, Register und technische Ressourcen.
- `schema/composed/` enthält zusammengesetzte Objekte für die spätere API-Nutzung.
- `api/` enthält API-nahe Spezifikationen oder erste fachliche Endpunktentwürfe.
- `docs/` enthält fachliche Referenzen, ERM-Artefakte und Bearbeitungsquellen.
- `index.yaml` dient als möglicher Einstiegspunkt für Bündelung oder Tooling.

### EN – Meaning of the main directories

- `schema/` contains the core business and technical schema components.
- `schema/common/` stores reusable base types.
- `schema/enumerations/` contains domain code lists and enum types.
- `schema/locations/` groups location-related objects such as MaLo, MeLo, NeLo, and tranche.
- `schema/marketActors/` describes market participants, roles, and communication data.
- `schema/metering/` contains meters, registers, and technical resources.
- `schema/composed/` contains composed objects intended for API use.
- `api/` stores API-facing specifications or early endpoint drafts.
- `docs/` contains supporting domain references, ERM artifacts, and editable sources.
- `index.yaml` can serve as an aggregation or tooling entry point.

---

## DE – Zielbild

Das Repository verfolgt ein komponentenorientiertes Zielbild:

1. **Atomare Schemata**  
   Kleine, klar abgegrenzte YAML-Dateien für einzelne Fachobjekte oder Teilaspekte.

2. **Komposition statt Monolith**  
   Größere Objekte werden über `$ref` und strukturierte Zusammenführung aufgebaut.

3. **API-Nutzung vorbereiten**  
   Zusammengesetzte Objekte unter `schema/composed/` können als Grundlage für Requests, Responses und Nachrichtenhüllen dienen.

4. **Fachlichkeit nachvollziehbar halten**  
   Die Struktur unterstützt es, fachliche Modelle aus BDEW-/UTILMD-Kontexten systematisch in API-Artefakte zu überführen.

## EN – Target architecture

The repository follows a component-oriented target architecture:

1. **Atomic schemas**  
   Small, clearly scoped YAML files for individual business objects or partial aspects.

2. **Composition instead of monoliths**  
   Larger objects are built using `$ref` and structured composition.

3. **Prepared for API usage**  
   Composed objects under `schema/composed/` can be used as a basis for requests, responses, and message envelopes.

4. **Traceable business semantics**  
   The structure helps map BDEW/UTILMD business models into API artifacts in a systematic way.

---

## DE – Einstieg

Typische Einstiegsdateien:

- `schema/openapi.yaml` – zentraler OpenAPI-Einstieg für die Schema-Bibliothek
- `index.yaml` – zusätzlicher Einstiegspunkt auf Repository-Ebene
- `api/malo.yaml` – API-bezogener Entwurf bzw. Beispiel für eine fachliche Sicht

## EN – Getting started

Typical entry files:

- `schema/openapi.yaml` – central OpenAPI entry point for the schema library
- `index.yaml` – additional top-level entry point at repository level
- `api/malo.yaml` – API-related draft or example of a business-facing view

---

## DE – Verwendung

Zur Arbeit mit dem Repository empfiehlt sich folgendes Vorgehen:

1. Einstiegspunkt auswählen, z. B. `schema/openapi.yaml` oder `index.yaml`.
2. Referenzen mit einem OpenAPI- oder YAML-Tool auflösen.
3. Zusammengesetzte Objekte unter `schema/composed/` für API-Modelle verwenden.
4. Neue Felder oder Teilobjekte möglichst als eigene Dateien ergänzen, damit die Struktur modular bleibt.

## EN – Usage

A typical workflow for using this repository is:

1. Choose an entry point, for example `schema/openapi.yaml` or `index.yaml`.
2. Resolve references with an OpenAPI or YAML-aware tool.
3. Use the composed objects under `schema/composed/` as API-facing models.
4. Add new fields or partial objects as separate files whenever possible to preserve modularity.

---

## DE – Empfohlene Werkzeuge

Geeignet sind unter anderem:

- Swagger Editor
- Redocly CLI
- Stoplight Studio
- Spectral
- OpenAPI Generator

## EN – Recommended tools

Suitable tools include:

- Swagger Editor
- Redocly CLI
- Stoplight Studio
- Spectral
- OpenAPI Generator

---

## DE – Bekannte Punkte / Nächste Schritte

Im aktuellen Stand des Repositories fallen insbesondere folgende Themen auf:

- API-Dateien wie `api/malo.yaml` sollten gegen die referenzierten Schemakomponenten validiert werden.
- Benennungen und Pfade sollten konsistent zwischen `README`, `index.yaml`, `schema/openapi.yaml` und API-Dateien abgestimmt werden.
- Für produktive Nutzung empfiehlt sich ein automatischer Validierungs- und Bundle-Prozess.
- Beispiele, Enums, Required-Felder und Use-Case-spezifische Profiles können weiter geschärft werden.

## EN – Known points / Next steps

At the current state of the repository, the following topics are worth addressing:

- API files such as `api/malo.yaml` should be validated against the referenced schema components.
- Names and paths should be aligned consistently across `README`, `index.yaml`, `schema/openapi.yaml`, and API files.
- For productive use, an automated validation and bundling process is recommended.
- Examples, enums, required fields, and use-case-specific profiles can be refined further.

---

## DE – Pflegehinweise

- Fachliche Änderungen sollten möglichst zuerst auf Schema-Ebene erfolgen.
- Zusammengesetzte Objekte sollten nur referenzieren, nicht fachliche Inhalte duplizieren.
- Dokumentationsartefakte in `docs/` sollten als Referenz und nicht als technische Quelle für Pfadlogik verwendet werden.
- Bei Umbenennungen sollten alle `$ref`-Beziehungen sofort mit angepasst werden.

## EN – Maintenance notes

- Business changes should ideally be implemented first at schema level.
- Composed objects should reference existing schema parts instead of duplicating semantics.
- Artifacts in `docs/` should be treated as reference material, not as the technical source for path logic.
- Whenever files are renamed, all related `$ref` dependencies should be updated immediately.

---

## Lizenz / License

### DE
Aktuell ist in diesem Repository keine explizite Lizenzdatei enthalten.  
Vor externer Weitergabe oder öffentlicher Nutzung sollte die gewünschte Lizenz klar ergänzt werden.

### EN
There is currently no explicit license file in this repository.  
Before external distribution or public use, the intended license should be added explicitly.

---

## Kontakt / Contact

### DE
Für fachliche Rückfragen zur Modellierung, zu Referenzen oder zur API-Struktur sollte ein projektspezifischer Ansprechpartner ergänzt werden.

### EN
For domain-related questions about modeling, references, or API structure, a project-specific contact should be added.
