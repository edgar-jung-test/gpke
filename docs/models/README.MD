# docs/models/ – BDEW Datenmodell & ERM / BDEW Data Model & ERM

> Deutsch und Englisch in einer README.  
> German and English in one README.

---

## DE – Überblick

Dieses Verzeichnis enthält das Entity-Relationship-Modell (ERM) des BDEW-Rollenmodells
für die Marktkommunikation im deutschen Energiemarkt in Version 2.2. Das Modell basiert
auf dem BDEW UML-Klassendiagramm v2.1 und wurde um Stammdatenfelder aus dem
UTILMD-Anwendungshandbuch Strom 2.1 (11.12.2025) erweitert.

## EN – Overview

This directory contains the Entity-Relationship Model (ERM) of the BDEW role model
for market communication in the German energy market, version 2.2. The model is based
on the BDEW UML class diagram v2.1 and extended with master data fields from the
UTILMD application handbook Strom 2.1 (11.12.2025).

---

## Dateien / Files

| Datei / File | Typ | Beschreibung / Description |
|---|---|---|
| [`BDEW_Datenmodell_v2.2_ERM.jpg`](BDEW_Datenmodell_v2.2_ERM.jpg) | Bild / Image | Vollständiges ERM als Übersichtsgrafik — alle Entitäten und Beziehungen auf einen Blick. / Complete ERM overview — all entities and relationships at a glance. |
| [`BDEW_Datenmodell_v2.2_ERM.drawio`](BDEW_Datenmodell_v2.2_ERM.drawio) | Draw.io | Editierbare Quelle des ERM. Öffnen mit [app.diagrams.net](https://app.diagrams.net). / Editable source of the ERM. Open with [app.diagrams.net](https://app.diagrams.net). |
| [`BDEW_Rollenmodell_v2.2_erweitert.sql`](BDEW_Rollenmodell_v2.2_erweitert.sql) | SQL (MS SQL Server) | Vollständiges DDL-Schema aller Entitäten und Relationen inkl. Lookup-Tabellen. / Full DDL schema of all entities and relations including lookup tables. |
| [`BDEW_ERM_Verbinder.pptx`](BDEW_ERM_Verbinder.pptx) | Präsentation | Erläuterung aller ERM-Verbindertypen mit Crow's-Foot-Notation. / Explanation of all ERM connector types using Crow's Foot notation. |
| [`README_ERM_Verbinder.md`](README_ERM_Verbinder.md) | Dokumentation | Legende aller 52 ERM-Verbindungen: Symbol, Kardinalität, Lesart, Beispiel. / Legend of all 52 ERM connections: symbol, cardinality, reading, example. |

---

## Entitäten / Entities

Das Modell umfasst 47 Tabellen, aufgeteilt in Kern-Entitäten, Lookup-Tabellen und
Verbindungstabellen (Many-to-Many). / The model contains 47 tables, split into core
entities, lookup tables and junction tables (many-to-many).

### Kern-Entitäten / Core Entities

**Lokationen / Locations**

| Entität / Entity | Beschreibung / Description |
|---|---|
| `Marktlokation` | Marktlokation (MaLo) — bilanziell relevante Einheit für Lieferung und Messung. / Market location — the billing-relevant unit for supply and measurement. |
| `Netzlokation` | Netzlokation (NeLo) — physischer Netzanschlusspunkt. / Grid location — physical grid connection point. |
| `Messlokation` | Messlokation (MeLo) — Einheit der Zähldatenerfassung. / Metering location — unit of meter data collection. |
| `Tranche` | Teilmenge einer Marktlokation für Bilanzierungszwecke. / Subset of a market location for balancing purposes. |
| `Netzkopplungspunkt` | Physischer Kopplungspunkt zwischen Netzgebieten. / Physical coupling point between grid areas. |

**Messeinrichtungen / Metering Devices**

| Entität / Entity | Beschreibung / Description |
|---|---|
| `Zaehler` | Physischer Zähler mit Registern. / Physical meter with registers. |
| `Gateway` | Kommunikations-Gateway (Smart-Meter-Gateway). / Communication gateway (smart meter gateway). |
| `Messdatenregistriergeraet` | Gerät zur Registrierung von Messdaten. / Device for recording measurement data. |
| `Wandlereinrichtung` | Wandler (Strom-/Spannungswandler). / Current/voltage transformer. |
| `Tarifeinrichtung` | Tarifschalteinrichtung. / Tariff switching device. |
| `Mengenumwerter` | Mengenumwerter (Gas). / Volume converter (gas). |

**Steuerbare Ressourcen / Controllable Resources**

| Entität / Entity | Beschreibung / Description |
|---|---|
| `TechnischeRessource` | Technische Ressource (Erzeugungsanlage, Speicher). / Technical resource (generation plant, storage). |
| `SteuerbareRessource` | Steuerbare technische Ressource. / Controllable technical resource. |
| `Steuereinrichtung` | Einrichtung zur Steuerung einer Ressource. / Device for controlling a resource. |
| `Steuerbox` | Steuerbox (aggregiert Steuereinrichtungen). / Control box (aggregates control devices). |

**Marktakteure / Market Participants**

| Entität / Entity | Beschreibung / Description |
|---|---|
| `Marktteilnehmer` | Marktpartner mit Marktrolle (NB, LF, MSB, …). / Market participant with market role (NB, LF, MSB, …). |
| `Marktrolle` | Lookup: Marktrolle (NB, LF, MSB, BKV, …). / Lookup: market role. |
| `Kunde` | Endkunde / Anlagenbetreiber. / End customer / plant operator. |
| `Ansprechpartner` | Kommunikationskontakt eines Marktpartners. / Communication contact of a market participant. |

**Netz & Bilanzierung / Grid & Balancing**

| Entität / Entity | Beschreibung / Description |
|---|---|
| `Netzgebiet` | Netzgebiet eines Netzbetreibers. / Grid area of a grid operator. |
| `Regelzone` | Regelzone des Übertragungsnetzbetreibers. / Control area of the transmission system operator. |
| `Bilanzkreis` | Bilanzkreis eines Bilanzkreisverantwortlichen. / Balancing group of a balancing group manager. |
| `Bilanzierungsgebiet` | Bilanzierungsgebiet (Prognosegebiet). / Balancing area (forecast area). |
| `Marktgebiet` | Marktgebiet (Gas). / Market area (gas). |
| `Netzkonto` | Netzkonto für Bilanzierungszwecke. / Grid account for balancing purposes. |

**Adressen / Addresses**

| Entität / Entity | Beschreibung / Description |
|---|---|
| `Adresse` | Postalische Adresse. / Postal address. |
| `Korrespondenzadresse` | Korrespondenzadresse eines Marktteilnehmers. / Correspondence address of a market participant. |

### Lookup-Tabellen / Lookup Tables

| Tabelle / Table | Inhalt / Content |
|---|---|
| `LK_Spannungsebene` | Spannungsebenen (E03 Höchstspannung … E08 Niederspannung) / Voltage levels |
| `LK_Lieferrichtung` | Lieferrichtung (Einspeisung / Entnahme) / Supply direction |
| `LK_MSBTyp` | Typ des Messstellenbetreibers / Type of metering point operator |
| `LK_MesstechnischeEinordnung` | Messtechnische Einordnung / Metering classification |
| `LK_Prognosegrundlage` | Prognosegrundlage (SLP, RLM, …) / Forecast basis |
| `LK_Verbrauchsart` | Verbrauchsart / Type of consumption |
| `LK_ArtErzeugendeMaLo` | Art der erzeugenden MaLo / Type of generating market location |
| `LK_Veraeusserungsform` | Veräußerungsform (Direktvermarktung, …) / Marketing form |
| `LK_Laendercode` | Ländercodes (ISO 3166) / Country codes |

### Verbindungstabellen / Junction Tables

| Tabelle / Table | Beziehung / Relation |
|---|---|
| `Marktlokation_Messlokation` | MaLo ↔ MeLo (n:m) |
| `Marktlokation_TechnischeRessource` | MaLo ↔ TechnischeRessource (n:m) |
| `Kunde_Marktlokation` | Kunde ↔ MaLo (n:m) |
| `Bilanzierungsgebiet_Netzgebiet` | Bilanzierungsgebiet ↔ Netzgebiet (n:m) |
| `Netzgebiet_Netzkopplungspunkt` | Netzgebiet ↔ Netzkopplungspunkt (n:m) |
| `Register_Zaehler` | Register ↔ Zähler |
| `Register_Gateway` | Register ↔ Gateway |
| `Register_Messdatenregistriergeraet` | Register ↔ Messdatenregistriergerät |
| `Register_Mengenumwerter` | Register ↔ Mengenumwerter |
| `SteuerbareRessource_Steuereinrichtung` | SteuerbareRessource ↔ Steuereinrichtung |
| `SteuerbareRessource_Steuerbox` | SteuerbareRessource ↔ Steuerbox |

---

## ERM-Verbindertypen / ERM Connector Types

Das ERM verwendet Crow's-Foot-Notation mit 6 Verbindertypen über 52 Verbindungen.
/ The ERM uses Crow's Foot notation with 6 connector types across 52 connections.

| Verbindertyp | Symbol | Kardinalität | Anzahl / Count |
|---|---|---|---|
| 1:N (Pflicht) | `‖————‖<` | Genau 1 → 1 oder viele | 30 |
| 0..1:0..N (Optional) | `○\|————○<` | 0 oder 1 → 0 oder viele | 13 |
| 1:0..1 (Exklusiv) | `‖————○\|` | Genau 1 → 0 oder 1 | 4 |
| 1:0..N (Pflicht-Optional) | `‖————○<` | Genau 1 → 0 oder viele | 2 |
| 0..1:0..1 (XOR) | `○\|————○\|` | 0 oder 1 → 0 oder 1 | 2 |
| 0..1:N (Selten) | `○\|————‖<` | 0 oder 1 → 1 oder viele | 1 |

Vollständige Beschreibung aller 52 Verbindungen: [`README_ERM_Verbinder.md`](README_ERM_Verbinder.md)

---

## SQL-Schema / SQL Schema

Die Datei `BDEW_Rollenmodell_v2.2_erweitert.sql` ist ein vollständiges DDL-Skript
für Microsoft SQL Server. Es enthält alle `CREATE TABLE`-Anweisungen, Primary Keys,
Foreign Keys, Unique Constraints und vorausgefüllte Lookup-Tabellen.

The file `BDEW_Rollenmodell_v2.2_erweitert.sql` is a complete DDL script for
Microsoft SQL Server. It contains all `CREATE TABLE` statements, primary keys,
foreign keys, unique constraints and pre-populated lookup tables.

**Erweiterungen gegenüber BDEW v2.1 / Extensions vs. BDEW v2.1:**

- Stammdatenfelder aus UTILMD SG8/SG10 extrahiert / Master data fields extracted from UTILMD SG8/SG10
- Adresstabellen (Marktlokationsadresse, Korrespondenzadresse) / Address tables
- Ansprechpartner und Kommunikationsadressen / Contact persons and communication addresses
- Netzlokation und Tranche als eigene Entitäten / Grid location and tranche as separate entities
- Vollständige Lookup-Tabellen für EDIFACT-Codes / Complete lookup tables for EDIFACT codes

**Ausführung / Execution:**

```sql
-- SQL Server Management Studio oder sqlcmd
sqlcmd -S <server> -d <database> -i BDEW_Rollenmodell_v2.2_erweitert.sql
```

---

## Zusammenhang mit dem Repository / Relation to the Repository

```
docs/models/
  BDEW_Datenmodell_v2.2_ERM.drawio   ←  editierbares ERM-Quelldiagramm
  BDEW_Datenmodell_v2.2_ERM.jpg      ←  Übersichtsgrafik
  BDEW_Rollenmodell_v2.2_erweitert.sql ←  DDL-Schema (MS SQL Server)
  BDEW_ERM_Verbinder.pptx            ←  Verbinder-Erläuterungen
  README_ERM_Verbinder.md            ←  Legende aller 52 Verbindungen

schema/
  locations/marketLocation/          ←  MaLo als OpenAPI-Schema
  locations/gridLocation/            ←  NeLo als OpenAPI-Schema
  locations/meteringLocation/        ←  MeLo als OpenAPI-Schema
  locations/tranche/                 ←  Tranche als OpenAPI-Schema
  metering/devices/                  ←  Messeinrichtungen als OpenAPI-Schemas
  marketActors/                      ←  Marktakteure als OpenAPI-Schemas
  balancing/                         ←  Bilanzierung als OpenAPI-Schemas
```

Das ERM beschreibt das fachliche Datenmodell. Die OpenAPI-Schemas in `schema/` sind
die technische Umsetzung desselben Modells — bei Abweichungen gelten die YAML-Dateien.

The ERM describes the domain data model. The OpenAPI schemas in `schema/` are the
technical implementation of the same model — in case of discrepancy, the YAML files
take precedence.

---

## Normative Quellen / Normative Sources

- BDEW Rollenmodell Marktkommunikation Energiemarkt v2.1 (UML-Klassendiagramm)
- BDEW UTILMD Anwendungshandbuch Strom 2.1 (11.12.2025)
- BDEW GPKE – Geschäftsprozesse zur Kundenbelieferung mit Elektrizität (Teil 2)
- EDI@Energy Anwendungsübersicht der Prüfidentifikatoren v3.1 (01.08.2024)
- [www.bdew-mako.de](https://www.bdew-mako.de)
