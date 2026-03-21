# api/ – API-Spezifikationen / API Specifications

> Deutsch und Englisch in einer README.  
> German and English in one README.

---

## DE – Überblick

Dieses Verzeichnis enthält die vollständigen OpenAPI 3.0 Spezifikationen für die
REST-APIs des GPKE/UTILMD-Projekts. Jede API-Datei ist eine eigenständige,
ausführbare OpenAPI-Spezifikation, die Schemas per `$ref` aus der zentralen
Bibliothek unter `../schema/` und HTTP-Header-Definitionen aus `../header/` bezieht.

## EN – Overview

This directory contains the complete OpenAPI 3.0 specifications for the GPKE/UTILMD
REST APIs. Each API file is a self-contained, executable OpenAPI specification that
references schemas from the central library under `../schema/` and HTTP header
definitions from `../header/`.

---

## Dateien / Files

### `malo.yaml` – GPKE Lieferbeginn (Supply Start / Supplier Change)

Vollständige REST API für den GPKE-Prozess **SD: Lieferbeginn** (GPKE Teil 2, S. 31 ff.).
Deckt alle 7 Prozessschritte zwischen den Marktpartnern LFNeu (LFN), Netzbetreiber (NB),
LFAlt (LFA) und zukünftigem Lieferant (LFZ) ab.

Complete REST API for the GPKE process **SD: Lieferbeginn** (supply start / supplier change,
GPKE Teil 2, p. 31 ff.). Covers all 7 process steps between LFNeu (LFN), grid operator (NB),
LFAlt (LFA) and future supplier (LFZ).

#### Endpunkte / Endpoints

| # | Methode | Pfad | operationId | Prüf-ID | Schritt |
|---|---------|------|-------------|---------|---------|
| 1 | `POST` | `/market-locations/{marketLocationId}/registrations` | `createRegistration` | 55001 / 55077 | 1 – Anmeldung LFN→NB |
| 2 | `GET` | `/market-locations/{marketLocationId}/registrations` | `listRegistrations` | — | Liste |
| 3 | `GET` | `/market-locations/{marketLocationId}/registrations/{supplyStartId}` | `getRegistration` | — | 2 – Existierende Zuordnung |
| 4 | `PATCH` | `/market-locations/{marketLocationId}/registrations/{supplyStartId}` | `patchRegistration` | — | Korrektur (nur draft) |
| 5 | `POST` | `/market-locations/{marketLocationId}/registrations/{supplyStartId}/response` | `respondToRegistration` | 55002 / 55003 / 55078 / 55080 | 5 – Antwort NB→LFN |
| 6 | `POST` | `/market-locations/{marketLocationId}/deregistration-requests` | `createDeregistrationRequest` | 55010 | 3 – Abmeldeanfrage NB→LFA |
| 7 | `POST` | `/market-locations/{marketLocationId}/deregistration-requests/{deregistrationRequestId}/response` | `respondToDeregistrationRequest` | 55011 / 55012 | 4 – Beantwortung LFA→NB |
| 8 | `POST` | `/market-locations/{marketLocationId}/assignment-terminations` | `notifyAssignmentTermination` | 55037 | 6 – Zuordnungsbeendigung NB→LFA |
| 9 | `POST` | `/market-locations/{marketLocationId}/assignment-cancellations` | `notifyAssignmentCancellation` | 55038 | 7 – Zuordnungsaufhebung NB→LFZ |

#### Prozessablauf / Process flow

LFNeu (LFN)              NB (Netzbetreiber)              LFAlt (LFA)           LFZ
     │                          │                              │                  │
     │──(1) POST registrations─▶│                              │                  │
     │◀── 202 Accepted ─────────│                              │                  │
     │                          │──(3) POST dereg-requests────▶│                  │
     │                          │◀─(4) POST …/response ────────│                  │
     │                          │                              │                  │
     │◀─(5a) POST …/response ───│  (Bestätigung PI 55002)      │                  │
     │  oder                    │                              │                  │
     │◀─(5b) POST …/response ───│  (Ablehnung PI 55003)        │                  │
     │                          │                              │                  │
     │                          │──(6) POST assignment-term.──▶│                  │
     │                          │──(7) POST assignment-canc.───────────────────▶  │


#### Vorlauffristen / Lead times (Lieferantenwechsel)

| Identifikationsfall | Vorlauf vor Lieferbeginn |
|---------------------|--------------------------|
| Fall 1 – nur MaLo-ID (`maloIdOnly`) | ≥ 7 Werktage |
| Fall 2 – Adresse / Attribute (`multiAttribute`) | ≥ 10 Werktage |

#### Fristen für NB und LFA / Deadlines for NB and LFA

| Schritt | Frist |
|---------|-------|
| Schritt 3 (Abmeldeanfrage NB→LFA) | Fall 1: bis Ende 1. WT / Fall 2: bis Ende 4. WT nach Eingang |
| Schritt 4 (Antwort LFA→NB) | bis Ende 3. WT nach Eingang der Abmeldeanfrage |
| Schritt 5 (Antwort NB→LFN) | Fall 1: bis Ende 5. WT / Fall 2: bis Ende 8. WT nach Eingang |
| Schritte 6+7 (Beendigung/Aufhebung) | am selben Kalendertag wie Schritt 5 |

---

## Diagramme / Diagrams

### `lieferbeginn-api.drawio`

DrawIO-Prozessdiagramm aller 9 API-Endpunkte als BPMN-Swimlane-Darstellung.
Zeigt Kommunikationsrichtungen, HTTP-Methoden, Pfade und Prüfidentifikatoren
für alle 4 beteiligten Rollen (LFNeu, NB, LFAlt, LFZ).

DrawIO process diagram of all 9 API endpoints as a BPMN swimlane visualization.
Shows communication directions, HTTP methods, paths and check identifiers for all
4 involved roles (LFNeu, NB, LFAlt, LFZ).

Geöffnet mit / Open with: [app.diagrams.net](https://app.diagrams.net) oder VS Code + Draw.io Extension.

---

## DE – Konventionen

- Alle Schemas werden per `$ref` aus `../schema/` bezogen, nie inline dupliziert.
- HTTP-Header (X-Message-ID, Idempotency-Key, ETag, …) werden aus `../header/headers/` referenziert.
- Alle Feldbezeichner und operationIds sind **lowerCamelCase**.
- Beschreibungen sind zweisprachig: Englisch primär, Deutsch in `x-i18n.de`.
- Fehlerantworten verwenden `../schema/common/errorResponse.yaml`.

## EN – Conventions

- All schemas are referenced via `$ref` from `../schema/` and never duplicated inline.
- HTTP headers (X-Message-ID, Idempotency-Key, ETag, …) are referenced from `../header/headers/`.
- All field identifiers and operationIds use **lowerCamelCase**.
- Descriptions are bilingual: English primary, German in `x-i18n.de`.
- Error responses use `../schema/common/errorResponse.yaml`.

---

## Normative Quellen / Normative Sources

- BDEW GPKE – Geschäftsprozesse zur Kundenbelieferung mit Elektrizität (GPKE Teil 2)
- EDI@Energy Anwendungsübersicht der Prüfidentifikatoren v3.1 (01.08.2024, BDEW)
- BDEW UTILMD Anwendungshandbuch Strom 2.1 (11.12.2025)
- [www.bdew-mako.de](https://www.bdew-mako.de)
