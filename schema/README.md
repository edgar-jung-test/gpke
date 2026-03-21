# BDEW UTILMD Electricity Market – OpenAPI 3.0 Schema

**Version:** 2.1.0  
**Standard:** BDEW UTILMD Anwendungshandbuch (AHB) Strom, Version 2.1 (Stand: 11.12.2025)  
**Basis:** BDEW AWH Rollenmodell ERM · UTILMD AHB Strom 2.1 · SQL ERM Schema  
**Referenz:** [www.bdew-mako.de](https://www.bdew-mako.de)

---

## Übersicht / Overview

Dieses Verzeichnis enthält ein vollständiges OpenAPI 3.0 Schema für die BDEW UTILMD
Marktkommunikation Strom. Jedes Feld ist als eigenständige YAML-Datei modelliert, sodass
die Schemata dynamisch zu zusammengesetzten Objekten kombiniert werden können.

This directory contains a complete OpenAPI 3.0 schema for BDEW UTILMD electricity
market communication. Every field is modelled as a standalone YAML file enabling
dynamic composition into larger objects.

> **Namenskonvention / Naming convention:** Alle Dateinamen, Verzeichnisnamen und
> Feldbezeichner sind in **lowerCamelCase** gehalten.  
> All file names, directory names and field identifiers use **lowerCamelCase**.

---

## Verzeichnisstruktur / Directory Structure

```
openapi.yaml                              ← Root OpenAPI 3.0 document (entry point)
│
├── common/                               ← Gemeinsame Basistypen / Shared base types
│   ├── address.yaml                        Anschrift / Postal address (EDIFACT NAD)
│   │   Felder: additionalInfo, street, postOfficeBox, city, postalCode, countryCode
│   │
│   ├── errorResponse.yaml                  Fehlerantwort / Error response
│   │   Felder: code, message, messageLocalized, details, timestamp
│   │
│   ├── multilingualLabel.yaml              Mehrsprachige Bezeichnung (EN/DE)
│   │   Felder: en, de
│   │
│   ├── obisCode.yaml                       OBIS-Kennzahl (IEC 62056-21)
│   │   Felder: code, description, label
│   │
│   ├── pagedResponse.yaml                  Paginierte Antwort / Paginated response
│   │   Felder: items, totalCount, page, pageSize
│   │
│   ├── product.yaml                        Produkt / Konfigurationsprodukt (EDIFACT PIA)
│   │   Felder: productCode, name, description, label
│   │
│   ├── validityPeriod.yaml                 Gültigkeitszeitraum (EDIFACT DTM)
│   │   Felder: validFrom, validTo
│   │
│   └── voltageLevel.yaml                   Spannungsebene (BDEW Codeliste E02)
│       Felder: code, name, label
│
├── enumerations/                         ← Aufzählungstypen / Enumeration types
│   ├── energyDirection.yaml                CONSUMPTION | GENERATION
│   ├── locationBundleType.yaml             ZW6 | ZW7 | ZAP
│   ├── marketRoleCode.yaml                 NB | LF | MSB | BKV | BIKO | UeNB | UNB |
│   │                                       ESA | DP | MGV | BTR | EIV | EOG | RB |
│   │                                       NBA | NBN | MR | MS
│   ├── messageType.yaml                    E01 | E02 | E03 | E04 | E05 | E06
│   ├── meterOperatorType.yaml              Z39 | Z40 | Z41 | Z19 | Z20
│   ├── meteringPointType.yaml              Z01 | Z02 | Z06 | Z07 | Z08 | Z09 | Z10 | Z98
│   ├── profileType.yaml                    SLP | SEP | TLP | TEP | RLM
│   └── transactionReason.yaml              ZA1 | ZA2 | ZA3 | ZA4 | ZA5 | ZA6 | ZA7 |
│                                           ZW0 | ZW1 | ZW2 | ZW3 | ZW4 | ZW5 | ZW6 |
│                                           ZW7 | ZW8 | ZW9 | ZX0 | ZX1 | ZX4 | E01 | E03
│
├── marketActors/                         ← Marktakteure / Market participants
│   ├── communicationContact.yaml           Kommunikationsverbindung (EDIFACT CTA/COM)
│   │   Felder: contactType, contactName, email, phone, fax, mobile
│   │
│   ├── marketActor.yaml                    Marktakteur / Marktpartner (EDIFACT NAD)
│   │   Felder: id, externalId, name, isNaturalPerson, email, phone,
│   │           address, roles, validity, label
│   │
│   ├── marketActorId.yaml                  Marktpartner-ID / MP-ID (EDIFACT NAD DE3039)
│   │   Felder: id, codingScheme, label
│   │
│   └── marketActorRole.yaml                Marktrollen-Zuordnung
│       Felder: id, marketActorId, roleCode, validity, label
│
├── locations/
│   ├── marketLocation/                   ← Marktlokation (MaLo)
│   │   ├── dormantMarketLocation.yaml      Ruhende MaLo (ZAP, §20 EnWG / §10c EEG)
│   │   │   Felder: maLoId, dormancyReason, legalBasis, validity, label
│   │   │
│   │   ├── marketLocation.yaml             Marktlokation – Hauptobjekt (EDIFACT LOC Z16)
│   │   │   Felder: id, maLoId, gridAreaId, address, voltageLevel, energyDirection,
│   │   │           status, locationBundleType, profile, balancingAreaCode,
│   │   │           balancingGroupCode, packageId, validity, label
│   │   │
│   │   ├── marketLocationId.yaml           MaLo-ID (11-stellig, LOC DE3225 Z16)
│   │   │   Typ: string (scalar)
│   │   │
│   │   ├── marketLocationProfile.yaml      Lastprofil-Zuordnung (SLP/RLM)
│   │   │   Felder: profileCode, profileType, validity, label
│   │   │
│   │   └── marketLocationStatus.yaml       ACTIVE | DORMANT | DISCONNECTED | DECOMMISSIONED
│   │       Typ: string (scalar enum)
│   │
│   ├── gridLocation/                     ← Netzlokation (NeLo)
│   │   ├── gridLocation.yaml               Netzlokation (EDIFACT LOC Z18)
│   │   │   Felder: id, neLoId, gridAreaId, address, voltageLevel, hasControlChannel,
│   │   │           assignedMeteringPointOperator, products, obisCodes, validity, label
│   │   │
│   │   └── gridLocationId.yaml             NeLo-ID (LOC DE3225 Z18)
│   │       Typ: string (scalar)
│   │
│   ├── meteringLocation/                 ← Messlokation (MeLo)
│   │   ├── meteringLocation.yaml           Messlokation (EDIFACT LOC Z17)
│   │   │   Felder: id, meLoId, address, voltageLevel,
│   │   │           assignedMeteringPointOperator, validity, label
│   │   │
│   │   └── meteringLocationId.yaml         MeLo-ID (LOC DE3225 Z17)
│   │       Typ: string (scalar)
│   │
│   └── tranche/                          ← Tranche (Teilmengenzuordnung, LOC Z21)
│       ├── tranche.yaml                    Tranche für GVF ZW1/ZW2/ZX1
│       │   Felder: id, trancheId, marketLocationId, percentageShare,
│       │           assignedSupplier, validity, label
│       │
│       └── trancheId.yaml                  Tranchen-ID (LOC DE3225 Z21)
│           Typ: string (scalar)
│
├── metering/
│   ├── devices/                          ← Messgeräte / Metering devices
│   │   ├── communicationDevice.yaml        Kommunikationseinrichtung
│   │   │   Felder: id, deviceNumber, meterId, msbActorId, validity, label
│   │   │
│   │   ├── controlBox.yaml                 Steuerbox (XOR mit Steuereinrichtung)
│   │   │   Felder: id, externalId, controllableResourceId,
│   │   │           usedByNBActorId, usedByEIVActorId, validity, label
│   │   │
│   │   ├── controlDevice.yaml              Steuereinrichtung (z.B. RSE, TSU, SMGW)
│   │   │   Felder: id, externalId, controllableResourceId,
│   │   │           usedByNBActorId, usedByEIVActorId, validity, label
│   │   │
│   │   ├── controllableResource.yaml       Steuerbare Ressource / SR (LOC Z19)
│   │   │   Felder: id, externalId, technicalResourceId,
│   │   │           gridOperatorActorId, eivActorId, validity, label
│   │   │
│   │   ├── gateway.yaml                    Smart-Meter-Gateway (SMGW)
│   │   │   Felder: id, deviceNumber, msbActorId, connectedMeterIds, validity, label
│   │   │
│   │   ├── meter.yaml                      Zähler
│   │   │   Felder: id, deviceNumber, meteringLocationId, gridCouplingPointId,
│   │   │           msbActorId, gatewayId, validity, label
│   │   │
│   │   ├── meterNumber.yaml                Gerätenummer / Zählernummer
│   │   │   Typ: string (scalar)
│   │   │
│   │   ├── tariffDevice.yaml               Tarifeinrichtung (HT/NT)
│   │   │   Felder: id, externalId, meterId, msbActorId, validity, label
│   │   │
│   │   ├── technicalResource.yaml          Technische Ressource / TR (LOC Z20)
│   │   │   Felder: id, externalId, gridOperatorActorId, operatorActorId, validity, label
│   │   │
│   │   ├── transformerDevice.yaml          Wandlereinrichtung (Strom-/Spannungswandler)
│   │   │   Felder: id, externalId, meterId, msbActorId, validity, label
│   │   │
│   │   └── volumeConverter.yaml            Mengenumwerter
│   │       Felder: id, deviceNumber, meterId, msbActorId, validity, label
│   │
│   └── registers/                        ← Messregister / Measurement registers
│       ├── gatewayRegister.yaml            Gateway-Register (SMGW-Register)
│       │   Felder: id, gatewayId, registerCode, obisCode, validity, label
│       │
│       └── meterRegister.yaml              Zählerregister
│           Felder: id, meterId, registerCode, obisCode, validity, label
│
├── balancing/                            ← Bilanzierung / Balancing
│   ├── balancingArea.yaml                  Bilanzierungsgebiet (EIC)
│   │   Felder: id, code, name, controlAreaId, label
│   │
│   ├── balancingGroup.yaml                 Bilanzkreis (BKV, EIC)
│   │   Felder: id, code, name, balancingAreaId, managedByActorId, label
│   │
│   ├── controlArea.yaml                    Regelzone (ÜNB, EIC)
│   │   Felder: id, code, name, responsibleActorId, financialActorId, label
│   │
│   ├── gridAccount.yaml                    Netzkonto
│   │   Felder: id, code, name, marketAreaId, label
│   │
│   └── marketArea.yaml                     Marktgebiet (MGV)
│       Felder: id, code, name, virtualTradingPointActorId, label
│
├── message/                              ← EDIFACT UTILMD Nachrichtenstruktur
│   ├── checkIdentifier.yaml                Prüfidentifikator (SG6 RFF+Z13)
│   │   Felder: value, description, communicationDirection, label
│   │
│   ├── messageHeader.yaml                  Nachrichtenheader (UNB/UNH/BGM/DTM)
│   │   Felder: messageId, messageType, checkIdentifier, createdAt,
│   │           sender, recipient, documentNumber
│   │
│   ├── messageRecipient.yaml               Nachrichtenempfänger (NAD MR)
│   │   Felder: actorId, marketRole, label
│   │
│   ├── messageSender.yaml                  Nachrichtensender (NAD MS)
│   │   Felder: actorId, marketRole, contact, label
│   │
│   ├── messageTransaction.yaml             Vorgang (SG4 IDE)
│   │   Felder: transactionId, transactionReason, transactionReasonSupplement,
│   │           startDate, checkIdentifier, status, usagePeriod,
│   │           marketLocationId, label
│   │
│   ├── transactionStatus.yaml              Vorgangsstatus (SG4 STS)
│   │   Felder: statusCode, rejectionCode, periodId, label
│   │
│   └── usagePeriod.yaml                    Verwendungszeitraum (SG6 RFF+Z49/Z53)
│       Felder: periodId, dataAvailable, validFrom, validTo, label
│
└── composed/                             ← Zusammengesetzte API-Objekte
    ├── gridLocationFull.yaml               NeLo vollständig (GET /grid-locations/{neLoId})
    │   Felder: neLoId, address, voltageLevel, hasControlChannel,
    │           assignedMSB, associatedMeteringLocations,
    │           products, obisCodes, validity
    │
    ├── locationBundle.yaml                 Lokationsbündel (MaLo + NeLo + MeLo + TR + SR)
    │   Felder: marketLocation, dormantStatus, assignedSupplier, assignedGridOperator,
    │           assignedMSB, gridLocations, meteringLocations, technicalResources,
    │           controllableResources, tranches, products, obisCodes,
    │           bundleType, validity
    │
    ├── marketActorFull.yaml                Marktakteur vollständig (GET /market-actors/{id})
    │   Felder: id, externalId, name, isNaturalPerson, address, roles, contacts, validity
    │
    ├── marketLocationFull.yaml             MaLo vollständig (GET /market-locations/{maLoId})
    │   Felder: maLoId, address, voltageLevel, energyDirection, status, bundleType,
    │           profile, balancingAreaCode, balancingGroupCode, packageId,
    │           assignedSupplier, assignedMSB, assignedGridOperator,
    │           products, obisCodes, validity
    │
    ├── meterFull.yaml                      Zähler vollständig mit Registern und Hilfsgeräten
    │   Felder: deviceNumber, meteringLocationId, msbActorId, registers,
    │           gateway, communicationDevice, transformerDevice,
    │           tariffDevice, volumeConverter, validity
    │
    ├── meteringLocationFull.yaml           MeLo vollständig mit Geräten
    │   Felder: meLoId, address, voltageLevel, assignedMSB,
    │           associatedMarketLocations, associatedGridLocations,
    │           installedMeters, installedGateways, validity
    │
    └── utilmdMessage.yaml                  UTILMD-Nachricht vollständig (Header + Vorgänge)
        Felder: header, transactions, locationBundles
```

---

## Feldbezeichner-Referenz / Field Name Reference

Alle Feldnamen sind **lowerCamelCase**. Die folgende Tabelle listet alle Schemata
mit ihren genauen Feldnamen auf:

| Schema (Datei) | Typ | Felder (lowerCamelCase) |
|---|---|---|
| `common/address.yaml` | object | `additionalInfo`, `street`, `postOfficeBox`, `city`, `postalCode`, `countryCode` |
| `common/errorResponse.yaml` | object | `code`, `message`, `messageLocalized`, `details`, `timestamp` |
| `common/multilingualLabel.yaml` | object | `en`, `de` |
| `common/obisCode.yaml` | object | `code`, `description`, `label` |
| `common/pagedResponse.yaml` | object | `items`, `totalCount`, `page`, `pageSize` |
| `common/product.yaml` | object | `productCode`, `name`, `description`, `label` |
| `common/validityPeriod.yaml` | object | `validFrom`, `validTo` |
| `common/voltageLevel.yaml` | object | `code`, `name`, `label` |
| `enumerations/energyDirection.yaml` | string enum | `CONSUMPTION`, `GENERATION` |
| `enumerations/locationBundleType.yaml` | string enum | `ZW6`, `ZW7`, `ZAP` |
| `enumerations/marketRoleCode.yaml` | string enum | `NB`, `LF`, `MSB`, `BKV`, `BIKO`, `UeNB`, `UNB`, `ESA`, `DP`, `MGV`, `BTR`, `EIV`, `EOG`, `RB`, `NBA`, `NBN`, `MR`, `MS` |
| `enumerations/messageType.yaml` | string enum | `E01`, `E02`, `E03`, `E04`, `E05`, `E06` |
| `enumerations/meterOperatorType.yaml` | string enum | `Z39`, `Z40`, `Z41`, `Z19`, `Z20` |
| `enumerations/meteringPointType.yaml` | string enum | `Z01`, `Z02`, `Z06`, `Z07`, `Z08`, `Z09`, `Z10`, `Z98` |
| `enumerations/profileType.yaml` | string enum | `SLP`, `SEP`, `TLP`, `TEP`, `RLM` |
| `enumerations/transactionReason.yaml` | string enum | `ZA1`–`ZA7`, `ZW0`–`ZW9`, `ZX0`, `ZX1`, `ZX4`, `E01`, `E03` |
| `marketActors/communicationContact.yaml` | object | `contactType`, `contactName`, `email`, `phone`, `fax`, `mobile` |
| `marketActors/marketActor.yaml` | object | `id`, `externalId`, `name`, `isNaturalPerson`, `email`, `phone`, `address`, `roles`, `validity`, `label` |
| `marketActors/marketActorId.yaml` | object | `id`, `codingScheme`, `label` |
| `marketActors/marketActorRole.yaml` | object | `id`, `marketActorId`, `roleCode`, `validity`, `label` |
| `locations/marketLocation/marketLocation.yaml` | object | `id`, `maLoId`, `gridAreaId`, `address`, `voltageLevel`, `energyDirection`, `status`, `locationBundleType`, `profile`, `balancingAreaCode`, `balancingGroupCode`, `packageId`, `validity`, `label` |
| `locations/marketLocation/marketLocationId.yaml` | string | *(scalar – 11-stellige MaLo-ID)* |
| `locations/marketLocation/marketLocationProfile.yaml` | object | `profileCode`, `profileType`, `validity`, `label` |
| `locations/marketLocation/marketLocationStatus.yaml` | string enum | `ACTIVE`, `DORMANT`, `DISCONNECTED`, `DECOMMISSIONED` |
| `locations/marketLocation/dormantMarketLocation.yaml` | object | `maLoId`, `dormancyReason`, `legalBasis`, `validity`, `label` |
| `locations/gridLocation/gridLocation.yaml` | object | `id`, `neLoId`, `gridAreaId`, `address`, `voltageLevel`, `hasControlChannel`, `assignedMeteringPointOperator`, `products`, `obisCodes`, `validity`, `label` |
| `locations/gridLocation/gridLocationId.yaml` | string | *(scalar – NeLo-ID)* |
| `locations/meteringLocation/meteringLocation.yaml` | object | `id`, `meLoId`, `address`, `voltageLevel`, `assignedMeteringPointOperator`, `validity`, `label` |
| `locations/meteringLocation/meteringLocationId.yaml` | string | *(scalar – MeLo-ID)* |
| `locations/tranche/tranche.yaml` | object | `id`, `trancheId`, `marketLocationId`, `percentageShare`, `assignedSupplier`, `validity`, `label` |
| `locations/tranche/trancheId.yaml` | string | *(scalar – Tranchen-ID)* |
| `metering/devices/communicationDevice.yaml` | object | `id`, `deviceNumber`, `meterId`, `msbActorId`, `validity`, `label` |
| `metering/devices/controlBox.yaml` | object | `id`, `externalId`, `controllableResourceId`, `usedByNBActorId`, `usedByEIVActorId`, `validity`, `label` |
| `metering/devices/controlDevice.yaml` | object | `id`, `externalId`, `controllableResourceId`, `usedByNBActorId`, `usedByEIVActorId`, `validity`, `label` |
| `metering/devices/controllableResource.yaml` | object | `id`, `externalId`, `technicalResourceId`, `gridOperatorActorId`, `eivActorId`, `validity`, `label` |
| `metering/devices/gateway.yaml` | object | `id`, `deviceNumber`, `msbActorId`, `connectedMeterIds`, `validity`, `label` |
| `metering/devices/meter.yaml` | object | `id`, `deviceNumber`, `meteringLocationId`, `gridCouplingPointId`, `msbActorId`, `gatewayId`, `validity`, `label` |
| `metering/devices/meterNumber.yaml` | string | *(scalar – Gerätenummer)* |
| `metering/devices/tariffDevice.yaml` | object | `id`, `externalId`, `meterId`, `msbActorId`, `validity`, `label` |
| `metering/devices/technicalResource.yaml` | object | `id`, `externalId`, `gridOperatorActorId`, `operatorActorId`, `validity`, `label` |
| `metering/devices/transformerDevice.yaml` | object | `id`, `externalId`, `meterId`, `msbActorId`, `validity`, `label` |
| `metering/devices/volumeConverter.yaml` | object | `id`, `deviceNumber`, `meterId`, `msbActorId`, `validity`, `label` |
| `metering/registers/gatewayRegister.yaml` | object | `id`, `gatewayId`, `registerCode`, `obisCode`, `validity`, `label` |
| `metering/registers/meterRegister.yaml` | object | `id`, `meterId`, `registerCode`, `obisCode`, `validity`, `label` |
| `balancing/balancingArea.yaml` | object | `id`, `code`, `name`, `controlAreaId`, `label` |
| `balancing/balancingGroup.yaml` | object | `id`, `code`, `name`, `balancingAreaId`, `managedByActorId`, `label` |
| `balancing/controlArea.yaml` | object | `id`, `code`, `name`, `responsibleActorId`, `financialActorId`, `label` |
| `balancing/gridAccount.yaml` | object | `id`, `code`, `name`, `marketAreaId`, `label` |
| `balancing/marketArea.yaml` | object | `id`, `code`, `name`, `virtualTradingPointActorId`, `label` |
| `message/checkIdentifier.yaml` | object | `value`, `description`, `communicationDirection`, `label` |
| `message/messageHeader.yaml` | object | `messageId`, `messageType`, `checkIdentifier`, `createdAt`, `sender`, `recipient`, `documentNumber` |
| `message/messageRecipient.yaml` | object | `actorId`, `marketRole`, `label` |
| `message/messageSender.yaml` | object | `actorId`, `marketRole`, `contact`, `label` |
| `message/messageTransaction.yaml` | object | `transactionId`, `transactionReason`, `transactionReasonSupplement`, `startDate`, `checkIdentifier`, `status`, `usagePeriod`, `marketLocationId`, `label` |
| `message/transactionStatus.yaml` | object | `statusCode`, `rejectionCode`, `periodId`, `label` |
| `message/usagePeriod.yaml` | object | `periodId`, `dataAvailable`, `validFrom`, `validTo`, `label` |
| `composed/gridLocationFull.yaml` | object | `neLoId`, `address`, `voltageLevel`, `hasControlChannel`, `assignedMSB`, `associatedMeteringLocations`, `products`, `obisCodes`, `validity` |
| `composed/locationBundle.yaml` | object | `marketLocation`, `dormantStatus`, `assignedSupplier`, `assignedGridOperator`, `assignedMSB`, `gridLocations`, `meteringLocations`, `technicalResources`, `controllableResources`, `tranches`, `products`, `obisCodes`, `bundleType`, `validity` |
| `composed/marketActorFull.yaml` | object | `id`, `externalId`, `name`, `isNaturalPerson`, `address`, `roles`, `contacts`, `validity` |
| `composed/marketLocationFull.yaml` | object | `maLoId`, `address`, `voltageLevel`, `energyDirection`, `status`, `bundleType`, `profile`, `balancingAreaCode`, `balancingGroupCode`, `packageId`, `assignedSupplier`, `assignedMSB`, `assignedGridOperator`, `products`, `obisCodes`, `validity` |
| `composed/meterFull.yaml` | object | `deviceNumber`, `meteringLocationId`, `msbActorId`, `registers`, `gateway`, `communicationDevice`, `transformerDevice`, `tariffDevice`, `volumeConverter`, `validity` |
| `composed/meteringLocationFull.yaml` | object | `meLoId`, `address`, `voltageLevel`, `assignedMSB`, `associatedMarketLocations`, `associatedGridLocations`, `installedMeters`, `installedGateways`, `validity` |
| `composed/utilmdMessage.yaml` | object | `header`, `transactions`, `locationBundles` |

---

## Mehrsprachigkeit / Multilingual Support

Jedes Feld enthält drei Ebenen:

```yaml
maLoId:
  description: "English description (primary)"
  x-i18n:
    de:
      description: "Deutsche Beschreibung (führend/maßgeblich)"
  examples:
    Residential:
      summary: "Residential"         # Englischer Beispielbezeichner
      value: "51238696781"
  x-examples-i18n:
    de:
      Residential: "Haushalt"        # Deutsche Übersetzung des Beispiels
  label:
    $ref: "./common/multilingualLabel.yaml"   # { en: "...", de: "..." }
```

**Reihenfolge:** Inhaltlich ist die **deutsche Beschreibung führend** (`x-i18n.de`).
Die englischen Feldbezeichner sind die primären API-Identifier (lowerCamelCase).

---

## Verwendung / Usage

### Einzelne Felder referenzieren

```yaml
properties:
  maLoId:
    $ref: "./locations/marketLocation/marketLocationId.yaml"
  voltageLevel:
    $ref: "./common/voltageLevel.yaml"
  energyDirection:
    $ref: "./enumerations/energyDirection.yaml"
```

### Zusammengesetzte Objekte

```yaml
# Vollständiges Lokationsbündel für die API
responses:
  '200':
    content:
      application/json:
        schema:
          $ref: "./composed/locationBundle.yaml"
```

### Dynamische Komposition

```yaml
# Schlankes Antwortobjekt aus einzelnen Felddateien
type: object
properties:
  maLoId:
    $ref: "./locations/marketLocation/marketLocationId.yaml"
  status:
    $ref: "./locations/marketLocation/marketLocationStatus.yaml"
  bundleType:
    $ref: "./enumerations/locationBundleType.yaml"
  validity:
    $ref: "./common/validityPeriod.yaml"
```

---

## Wichtige Prüfidentifikatoren / Key Check Identifiers

| Prüf-ID | Kommunikation | Anwendungsfall |
|---------|--------------|----------------|
| 55001 | LF → NB | Lieferantenwechsel – Anmeldung |
| 55002 | NB → LF | Lieferantenwechsel – Bestätigung |
| 55003 | NB → LF | Lieferantenwechsel – Ablehnung |
| 55011 | LF → NB | Einzug / Neuanlage verbrauchende MaLo |
| 55077 | LF → NB | Anmeldung erzeugende MaLo |
| 55078 | NB → LF | Bestätigung Anmeldung erzeugende MaLo |
| 55175 | NB → LF | Änderung Lokationsbündelstruktur |
| 55218 | NB → LF | Abrechnungsdaten Netznutzungsabrechnung |
| 55220 | LF → NB | Anfrage Abrechnungsdaten NNA |
| 55615 | NB → LF | Änderung Daten der NeLo |
| 55616 | NB → LF | Änderung Daten der MaLo |
| 55617 | NB → LF | Änderung Daten der TR |
| 55618 | NB → LF | Änderung Daten der SR |
| 55619 | NB → LF | Änderung Daten der Tranche |
| 55620 | NB → LF | Änderung Daten der MeLo |

---

## Normative Quellen / Normative Sources

- BDEW UTILMD Anwendungshandbuch Strom 2.1 (11.12.2025)
- BDEW AWH Rollenmodell ERM (Strom)
- BDEW Codelisten (Marktrollen, Spannungsebenen, OBIS)
- EDIFACT UTILMD S2.1
- IEC 62056-21 (OBIS)
- [www.bdew-mako.de](https://www.bdew-mako.de)

