# BDEW UTILMD Electricity Market – OpenAPI 3.0 Schema

**Version:** 2.1.0  
**Standard:** BDEW UTILMD Anwendungshandbuch (AHB) Strom, Version 2.1 (Stand: 11.12.2025)  
**Basis:** BDEW AWH Rollenmodell ERM · UTILMD AHB Strom 2.1 · SQL ERM Schema  
**Referenz:** [www.bdew-mako.de](https://www.bdew-mako.de)

---

## Übersicht / Overview

Dieses Repository enthält ein vollständiges OpenAPI 3.0 Schema für die BDEW UTILMD
Marktkommunikation Strom. Jedes Feld ist als eigenständige YAML-Datei modelliert, sodass
die Schemata dynamisch zu zusammengesetzten Objekten kombiniert werden können.

This repository contains a complete OpenAPI 3.0 schema for BDEW UTILMD electricity
market communication. Every field is modelled as a standalone YAML file enabling
dynamic composition into larger objects.

---

## Verzeichnisstruktur / Directory Structure

```
openapi.yaml                        ← Root OpenAPI document (entry point)
│
├── common/                         ← Gemeinsame Basistypen / Shared base types
│   ├── address.yaml                  Anschrift / Postal address (EDIFACT NAD)
│   ├── error-response.yaml           Fehlerantwort / Error response
│   ├── multilingual-label.yaml       Mehrsprachige Bezeichnung (EN/DE)
│   ├── obis-code.yaml                OBIS-Kennzahl (IEC 62056-21)
│   ├── paged-response.yaml           Paginierte Antwort / Paginated response
│   ├── product.yaml                  Produkt / Konfigurationsprodukt (EDIFACT PIA)
│   ├── validity-period.yaml          Gültigkeitszeitraum (EDIFACT DTM)
│   └── voltage-level.yaml            Spannungsebene (BDEW Codeliste E02)
│
├── enumerations/                   ← Aufzählungstypen / Enumeration types
│   ├── energy-direction.yaml         Energieflussrichtung (Verbrauch/Erzeugung)
│   ├── location-bundle-type.yaml     Lokationsbündeltyp (ZW6/ZW7/ZAP)
│   ├── market-role-code.yaml         Marktrollencode (NB, LF, MSB, BKV …)
│   ├── message-type.yaml             Nachrichtentyp (BGM DE1001)
│   ├── meter-operator-type.yaml      Messstellenbetreiber-Typ (Z39/Z40/Z41)
│   ├── metering-point-type.yaml      Messstellenart / Lokationstyp (Z01 …)
│   ├── profile-type.yaml             Lastprofiltyp (SLP/SEP/TLP/TEP/RLM)
│   └── transaction-reason.yaml       Transaktionsgrundcode (ZA1 … ZX4)
│
├── market-actors/                  ← Marktakteure / Market participants
│   ├── communication-contact.yaml    Kommunikationsverbindung (EDIFACT CTA/COM)
│   ├── market-actor-id.yaml          Marktpartner-ID / MP-ID (EDIFACT NAD)
│   ├── market-actor-role.yaml        Marktrollen-Zuordnung
│   └── market-actor.yaml             Marktakteur / Marktpartner
│
├── locations/
│   ├── market-location/            ← Marktlokation (MaLo)
│   │   ├── dormant-market-location.yaml   Ruhende MaLo (ZAP, §20 EnWG / §10c EEG)
│   │   ├── market-location-id.yaml        MaLo-ID (11-stellig, EDIFACT LOC Z16)
│   │   ├── market-location-profile.yaml   Lastprofil-Zuordnung (SLP/RLM)
│   │   ├── market-location-status.yaml    Betriebsstatus der MaLo
│   │   └── market-location.yaml           Marktlokation (Hauptobjekt)
│   │
│   ├── grid-location/              ← Netzlokation (NeLo)
│   │   ├── grid-location-id.yaml          NeLo-ID (EDIFACT LOC Z18)
│   │   └── grid-location.yaml             Netzlokation
│   │
│   ├── metering-location/          ← Messlokation (MeLo)
│   │   ├── metering-location-id.yaml      MeLo-ID (EDIFACT LOC Z17)
│   │   └── metering-location.yaml         Messlokation
│   │
│   └── tranche/                    ← Tranche (Teilmengenzuordnung)
│       ├── tranche-id.yaml                Tranchen-ID (EDIFACT LOC Z21)
│       └── tranche.yaml                   Tranche
│
├── metering/
│   ├── devices/                    ← Messgeräte / Metering devices
│   │   ├── communication-device.yaml      Kommunikationseinrichtung
│   │   ├── control-box.yaml               Steuerbox
│   │   ├── control-device.yaml            Steuereinrichtung (z.B. RSE)
│   │   ├── controllable-resource.yaml     Steuerbare Ressource (SR, LOC Z19)
│   │   ├── gateway.yaml                   Smart-Meter-Gateway (SMGW)
│   │   ├── meter-number.yaml              Gerätenummer / Zählernummer
│   │   ├── meter.yaml                     Zähler
│   │   ├── tariff-device.yaml             Tarifeinrichtung (HT/NT)
│   │   ├── technical-resource.yaml        Technische Ressource (TR, LOC Z20)
│   │   ├── transformer-device.yaml        Wandlereinrichtung (Strom-/Spannungswandler)
│   │   └── volume-converter.yaml          Mengenumwerter
│   │
│   └── registers/                  ← Messregister / Measurement registers
│       ├── gateway-register.yaml          Gateway-Register (SMGW-Register)
│       └── meter-register.yaml            Zählerregister
│
├── balancing/                      ← Bilanzierung / Balancing
│   ├── balancing-area.yaml           Bilanzierungsgebiet (EIC)
│   ├── balancing-group.yaml          Bilanzkreis (BKV, EIC)
│   ├── control-area.yaml             Regelzone (ÜNB, EIC)
│   ├── grid-account.yaml             Netzkonto
│   └── market-area.yaml              Marktgebiet (MGV)
│
├── message/                        ← EDIFACT UTILMD Nachrichtenstruktur
│   ├── check-identifier.yaml         Prüfidentifikator (SG6 RFF+Z13)
│   ├── message-header.yaml           Nachrichtenheader (UNB/UNH/BGM/DTM)
│   ├── message-recipient.yaml        Nachrichtenempfänger (NAD MR)
│   ├── message-sender.yaml           Nachrichtensender (NAD MS)
│   ├── message-transaction.yaml      Vorgang (SG4 IDE)
│   ├── transaction-status.yaml       Vorgangsstatus (SG4 STS)
│   └── usage-period.yaml             Verwendungszeitraum (SG6 RFF+Z49/Z53)
│
└── composed/                       ← Zusammengesetzte API-Objekte (fertig nutzbar)
    ├── grid-location-full.yaml       NeLo vollständig (für GET /grid-locations/{id})
    ├── location-bundle.yaml          Lokationsbündel (MaLo + NeLo + MeLo + TR + SR)
    ├── market-actor-full.yaml        Marktakteur vollständig (für GET /market-actors/{id})
    ├── market-location-full.yaml     MaLo vollständig (für GET /market-locations/{id})
    ├── meter-full.yaml               Zähler vollständig mit Registern und Hilfsgeräten
    ├── metering-location-full.yaml   MeLo vollständig mit Geräten
    └── utilmd-message.yaml           UTILMD-Nachricht vollständig (Header + Vorgänge)
```

---

## Mehrsprachigkeit / Multilingual Support

Jedes Feld enthält:
- **Englische Feldbezeichner** (primäre API-Identifier)
- **`x-i18n.de`** – Deutsche Übersetzung der Feldbezeichner und Beschreibungen
- **`label`** – Eingebettetes `MultilingualLabel`-Objekt (`{en, de}`) für dynamische UI-Beschriftungen
- **EDIFACT-Mapping** (`x-edifact-mapping`) – Zuordnung zu UTILMD EDIFACT-Segmenten und Qualifiern

Every field contains:
- **English field identifiers** (primary API identifiers)
- **`x-i18n.de`** – German translation of field names and descriptions
- **`label`** – Embedded `MultilingualLabel` object (`{en, de}`) for dynamic UI labels
- **EDIFACT mapping** (`x-edifact-mapping`) – mapping to UTILMD EDIFACT segments and qualifiers

---

## Verwendung / Usage

### Einzelne Felder referenzieren / Reference individual fields
```yaml
properties:
  maLoId:
    $ref: "./locations/market-location/market-location-id.yaml"
  voltageLevel:
    $ref: "./common/voltage-level.yaml"
```

### Zusammengesetzte Objekte / Composed objects
```yaml
# Vollständiges Lokationsbündel für die API
responses:
  '200':
    content:
      application/json:
        schema:
          $ref: "./composed/location-bundle.yaml"
```

### Dynamische Komposition / Dynamic composition
```yaml
# Nur bestimmte Felder für eine schlanke Antwort
type: object
properties:
  maLoId:
    $ref: "./locations/market-location/market-location-id.yaml"
  status:
    $ref: "./locations/market-location/market-location-status.yaml"
  bundleType:
    $ref: "./enumerations/location-bundle-type.yaml"
```

---

## Wichtige Prüfidentifikatoren / Key Check Identifiers

| Prüf-ID | Kommunikation | Anwendungsfall |
|---------|--------------|----------------|
| 55001   | LF → NB      | Lieferantenwechsel – Anmeldung |
| 55002   | NB → LF      | Lieferantenwechsel – Bestätigung |
| 55003   | NB → LF      | Lieferantenwechsel – Ablehnung |
| 55011   | LF → NB      | Einzug / Neuanlage verbrauchende MaLo |
| 55077   | LF → NB      | Anmeldung erzeugende MaLo |
| 55078   | NB → LF      | Bestätigung Anmeldung erzeugende MaLo |
| 55175   | NB → LF      | Änderung Lokationsbündelstruktur |
| 55218   | NB → LF      | Abrechnungsdaten Netznutzungsabrechnung |
| 55220   | LF → NB      | Anfrage Abrechnungsdaten NNA |
| 55615   | NB → LF      | Änderung Daten der NeLo |
| 55616   | NB → LF      | Änderung Daten der MaLo |
| 55617   | NB → LF      | Änderung Daten der TR |
| 55618   | NB → LF      | Änderung Daten der SR |
| 55619   | NB → LF      | Änderung Daten der Tranche |
| 55620   | NB → LF      | Änderung Daten der MeLo |

---

## Normative Quellen / Normative Sources

- BDEW UTILMD Anwendungshandbuch Strom 2.1 (11.12.2025)
- BDEW AWH Rollenmodell ERM (Strom)
- BDEW Codelisten (Marktrollen, Spannungsebenen, OBIS)
- EDIFACT UTILMD S2.1
- IEC 62056-21 (OBIS)
- [www.bdew-mako.de](https://www.bdew-mako.de)
