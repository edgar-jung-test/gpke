# BDEW UTILMD Electricity Market – OpenAPI **3.1** Schema

**Version:** 2.1.0  
**Standard:** BDEW UTILMD Anwendungshandbuch (AHB) Strom, Version 2.1 (Stand: 11.12.2025)  
**Basis:** BDEW AWH Rollenmodell ERM · UTILMD AHB Strom 2.1 · SQL ERM Schema  
**Referenz:** [www.bdew-mako.de](https://www.bdew-mako.de)

---

## OpenAPI 3.1 vs. 3.0

Dieses Paket ist die **OpenAPI 3.1**-Version des UTILMD-Schemas.
Der wesentliche Unterschied zur 3.0-Version:

| Feature | OAS 3.0 | OAS 3.1 |
|---|---|---|
| `if / then / else` | ❌ | ✅ |
| `nullable: true` | ✅ (proprietär) | ❌ → `type: ["string", "null"]` |
| `$ref` + eigene Properties | ❌ | ✅ |
| JSON Schema 2020-12 | ❌ | ✅ |

Alle `nullable: true`-Felder wurden in `type: ["X", "null"]` umgewandelt.
Das Verzeichnis `conditionals/` enthält 10 neue Schemas mit `if/then/else`.

---

## Verzeichnisstruktur / Directory Structure

```
openapi.yaml                         ← Root OpenAPI 3.1 Dokument
│
├── common/                          ← Gemeinsame Basistypen
│   ├── address.yaml                   Anschrift (EDIFACT NAD)
│   │   Felder: additionalInfo, street, postOfficeBox, city,
│   │           postalCode, countryCode
│   │
│   ├── errorResponse.yaml             Fehlerantwort
│   │   Felder: code, message, messageLocalized, details, timestamp
│   │
│   ├── multilingualLabel.yaml         Mehrsprachige Bezeichnung (EN/DE)
│   │   Felder: en, de
│   │
│   ├── obisCode.yaml                  OBIS-Kennzahl (IEC 62056-21)
│   │   Felder: code, description, label
│   │
│   ├── pagedResponse.yaml             Paginierte Antwort
│   │   Felder: items, totalCount, page, pageSize
│   │
│   ├── product.yaml                   Produkt / Konfigurationsprodukt (EDIFACT PIA)
│   │   Felder: productCode, name, description, label
│   │
│   ├── validityPeriod.yaml            Gültigkeitszeitraum (EDIFACT DTM)
│   │   Felder: validFrom, validTo
│   │
│   └── voltageLevel.yaml              Spannungsebene (BDEW Codeliste E02)
│       Felder: code, name, label
│
├── enumerations/                    ← Aufzählungstypen
│   ├── energyDirection.yaml           CONSUMPTION | GENERATION
│   ├── locationBundleType.yaml        ZW6 | ZW7 | ZAP
│   ├── marketRoleCode.yaml            NB | LF | MSB | BKV | BIKO | UeNB | UNB |
│   │                                  ESA | DP | MGV | BTR | EIV | EOG | RB |
│   │                                  NBA | NBN | MR | MS
│   ├── messageType.yaml               E01 | E02 | E03 | E04 | E05 | E06
│   ├── meterOperatorType.yaml         Z39 | Z40 | Z41 | Z19 | Z20
│   ├── meteringPointType.yaml         Z01 | Z02 | Z06 | Z07 | Z08 | Z09 | Z10 | Z98
│   ├── profileType.yaml               SLP | SEP | TLP | TEP | RLM
│   └── transactionReason.yaml         ZA1 | ZA2 | ZA3 | ZA4 | ZA5 | ZA6 | ZA7 |
│                                      ZW0 | ZW1 | ZW2 | ZW3 | ZW4 | ZW5 | ZW6 |
│                                      ZW7 | ZW8 | ZW9 | ZX0 | ZX1 | ZX4 | E01 | E03
│
├── marketActors/                    ← Marktakteure
│   ├── communicationContact.yaml      Kommunikationsverbindung (EDIFACT CTA/COM)
│   │   Felder: contactType, contactName, email, phone, fax, mobile
│   │
│   ├── marketActor.yaml               Marktakteur / Marktpartner (EDIFACT NAD)
│   │   Felder: id, externalId, name, isNaturalPerson, email, phone,
│   │           address, roles, validity, label
│   │
│   ├── marketActorId.yaml             Marktpartner-ID / MP-ID (EDIFACT NAD DE3039)
│   │   Felder: id, codingScheme, label
│   │
│   └── marketActorRole.yaml           Marktrollen-Zuordnung
│       Felder: id, marketActorId, roleCode, validity, label
│
├── locations/
│   ├── marketLocation/              ← Marktlokation (MaLo)
│   │   ├── dormantMarketLocation.yaml   Ruhende MaLo (ZAP / §20 EnWG / §10c EEG)
│   │   │   Felder: maLoId, dormancyReason, legalBasis, validity, label
│   │   │
│   │   ├── marketLocation.yaml          Marktlokation – Hauptobjekt (EDIFACT LOC Z16)
│   │   │   Felder: id, maLoId, gridAreaId, address, voltageLevel,
│   │   │           energyDirection, status, locationBundleType, profile,
│   │   │           balancingAreaCode, balancingGroupCode, packageId,
│   │   │           validity, label
│   │   │
│   │   ├── marketLocationId.yaml        MaLo-ID (11-stellig, LOC DE3225 Z16)
│   │   │
│   │   ├── marketLocationProfile.yaml   Lastprofil-Zuordnung
│   │   │   Felder: profileCode, profileType, validity, label
│   │   │
│   │   └── marketLocationStatus.yaml    Status: ACTIVE | DORMANT |
│   │                                    DISCONNECTED | DECOMMISSIONED
│   │
│   ├── gridLocation/                ← Netzlokation (NeLo)
│   │   ├── gridLocation.yaml            Netzlokation (EDIFACT LOC Z18)
│   │   │   Felder: id, neLoId, gridAreaId, address, voltageLevel,
│   │   │           hasControlChannel, assignedMeteringPointOperator
│   │   │           (actorId, operatorType), products, obisCodes,
│   │   │           validity, label
│   │   │
│   │   └── gridLocationId.yaml          NeLo-ID (LOC DE3225 Z18)
│   │
│   ├── meteringLocation/            ← Messlokation (MeLo)
│   │   ├── meteringLocation.yaml        Messlokation (EDIFACT LOC Z17)
│   │   │   Felder: id, meLoId, address, voltageLevel,
│   │   │           assignedMeteringPointOperator (actorId, operatorType),
│   │   │           validity, label
│   │   │
│   │   └── meteringLocationId.yaml      MeLo-ID (LOC DE3225 Z17)
│   │
│   └── tranche/                     ← Tranche (LOC Z21)
│       ├── tranche.yaml                 Tranche für GVF ZW1/ZW2/ZX1
│       │   Felder: id, trancheId, marketLocationId, percentageShare,
│       │           assignedSupplier, validity, label
│       │
│       └── trancheId.yaml               Tranchen-ID (LOC DE3225 Z21)
│
├── metering/
│   ├── devices/                     ← Messgeräte
│   │   ├── communicationDevice.yaml     Kommunikationseinrichtung
│   │   │   Felder: id, deviceNumber, meterId, msbActorId, validity, label
│   │   │
│   │   ├── controlBox.yaml              Steuerbox (XOR mit Steuereinrichtung)
│   │   │   Felder: id, externalId, controllableResourceId,
│   │   │           usedByNBActorId, usedByEIVActorId, validity, label
│   │   │
│   │   ├── controlDevice.yaml           Steuereinrichtung (RSE/TSU/SMGW)
│   │   │   Felder: id, externalId, controllableResourceId,
│   │   │           usedByNBActorId, usedByEIVActorId, validity, label
│   │   │
│   │   ├── controllableResource.yaml    Steuerbare Ressource / SR (LOC Z19)
│   │   │   Felder: id, externalId, technicalResourceId,
│   │   │           gridOperatorActorId, eivActorId, validity, label
│   │   │
│   │   ├── gateway.yaml                 Smart-Meter-Gateway (SMGW)
│   │   │   Felder: id, deviceNumber, msbActorId, connectedMeterIds,
│   │   │           validity, label
│   │   │
│   │   ├── meter.yaml                   Zähler
│   │   │   Felder: id, deviceNumber, meteringLocationId,
│   │   │           gridCouplingPointId, msbActorId, gatewayId,
│   │   │           validity, label
│   │   │
│   │   ├── meterNumber.yaml             Gerätenummer / Zählernummer (string)
│   │   │
│   │   ├── tariffDevice.yaml            Tarifeinrichtung (HT/NT)
│   │   │   Felder: id, externalId, meterId, msbActorId, validity, label
│   │   │
│   │   ├── technicalResource.yaml       Technische Ressource / TR (LOC Z20)
│   │   │   Felder: id, externalId, gridOperatorActorId, operatorActorId,
│   │   │           validity, label
│   │   │
│   │   ├── transformerDevice.yaml       Wandlereinrichtung (SW/SpW)
│   │   │   Felder: id, externalId, meterId, msbActorId, validity, label
│   │   │
│   │   └── volumeConverter.yaml         Mengenumwerter
│   │       Felder: id, deviceNumber, meterId, msbActorId, validity, label
│   │
│   └── registers/                   ← Messregister
│       ├── gatewayRegister.yaml         Gateway-Register (SMGW-Register)
│       │   Felder: id, gatewayId, registerCode, obisCode, validity, label
│       │
│       └── meterRegister.yaml           Zählerregister
│           Felder: id, meterId, registerCode, obisCode, validity, label
│
├── balancing/                       ← Bilanzierung
│   ├── balancingArea.yaml               Bilanzierungsgebiet (EIC)
│   │   Felder: id, code, name, controlAreaId, label
│   │
│   ├── balancingGroup.yaml              Bilanzkreis (BKV, EIC)
│   │   Felder: id, code, name, balancingAreaId, managedByActorId, label
│   │
│   ├── controlArea.yaml                 Regelzone (ÜNB, EIC)
│   │   Felder: id, code, name, responsibleActorId, financialActorId, label
│   │
│   ├── gridAccount.yaml                 Netzkonto
│   │   Felder: id, code, name, marketAreaId, label
│   │
│   └── marketArea.yaml                  Marktgebiet (MGV)
│       Felder: id, code, name, virtualTradingPointActorId, label
│
├── message/                         ← EDIFACT UTILMD Nachrichtenstruktur
│   ├── checkIdentifier.yaml             Prüfidentifikator (SG6 RFF+Z13)
│   │   Felder: value, description, communicationDirection, label
│   │
│   ├── messageHeader.yaml               Nachrichtenheader (UNB/UNH/BGM/DTM)
│   │   Felder: messageId, messageType, checkIdentifier, createdAt,
│   │           sender, recipient, documentNumber
│   │
│   ├── messageRecipient.yaml            Nachrichtenempfänger (NAD MR)
│   │   Felder: actorId, marketRole, label
│   │
│   ├── messageSender.yaml               Nachrichtensender (NAD MS)
│   │   Felder: actorId, marketRole, contact, label
│   │
│   ├── messageTransaction.yaml          Vorgang (SG4 IDE)
│   │   Felder: transactionId, transactionReason, transactionReasonSupplement,
│   │           startDate, checkIdentifier, status, usagePeriod,
│   │           marketLocationId, label
│   │
│   ├── transactionStatus.yaml           Vorgangsstatus (SG4 STS)
│   │   Felder: statusCode, rejectionCode, periodId, label
│   │
│   └── usagePeriod.yaml                 Verwendungszeitraum (SG6 RFF+Z49/Z53)
│       Felder: periodId, dataAvailable, validFrom, validTo, label
│
├── composed/                        ← Zusammengesetzte API-Objekte
│   ├── gridLocationFull.yaml            NeLo vollständig
│   │   Felder: neLoId, address, voltageLevel, hasControlChannel,
│   │           assignedMSB (actorId, operatorType, validity),
│   │           associatedMeteringLocations, products, obisCodes, validity
│   │
│   ├── locationBundle.yaml              Lokationsbündel (MaLo + NeLo + MeLo + TR + SR)
│   │   Felder: marketLocation, dormantStatus, assignedSupplier,
│   │           assignedGridOperator,
│   │           assignedMSB (actorId, operatorType, validity),
│   │           gridLocations, meteringLocations, technicalResources,
│   │           controllableResources, tranches, products, obisCodes,
│   │           bundleType, validity
│   │
│   ├── marketActorFull.yaml             Marktakteur vollständig
│   │   Felder: id, externalId, name, isNaturalPerson, address, roles,
│   │           contacts, validity
│   │
│   ├── marketLocationFull.yaml          MaLo vollständig
│   │   Felder: maLoId, address, voltageLevel, energyDirection, status,
│   │           bundleType, profile, balancingAreaCode, balancingGroupCode,
│   │           packageId,
│   │           assignedSupplier (actorId, validity),
│   │           assignedMSB (actorId, operatorType, validity),
│   │           assignedGridOperator, products, obisCodes, validity
│   │
│   ├── meterFull.yaml                   Zähler vollständig
│   │   Felder: deviceNumber, meteringLocationId, msbActorId, registers,
│   │           gateway, communicationDevice, transformerDevice,
│   │           tariffDevice, volumeConverter, validity
│   │
│   ├── meteringLocationFull.yaml        MeLo vollständig
│   │   Felder: meLoId, address, voltageLevel,
│   │           assignedMSB (actorId, operatorType, validity),
│   │           associatedMarketLocations, associatedGridLocations,
│   │           installedMeters, installedGateways, validity
│   │
│   └── utilmdMessage.yaml               UTILMD-Nachricht vollständig
│       Felder: header, transactions, locationBundles
│
└── conditionals/                    ← Bedingte Schemas (if/then/else – OAS 3.1)
    ├── locationBundle.yaml              ZW6 / ZW7 / ZAP – Lokationsbündeltyp
    │   Felder: maLoId, bundleType, gridLocations (neLoId), supplier (actorId),
    │           profile (profileCode, profileType), meteringLocations (meLoId),
    │           dormancyReason, legalBasis
    │   Bedingung: bundleType=ZW6 → profile+supplier Pflicht, meteringLocations verboten
    │              bundleType=ZW7 → meteringLocations Pflicht, profile verboten
    │              bundleType=ZAP → dormancyReason+legalBasis Pflicht, supplier verboten
    │
    ├── meteringPointOperatorAssignment.yaml  Z39/Z40/Z41 MSB-Typ
    │   Felder: actorId (id, codingScheme), msbType, operatingBasis
    │   Bedingung: msbType=Z40 → operatingBasis (Z19|Z20) Pflicht
    │              msbType=Z39|Z41 → operatingBasis verboten
    │
    ├── controllableResourceWithControl.yaml  SR: Steuereinrichtung XOR Steuerbox
    │   Felder: externalId, technicalResourceId,
    │           controlDevice (externalId, deviceType),
    │           controlBox (externalId)
    │   Bedingung: oneOf – entweder controlDevice ODER controlBox
    │
    ├── communicationChannel.yaml        EM/TE/FX Format (AHB [939]/[940])
    │   Felder: channelType, value
    │   Bedingung: channelType=EM → E-Mail-Format (@ und .)
    │              channelType=TE/FX/AJ/AL → +Ziffern-Format
    │
    ├── meterInstallationPoint.yaml      Zähler: MeLo XOR Netzkopplungspunkt
    │   Felder: deviceNumber, meteringLocationId, gridCouplingPointId, msbActorId
    │   Bedingung: oneOf – entweder meteringLocationId ODER gridCouplingPointId
    │
    ├── generatingMarketLocation.yaml    CONSUMPTION vs. GENERATION
    │   Felder: maLoId, energyDirection, eivActorId (id, codingScheme),
    │           balancingGroupCode, subsidyCountryCode,
    │           tranches (trancheId, percentageShare)
    │   Bedingung: GENERATION → eivActorId + subsidyCountryCode Pflicht
    │              CONSUMPTION → balancingGroupCode Pflicht, eivActorId verboten
    │
    ├── transactionWithStatus.yaml       E03-Änderungsmeldung bedingte Status-Pflicht
    │   Felder: transactionId, messageType, transactionReason,
    │           status (statusCode, periodId, rejectionCode)
    │   Bedingung: messageType=E03 → status.periodId Pflicht (AHB [301][914][937])
    │              status.statusCode=E03 → rejectionCode Pflicht
    │
    ├── controlChannelDescription.yaml   Steuerkanal → Leistungsbeschreibung
    │   Felder: neLoId, hasControlChannel, controlChannelType
    │   Bedingung: hasControlChannel=true → controlChannelType (Z14|Z15) Pflicht
    │
    ├── usagePeriodWithReference.yaml    Z49/Z53 Datenverfügbarkeit
    │   Felder: periodId, dataStatus, validFrom, validTo, noDataReason
    │   Bedingung: dataStatus=Z49/Z48/Z47 → validFrom Pflicht, noDataReason verboten
    │              dataStatus=Z53/Z55/Z54 → noDataReason Pflicht, validFrom verboten
    │
    └── marketLocationConditional.yaml   Alle Regeln kombiniert (allOf)
        Felder: maLoId, energyDirection, bundleType, voltageLevel,
                profile (profileCode, profileType),
                meteringLocations (meLoId),
                supplier (actorId), dormancyReason, legalBasis,
                eivActorId (id, codingScheme), balancingGroupCode,
                subsidyCountryCode,
                tranches (trancheId, percentageShare)
        Bedingungen: ZW6/ZW7/ZAP × CONSUMPTION/GENERATION × Spannungsebene
                     kombiniert über if/then/else + allOf
```

---

## Felder-Namenskonvention / Field Naming Convention

Alle Feldnamen sind **lowerCamelCase** (englisch):

| Schema | Typ | lowerCamelCase Feldname |
|---|---|---|
| address | object | `additionalInfo`, `street`, `postOfficeBox`, `city`, `postalCode`, `countryCode` |
| validityPeriod | object | `validFrom`, `validTo` |
| obisCode | object | `code`, `description`, `label` |
| voltageLevel | object | `code`, `name`, `label` |
| multilingualLabel | object | `en`, `de` |
| marketActorId | object | `id`, `codingScheme`, `label` |
| marketActor | object | `id`, `externalId`, `name`, `isNaturalPerson`, `email`, `phone`, `address`, `roles`, `validity`, `label` |
| marketActorRole | object | `id`, `marketActorId`, `roleCode`, `validity`, `label` |
| communicationContact | object | `contactType`, `contactName`, `email`, `phone`, `fax`, `mobile` |
| marketLocation | object | `id`, `maLoId`, `gridAreaId`, `address`, `voltageLevel`, `energyDirection`, `status`, `locationBundleType`, `profile`, `balancingAreaCode`, `balancingGroupCode`, `packageId`, `validity`, `label` |
| marketLocationProfile | object | `profileCode`, `profileType`, `validity`, `label` |
| gridLocation | object | `id`, `neLoId`, `gridAreaId`, `address`, `voltageLevel`, `hasControlChannel`, `assignedMeteringPointOperator`, `products`, `obisCodes`, `validity`, `label` |
| meteringLocation | object | `id`, `meLoId`, `address`, `voltageLevel`, `assignedMeteringPointOperator`, `validity`, `label` |
| tranche | object | `id`, `trancheId`, `marketLocationId`, `percentageShare`, `assignedSupplier`, `validity`, `label` |
| dormantMarketLocation | object | `maLoId`, `dormancyReason`, `legalBasis`, `validity`, `label` |
| meter | object | `id`, `deviceNumber`, `meteringLocationId`, `gridCouplingPointId`, `msbActorId`, `gatewayId`, `validity`, `label` |
| gateway | object | `id`, `deviceNumber`, `msbActorId`, `connectedMeterIds`, `validity`, `label` |
| technicalResource | object | `id`, `externalId`, `gridOperatorActorId`, `operatorActorId`, `validity`, `label` |
| controllableResource | object | `id`, `externalId`, `technicalResourceId`, `gridOperatorActorId`, `eivActorId`, `validity`, `label` |
| controlDevice | object | `id`, `externalId`, `controllableResourceId`, `usedByNBActorId`, `usedByEIVActorId`, `validity`, `label` |
| controlBox | object | `id`, `externalId`, `controllableResourceId`, `usedByNBActorId`, `usedByEIVActorId`, `validity`, `label` |
| meterRegister | object | `id`, `meterId`, `registerCode`, `obisCode`, `validity`, `label` |
| gatewayRegister | object | `id`, `gatewayId`, `registerCode`, `obisCode`, `validity`, `label` |
| checkIdentifier | object | `value`, `description`, `communicationDirection`, `label` |
| messageTransaction | object | `transactionId`, `transactionReason`, `transactionReasonSupplement`, `startDate`, `checkIdentifier`, `status`, `usagePeriod`, `marketLocationId`, `label` |
| transactionStatus | object | `statusCode`, `rejectionCode`, `periodId`, `label` |
| usagePeriod | object | `periodId`, `dataAvailable`, `validFrom`, `validTo`, `label` |
| balancingArea | object | `id`, `code`, `name`, `controlAreaId`, `label` |
| balancingGroup | object | `id`, `code`, `name`, `balancingAreaId`, `managedByActorId`, `label` |
| controlArea | object | `id`, `code`, `name`, `responsibleActorId`, `financialActorId`, `label` |
| gridAccount | object | `id`, `code`, `name`, `marketAreaId`, `label` |
| marketArea | object | `id`, `code`, `name`, `virtualTradingPointActorId`, `label` |

---

## Mehrsprachigkeit / Multilingual

Jedes Feld enthält drei Ebenen:

```yaml
maLoId:
  description: "English description"          # Englische Beschreibung
  x-i18n:
    de:
      description: "Deutsche Beschreibung"    # Deutsche Beschreibung (führend)
  examples:
    Residential:
      summary: "Residential"                  # Englischer Bezeichner
      value: "51238696781"
  x-examples-i18n:
    de:
      Residential: "Haushalt"                 # Deutsche Übersetzung
```

---

## Bedingte Validierung / Conditional Validation (OAS 3.1)

```yaml
# Beispiel: locationBundle.yaml
if:
  properties:
    bundleType:
      const: ZW6
  required: [bundleType]
then:
  required: [profile, supplier]       # SLP-Profil und Lieferant Pflicht
  properties:
    meteringLocations:
      maxItems: 0                     # Messlokationen verboten
else:
  if:
    properties:
      bundleType:
        const: ZW7
    required: [bundleType]
  then:
    required: [meteringLocations]     # Messlokationen Pflicht
    properties:
      profile:
        not: {}                       # Profil verboten
  else:                               # ZAP
    required: [dormancyReason, legalBasis]
```

---

## EDIFACT-Mapping

Alle Schemas enthalten `x-edifact-mapping` mit Segment, Qualifier und Conditions:

```yaml
x-edifact-mapping:
  segment: LOC
  de3227: "Z16 (Marktlokation)"
  de3225: "ID der Marktlokation (11-stellig)"
```

---

## Normative Quellen / Normative Sources

- BDEW UTILMD Anwendungshandbuch Strom 2.1 (11.12.2025)
- BDEW AWH Rollenmodell ERM (Strom)
- BDEW Codelisten (Marktrollen, Spannungsebenen, OBIS)
- EDIFACT UTILMD S2.1
- JSON Schema 2020-12
- IEC 62056-21 (OBIS)
- [www.bdew-mako.de](https://www.bdew-mako.de)
