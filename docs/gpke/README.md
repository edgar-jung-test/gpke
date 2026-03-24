# docs/gpke/ – GPKE Prozessdokumentation / GPKE Process Documentation

> Deutsch und Englisch in einer README.  
> German and English in one README.

---

## Dateien / Files

### `lieferbeginn-sequenz.html` — API Sequenzdiagramm

Interaktives HTML-Sequenzdiagramm aller 7 Prozessschritte des SD: Lieferbeginn.
Zeigt die Kommunikationsrichtung zwischen allen beteiligten Rollen mit HTTP-Methode,
operationId und Prüfidentifikator direkt an der Linie.

Interactive HTML sequence diagram of all 7 process steps of SD: Lieferbeginn.
Shows the communication direction between all involved roles with HTTP method,
operationId and check identifier directly on the arrow.

**Rollen / Roles:**

| Rolle | Beschreibung | Description |
|-------|-------------|-------------|
| LFNeu (LFN) | Neuer Lieferant | New supplier |
| NB | Netzbetreiber | Grid operator |
| LFAlt (LFA) | Alter Lieferant | Previous supplier |
| LFZ | Zukünftiger Lieferant | Future supplier (optional, only step 7) |

**Dargestellte Schritte / Depicted steps:**

| Schritt | Richtung | API-Endpunkt | Prüf-ID |
|---------|---------|--------------|---------|
| 1 – Anmeldung | LFN → NB | `POST /registrations` | 55001 / 55077 |
| 1 – Korrektur | LFN → NB | `PATCH /registrations/{id}` | — |
| 2 – Existierende Zuordnung | LFN → NB | `GET /registrations/{id}` | — |
| 3 – Abmeldeanfrage | NB → LFA | `POST /deregistration-requests` | 55010 |
| 4 – Beantwortung | LFA → NB | `POST …/response` | 55011 / 55012 |
| 5 – Antwort NB | NB → LFN | `POST …/response` | 55002 / 55003 / 55078 / 55080 |
| 6 – Zuordnungsbeendigung | NB → LFA | `POST /assignment-terminations` | 55037 |
| 7 – Zuordnungsaufhebung | NB → LFZ | `POST /assignment-cancellations` | 55038 |

Öffnen mit jedem modernen Browser. Dark Mode wird automatisch unterstützt.  
Open with any modern browser. Dark mode is automatically supported.

---

### `supplierchange.drawio` — GPKE Prozessdiagramm (Draw.io)

Ursprüngliche grafische Darstellung des Lieferantenwechsel-Prozesses im Draw.io-Format.
Enthält die Swimlane-Darstellung mit BPMN-Elementen. Darüber hinuas haben wir eine 
interaktive <a href="https://htmlpreview.github.io/?https://github.com/edgar-jung-test/gpke/blob/main/docs/gpke/lieferbeginn-sequenz.html" target="_blank" rel="noopener noreferrer">Lieferbeginn</a> zur Verfügung gestellt

In Arbeit befindliche Dokumente:[![SupplieChange.drawio](https://img.shields.io/badge/SupplierChange-blue?style=flat)](https://app.diagrams.net/#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fedgar-jung-test%2Fgpke%2Fmain%2Fdocs%2Fgpke%2Fsupplierchange.drawio), [![Lieferbeginn in draw.io öffnen](https://img.shields.io/badge/draw.io-Lieferbeginn-F08705?style=flat-square)](https://app.diagrams.net/#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fedgar-jung-test%2Fgpke%2Fmain%2Fdocs%2Fgpke%2Flieferbeginn-api.drawio)

Original graphical representation of the supplier change process in Draw.io format.
Contains the swimlane view with BPMN elements. Check out the interactive <a href="https://htmlpreview.github.io/?https://github.com/edgar-jung-test/gpke/blob/main/docs/gpke/lieferbeginn-sequenz.html" target="_blank" rel="noopener noreferrer">supplier-change</a>.

Documents under construction: [![SupplieChange.drawio](https://img.shields.io/badge/SupplierChange-blue?style=flat)](https://app.diagrams.net/#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fedgar-jung-test%2Fgpke%2Fmain%2Fdocs%2Fgpke%2Fsupplierchange.drawio), [![Lieferbeginn.drawio](https://img.shields.io/badge/Lieferbeginn-blue?style=flat)](https://app.diagrams.net/#Uhttps%3A%2F%2Fraw.githubusercontent.com%2Fedgar-jung-test%2Fgpke%2Fmain%2Fdocs%2Fgpke%2Flieferbeginn-api.drawio)

---

## Zusammenhang / Relationship

```
docs/gpke/
  lieferbeginn-sequenz.html   ←  visuelle Dokumentation der API-Kommunikation
  supplierchange.drawio        ←  fachlicher Prozessfluss (BPMN)

api/
  malo.yaml                    ←  normative OpenAPI 3.0 Spezifikation
```

Die HTML-Datei ist die visuelle Begleitdokumentation zur normativen Spezifikation
in `api/malo.yaml`. Bei Abweichungen gilt `malo.yaml`.

The HTML file is the visual companion documentation to the normative specification
in `api/malo.yaml`. In case of discrepancy, `malo.yaml` takes precedence.

---

## Normative Quellen / Normative Sources

- BDEW GPKE – Geschäftsprozesse zur Kundenbelieferung mit Elektrizität (GPKE Teil 2)
- EDI@Energy Anwendungsübersicht der Prüfidentifikatoren v3.1 (01.08.2024, BDEW)
- [www.bdew-mako.de](https://www.bdew-mako.de)
