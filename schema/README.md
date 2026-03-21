# BDEW UTILMD Electricity Market – OpenAPI 3.0 Schema

**Version:** 2.1.0  
**Standard:** BDEW UTILMD Anwendungshandbuch (AHB) Strom, Version 2.1 (Stand: 11.12.2025)  
**Referenz:** [www.bdew-mako.de](https://www.bdew-mako.de)

---

## Übersicht / Overview

Dieses Verzeichnis enthält ein vollständiges OpenAPI 3.0 Schema für die BDEW UTILMD
Marktkommunikation Strom sowie den GPKE-Prozess Lieferbeginn.
Jedes Schema ist als eigenständige YAML-Datei modelliert und kann per `$ref` in
beliebige API-Spezifikationen eingebunden werden.

This directory contains a complete OpenAPI 3.0 schema for BDEW UTILMD electricity
market communication and the GPKE supply-start process.
Every schema is a standalone YAML file referenceable via `$ref`.

> **Namenskonvention / Naming convention:** Alle Dateinamen, Verzeichnisnamen und
> Feldbezeichner sind in **lowerCamelCase** gehalten.  
> All file names, directory names and field identifiers use **lowerCamelCase**.

---

## Verzeichnisstruktur / Directory Structure

```
openapi.yaml                              ← Root OpenAPI 3.0 document (entry point)
│
├── common/                               Gemeinsame Basistypen / Shared base types
│   ├── address.yaml                        Postal address (EDIFACT NAD)
│   ├── errorResponse.yaml                  Standardized API error response
│   ├── multilingualLabel.yaml              Multilingual label (EN / DE)
│   ├── obisCode.yaml                       OBIS measurement code (EDIFACT PIA / CCI)
│   ├── pagedResponse.yaml                  Generic paginated list wrapper
│   ├── product.yaml                        Supply / configuration product (EDIFACT PIA)
│   ├── validityPeriod.yaml                 Temporal validity range (EDIFACT DTM)
│   └── voltageLevel.yaml                   Grid connection voltage level (EDIFACT CCI/CAV)
│
├── enumerations/                         Aufzählungstypen / Enumeration types
│   ├── deregistrationCase.yaml             caseA · caseB
│   ├── energyDirection.yaml                CONSUMPTION · GENERATION
│   ├── identificationMode.yaml             maloIdOnly · multiAttribute
│   ├── locationBundleType.yaml             ZW6 · ZW7 · ZAP
│   ├── marketRoleCode.yaml                 NB · LF · MSB · BKV · BIKO · UeNB · UNB · ESA · DP · MGV · BTR · EIV · EOG · RB · NBA · NBN · MR · MS
│   ├── messageType.yaml                    E01 · E02 · E03 · E04 · E05 · E06
│   ├── meterOperatorType.yaml              Z39 · Z40 · Z41 · Z19 · Z20
│   ├── meterReadingCycle.yaml              yearly · semiAnnual · quarterly · monthly
│   ├── meteringPointType.yaml              Z01 · Z02 · Z06 · Z07 · Z08 · Z09 · Z10 · Z98
│   ├── profileType.yaml                    SLP · SEP · TLP · TEP · RLM
│   ├── supplyStartStatus.yaml              draft · submitted · accepted · rejected · cancelled
│   ├── terminationReason.yaml              supplierChange · moveOut · decommissioning · priorRegistration
│   └── transactionReason.yaml              ZA1–ZA9 · ZW0–ZW9 · ZX0 · ZX1 · ZX4 · E01 · E03
│
├── marketActors/                         Marktakteure / Market participants
│   ├── communicationContact.yaml           Contact details of a market participant (EDIFACT CTA)
│   ├── marketActor.yaml                    Market participant / Marktpartner (EDIFACT NAD)
│   ├── marketActorId.yaml                  MP-ID with coding scheme (EDIFACT NAD DE3039/DE3055)
│   └── marketActorRole.yaml                Market role assignment with validity period
│
├── locations/
│   ├── marketLocation/                   Marktlokation (MaLo)
│   │   ├── dormantMarketLocation.yaml      Dormant MaLo – ruhende Marktlokation (§20 EnWG)
│   │   ├── marketLocation.yaml             Market location – central UTILMD object (EDIFACT LOC Z16)
│   │   ├── marketLocationId.yaml           11-digit MaLo-ID (scalar string)
│   │   ├── marketLocationProfile.yaml      SLP / RLM load profile assignment
│   │   └── marketLocationStatus.yaml       ACTIVE · DORMANT · DISCONNECTED · DECOMMISSIONED
│   │
│   ├── gridLocation/                     Netzlokation (NeLo)
│   │   ├── gridLocation.yaml               Grid connection point (EDIFACT LOC Z18)
│   │   └── gridLocationId.yaml             NeLo-ID (scalar string)
│   │
│   ├── meteringLocation/                 Messlokation (MeLo)
│   │   ├── meteringLocation.yaml           Physical measurement point (EDIFACT LOC Z17)
│   │   └── meteringLocationId.yaml         MeLo-ID (scalar string)
│   │
│   └── tranche/                          Tranche (Teilmengenzuordnung)
│       ├── tranche.yaml                    Partial quantity allocation for generating MaLo (LOC Z21)
│       └── trancheId.yaml                  Tranchen-ID (scalar string)
│
├── metering/
│   ├── devices/                          Messgeräte / Metering devices
│   │   ├── communicationDevice.yaml        Communication device attached to a meter
│   │   ├── controlBox.yaml                 Control box for remote load management
│   │   ├── controlDevice.yaml              Control device (RSE, TSU, SMGW)
│   │   ├── controllableResource.yaml       Controllable resource / SR (EDIFACT LOC Z19)
│   │   ├── gateway.yaml                    Smart meter gateway (SMGW)
│   │   ├── meter.yaml                      Electricity meter (EDIFACT EQD)
│   │   ├── meterNumber.yaml                Device / meter number (scalar string, EDIFACT EQD / SEQ)
│   │   ├── tariffDevice.yaml               Tariff device (HT/NT switching)
│   │   ├── technicalResource.yaml          Technical resource / TR (EDIFACT LOC Z20)
│   │   ├── transformerDevice.yaml          Current / voltage transformer (Wandlereinrichtung)
│   │   └── volumeConverter.yaml            Volume converter (Mengenumwerter)
│   │
│   └── registers/                        Messregister / Measurement registers
│       ├── gatewayRegister.yaml            SMGW register / Gateway-Register
│       └── meterRegister.yaml              Meter register / Zählerregister
│
├── balancing/                            Bilanzierung / Balancing
│   ├── balancingArea.yaml                  Balancing area / Bilanzierungsgebiet (EIC)
│   ├── balancingGroup.yaml                 Balancing group / Bilanzkreis (EIC)
│   ├── controlArea.yaml                    Control area / Regelzone (ÜNB, EIC)
│   ├── gridAccount.yaml                    Grid account / Netzkonto
│   └── marketArea.yaml                     Market area / Marktgebiet (MGV)
│
├── message/                              EDIFACT UTILMD Nachrichtenstruktur
│   ├── checkIdentifier.yaml                Prüfidentifikator (EDIFACT SG6 RFF+Z13)
│   ├── messageHeader.yaml                  Message header – UNB / UNH / BGM / DTM
│   ├── messageRecipient.yaml               Message recipient (EDIFACT SG2 NAD+MR)
│   ├── messageSender.yaml                  Message sender (EDIFACT SG2 NAD+MS)
│   ├── messageTransaction.yaml             Single transaction / Vorgang (EDIFACT SG4 IDE)
│   ├── transactionStatus.yaml              Transaction status – E01 / E02 / E03 (EDIFACT SG4 STS)
│   └── usagePeriod.yaml                    Usage period / Verwendungszeitraum (EDIFACT SG6 RFF+Z49/Z53)
│
├── supplyStart/                          GPKE Lieferbeginn – Supply start domain objects
│   ├── balancingAssignment.yaml            Balancing group + authorization reference (EDIFACT SG6 CAV/CCI)
│   ├── marketLocationIdentification.yaml   MaLo identification by ID or address (GPKE case 1 / 2)
│   ├── masterDataResponse.yaml             Master data returned by NB on confirmation (Prüf-ID 55002/55078)
│   ├── rejectionReason.yaml                Rejection / objection reason (NB or LFA)
│   ├── supplyStart.yaml                    Full supply start request resource
│   └── supplyStartList.yaml                Paginated list of supply start requests
│
└── composed/                             Zusammengesetzte API-Objekte / Ready-to-use response objects
    ├── gridLocationFull.yaml               Full NeLo response (GET /grid-locations/{neLoId})
    ├── locationBundle.yaml                 Complete location bundle: MaLo + NeLo + MeLo + TR + SR
    ├── marketActorFull.yaml                Full market actor response (GET /market-actors/{id})
    ├── marketLocationFull.yaml             Full MaLo response (GET /market-locations/{maLoId})
    ├── meterFull.yaml                      Full meter response including registers and auxiliary devices
    ├── meteringLocationFull.yaml           Full MeLo response including installed meters and gateways
    └── utilmdMessage.yaml                  Complete UTILMD message: header + transactions + location bundles
```

---

## Mehrsprachigkeit / Multilingual Support

Jedes Feld enthält drei Ebenen / Every field contains three layers:

```yaml
maLoId:
  description: "English description (primary)"
  x-i18n:
    de:
      description: "Deutsche Beschreibung (führend/maßgeblich)"
  examples:
    Residential:
      summary: "Residential"
      value: "51238696781"
  x-examples-i18n:
    de:
      Residential: "Haushalt"
  label:
    $ref: "./common/multilingualLabel.yaml"
```

**Reihenfolge / Priority:** Die **deutsche Beschreibung ist inhaltlich führend** (`x-i18n.de`).
Die **englischen Feldbezeichner** sind die primären API-Identifier (lowerCamelCase).

---

## Verwendung / Usage

### Einzelne Felder referenzieren / Referencing individual fields

```yaml
properties:
  maLoId:
    $ref: "./locations/marketLocation/marketLocationId.yaml"
  voltageLevel:
    $ref: "./common/voltageLevel.yaml"
  energyDirection:
    $ref: "./enumerations/energyDirection.yaml"
  validity:
    $ref: "./common/validityPeriod.yaml"
```

### Zusammengesetzte Objekte / Composed objects

```yaml
responses:
  '200':
    content:
      application/json:
        schema:
          $ref: "./composed/locationBundle.yaml"
```

### Aus einem API-Verzeichnis (z.B. `api/`) / From an API directory (e.g. `api/`)

```yaml
$ref: "../schema/locations/marketLocation/marketLocationId.yaml"
$ref: "../schema/enumerations/energyDirection.yaml"
$ref: "../schema/message/messageHeader.yaml"
$ref: "../schema/supplyStart/supplyStart.yaml"
```

---

## Wichtige Prüfidentifikatoren / Key Check Identifiers (GPKE Lieferbeginn)

| Prüf-ID | Richtung | Schritt | Anwendungsfall |
|---------|----------|---------|----------------|
| 55001 | LF → NB | 1 | Anmeldung verbrauchende MaLo |
| 55077 | LF → NB | 1 | Anmeldung erzeugende MaLo |
| 55010 | NB → LFA | 3 | Abmeldeanfrage an alten Lieferanten |
| 55011 | LFA → NB | 4 | Bestätigung der Abmeldeanfrage |
| 55012 | LFA → NB | 4 | Widerspruch zur Abmeldeanfrage |
| 55002 | NB → LF | 5 | Bestätigung Anmeldung verbrauchende MaLo |
| 55003 | NB → LF | 5 | Ablehnung Anmeldung verbrauchende MaLo |
| 55078 | NB → LF | 5 | Bestätigung Anmeldung erzeugende MaLo |
| 55080 | NB → LF | 5 | Ablehnung Anmeldung erzeugende MaLo |
| 55037 | NB → LFA | 6 | Beendigung der Zuordnung |
| 55038 | NB → LFZ | 7 | Aufhebung einer zukünftigen Zuordnung |

---

## Normative Quellen / Normative Sources

- BDEW UTILMD Anwendungshandbuch Strom 2.1 (11.12.2025)
- BDEW GPKE – Geschäftsprozesse zur Kundenbelieferung mit Elektrizität (GPKE Teil 2)
- EDI@Energy Anwendungsübersicht der Prüfidentifikatoren v3.1 (01.08.2024, BDEW)
- BDEW Codelisten (Marktrollen, Spannungsebenen, OBIS)
- EDIFACT UTILMD S2.1
- IEC 62056-21 (OBIS)
- [www.bdew-mako.de](https://www.bdew-mako.de)
