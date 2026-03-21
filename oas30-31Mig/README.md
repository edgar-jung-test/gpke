# OpenAPI 3.1 – Vollständige Migrationsanleitung für BDEW UTILMD

## 1. Kernunterschiede OAS 3.0 → OAS 3.1

### 1.1 JSON Schema Kompatibilität

OAS 3.1 ist zu **JSON Schema 2020-12 vollständig kompatibel**.
OAS 3.0 nutzte ein eigenes, eingeschränktes Subset.

| Eigenschaft | OAS 3.0 | OAS 3.1 | Auswirkung UTILMD |
|---|---|---|---|
| `if / then / else` | ❌ | ✅ | Alle bedingten AHB-Regeln direkt modellierbar |
| `nullable: true` | ✅ (proprietär) | ❌ | Ersetzen durch `type: ["string", "null"]` |
| `$ref` + eigene Properties | ❌ | ✅ | Felder bei `$ref` ergänzen ohne `allOf` |
| `exclusiveMinimum` als Zahl | ❌ | ✅ | z.B. `exclusiveMinimum: 0` statt Boolean |
| `unevaluatedProperties` | ❌ | ✅ | Striktere Objektvalidierung |
| `prefixItems` (Tupel) | ❌ | ✅ | Typisierte Arrays |
| `const` | ✅ (OAS 3.0.3+) | ✅ | Wie gehabt |
| `oneOf / anyOf / allOf` | ✅ | ✅ | Wie gehabt, aber mächtiger kombinierbar |

### 1.2 Breaking Changes bei der Migration

```yaml
# OAS 3.0 – nullable (VERALTET in 3.1)
validTo:
  type: string
  nullable: true          # proprietär, in 3.1 abgelöst

# OAS 3.1 – korrekt
validTo:
  type: ["string", "null"]  # JSON Schema 2020-12 Standard
```

```yaml
# OAS 3.0 – $ref blockiert eigene Properties (Workaround mit allOf nötig)
properties:
  address:
    allOf:
      - $ref: "./common/address.yaml"
      - description: "Pflichtadresse der Marktlokation"

# OAS 3.1 – $ref und eigene Properties direkt kombinierbar
properties:
  address:
    $ref: "./common/address.yaml"
    description: "Pflichtadresse der Marktlokation"   # direkt erlaubt
```

---

## 2. `if/then/else` Grundstruktur

```yaml
# Grundmuster
if:
  properties:
    feldName:
      const: WERT          # oder: enum: [A, B], type: string, etc.
  required: [feldName]     # WICHTIG: ohne dies greift die Bedingung auch
                           # wenn das Feld fehlt (leere Objekte würden passen)

then:
  required: [pflichtFeld]
  properties:
    verbotenessFeld:
      not: {}              # Feld darf nicht vorhanden sein

else:
  required: [anderePflicht]
  properties:
    anderesFeld:
      not: {}
```

### Regeln für robuste `if`-Blöcke:
- **Immer `required: [feldName]`** im `if`-Block angeben
- `const` für einen einzelnen Wert, `enum` für mehrere
- Verschachtelung: `else:` kann wieder ein `if/then/else` enthalten
- Mehrere unabhängige Bedingungen: `allOf` mit mehreren `if/then/else`

---

## 3. UTILMD-spezifische Muster

### 3.1 XOR-Constraint (genau eins von zwei)

SQL ERM: `CK_Zaehler_Ort` — MeLo oder NKP, niemals beide, niemals keines.

```yaml
oneOf:
  - required: [meteringLocationId]
    properties:
      gridCouplingPointId:
        not: {}          # verboten wenn MeLo gesetzt

  - required: [gridCouplingPointId]
    properties:
      meteringLocationId:
        not: {}          # verboten wenn NKP gesetzt
```

**Gleiches Muster für:** Steuereinrichtung XOR Steuerbox.

### 3.2 Mehrstufige Bedingungen (ZW6/ZW7/ZAP)

```yaml
if:
  properties:
    bundleType: { const: ZW6 }
  required: [bundleType]
then:
  required: [profile, supplier]
  properties:
    meteringLocations: { maxItems: 0 }
    dormancyReason:    { maxLength: 0 }
else:
  if:
    properties:
      bundleType: { const: ZW7 }
    required: [bundleType]
  then:
    required: [meteringLocations]
    properties:
      profile: { not: {} }
  else:
    # ZAP – ruhend
    required: [dormancyReason, legalBasis]
    properties:
      supplier:          { not: {} }
      meteringLocations: { maxItems: 0 }
```

### 3.3 Mehrere unabhängige Bedingungen (`allOf`)

```yaml
allOf:
  # Bedingung 1: Energieflussrichtung
  - if:
      properties:
        energyDirection: { const: GENERATION }
      required: [energyDirection]
    then:
      required: [eivActorId, subsidyCountryCode]
    else:
      required: [balancingGroupCode]
      properties:
        eivActorId: { not: {} }

  # Bedingung 2: Spannungsebene
  - if:
      properties:
        voltageLevel:
          enum: [E03, E04, E05]
      required: [voltageLevel]
    then:
      properties:
        bundleType:
          const: ZW7    # MS/HS/HöS → nur gemessen
```

### 3.4 Format-Validierung (AHB [939]/[940])

```yaml
if:
  properties:
    channelType: { const: EM }
  required: [channelType]
then:
  properties:
    value:
      format: email
      pattern: '^[^@]+@[^@]+\.[^@]+$'   # [939]: @ und . enthalten
else:
  properties:
    value:
      pattern: '^\+[0-9]+$'             # [940]: + dann nur Ziffern
```

### 3.5 Verschachtelte Bedingung

```yaml
if:
  properties:
    messageType: { const: E03 }
  required: [messageType]
then:
  required: [status]
  properties:
    status:
      required: [statusCode, periodId]
      if:
        properties:
          statusCode: { const: E03 }
        required: [statusCode]
      then:
        required: [rejectionCode]        # Ablehnung → EBD-Code Pflicht
      else:
        properties:
          rejectionCode: { not: {} }
```

### 3.6 Datenverfügbarkeit (Z49/Z53)

```yaml
if:
  properties:
    dataStatus:
      enum: [Z49, Z48, Z47]
  required: [dataStatus]
then:
  required: [validFrom]
  properties:
    noDataReason: { not: {} }
else:
  required: [noDataReason]
  properties:
    validFrom: { not: {} }
    validTo:   { not: {} }
```

---

## 4. Übersichtstabelle UTILMD-Bedingungen → OAS 3.1

| AHB-Bedingung | EDIFACT-Referenz | OAS 3.1-Pattern |
|---|---|---|
| ZW6 → Profil Pflicht | SG4 STS DE9013=ZW6 | `if const: ZW6 then required: [profile]` |
| ZW7 → MeLo Pflicht | SG4 STS DE9013=ZW7 | `if const: ZW7 then required: [meteringLocations]` |
| ZAP → Rechtsgrundlage Pflicht | SG4 STS DE9013=ZAP | `if const: ZAP then required: [legalBasis]` |
| wMSB Z40 → Ausübungsgrundlage | SG10 CAV Z91/Z40 | `if const: Z40 then required: [operatingBasis]` |
| GENERATION → EIV Pflicht | SG8 SEQ, CCI | `if const: GENERATION then required: [eivActorId]` |
| GENERATION → Land der Förderung | SG10 CCI+Z23 | `if const: GENERATION then required: [subsidyCountryCode]` |
| CONSUMPTION → Bilanzkreis Pflicht | Stammdaten | `if const: CONSUMPTION then required: [balancingGroupCode]` |
| EM → E-Mail-Format | COM DE3155=EM [939] | `if const: EM then pattern: ^[^@]+@[^@]+\.[^@]+$` |
| TE/FX → +Ziffern-Format | COM DE3155 [940] | `else pattern: ^\+[0-9]+$` |
| Steuereinrichtung XOR Steuerbox | ERM CK_SR | `oneOf` + gegenseitiges `not: {}` |
| Zähler: MeLo XOR NKP | ERM CK_Zaehler_Ort | `oneOf` + gegenseitiges `not: {}` |
| E03 → Zeitraum-ID Pflicht | BGM [301][914][937] | `if const: E03 then required: [periodId]` |
| Ablehnung → Ablehnungsgrund | STS DE9012 | Verschachteltes `if const: E03` |
| Z49/Z48/Z47 → validFrom Pflicht | SG6 RFF DE1153 | `if enum: [Z49,Z48,Z47] then required: [validFrom]` |
| Z53/Z55/Z54 → noDataReason Pflicht | SG6 RFF DE1153 | `else required: [noDataReason]` |
| Steuerkanal → Leistungsbeschreibung | SG10 CCI+Z49/CAV ZF2 | `if const: true then required: [controlChannelType]` |
| MS/HS/HöS → nur ZW7 | Spannungsebene E03-E05 | `if enum: [E03,E04,E05] then bundleType const: ZW7` |

---

## 5. Tooling-Unterstützung für OAS 3.1

| Tool | OAS 3.1 | `if/then/else` | Hinweis |
|---|---|---|---|
| **Redocly CLI** | ✅ | ✅ | Empfohlen für Validierung |
| **Swagger UI 5.x** | ✅ | ⚠️ | Validierung ok, UI zeigt Conditions begrenzt an |
| **Stoplight Studio** | ✅ | ✅ | Gute visuelle Unterstützung |
| **Speakeasy** | ✅ | ✅ | SDK-Generierung |
| **openapi-generator** | ⚠️ | ⚠️ | Noch eingeschränkt bei 3.1 |
| **Ajv** | ✅ | ✅ | Server-seitige Validierung |

```bash
# Validierung mit Redocly
npx @redocly/cli lint openapi31.yaml

# Validierung mit Ajv (Node.js)
npx ajv validate -s schemas/locationBundle.yaml -d testdata/bundle-zw6.json
```

---

## 6. Dateistruktur

```
oas30-31Mig/
├── openapi31.yaml                            ← Root (OAS 3.1)
└── schemas/
    ├── locationBundle.yaml                   ← ZW6 / ZW7 / ZAP
    ├── meteringPointOperatorAssignment.yaml  ← Z39 / Z40 / Z41 (MSB-Typ)
    ├── controllableResourceWithControl.yaml  ← SR: SE XOR SB (oneOf)
    ├── communicationChannel.yaml             ← EM vs. TE/FX Format [939/940]
    ├── meterInstallationPoint.yaml           ← Zähler: MeLo XOR NKP (oneOf)
    ├── generatingMarketLocation.yaml         ← CONSUMPTION vs. GENERATION
    ├── transactionWithStatus.yaml            ← E03 → Zeitraum-ID (verschachtelt)
    ├── controlChannelDescription.yaml        ← Steuerkanal → Leistungsbeschreibung
    ├── usagePeriodWithReference.yaml         ← Z49/Z53/Z48/Z55/Z47/Z54
    └── marketLocationConditional.yaml        ← Alle Regeln kombiniert (allOf)
```

