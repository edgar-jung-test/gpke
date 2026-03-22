# EDI@Energy API Headers – OpenAPI 3.0 Schema

**Basis:** Präsentation „API Header – Erweiterung der EDI@Energy HTTP API Header"  
**Standard:** RFC 9110 · RFC 7240 · RFC 8694 · RFC 9421 · RFC 9530 · RFC 7515 · RFC 7516 · W3C Trace Context · OpenAPI 3.0.3

---

## Verzeichnisstruktur / Directory Structure

```
openapi.yaml                          ← Root-Dokument mit allen components/$ref
example-usage.yaml                    ← Verwendungsbeispiel (3 Endpoint-Patterns)
REVIEW.md                             ← Header-Prüfung und Korrekturen
│
├── headers/                          ← Einzelne Header als eigenständige YAML-Dateien
│   ├── xRequestId.yaml                 X-Request-ID        Request
│   ├── xMessageId.yaml                 X-Message-ID        Request + Response
│   ├── idempotencyKey.yaml             Idempotency-Key     Request
│   ├── traceparent.yaml                traceparent         Request
│   ├── prefer.yaml                     Prefer              Request
│   ├── location.yaml                   Location            Response
│   ├── preferenceApplied.yaml          Preference-Applied  Response
│   ├── retryAfter.yaml                 Retry-After         Response
│   ├── eTag.yaml                       ETag                Response
│   ├── ifMatch.yaml                    If-Match            Request
│   ├── xServerVersion.yaml             X-Server-Version    Response
│   ├── xApiSpecVersion.yaml            X-API-Spec-Version  Response
│   ├── xApiSpecRef.yaml                X-API-Spec-Ref      Response
│   ├── xApiSpecId.yaml                 X-API-Spec-ID       Response
│   ├── xClientVersion.yaml             X-Client-Version    Request
│   ├── xBackendVersion.yaml            X-Backend-Version   Response
│   ├── contentDigest.yaml              Content-Digest      Request + Response (RFC 9530)
│   ├── signatureInput.yaml             Signature-Input     Request (RFC 9421)
│   └── signature.yaml                  Signature           Request (RFC 9421)
│
└── groups/                           ← Gruppierte Header für schnelle Komposition
    ├── generalRequestHeaders.yaml      Alle allg. Request-Header
    ├── generalResponseHeaders.yaml     Alle allg. Response-Header
    ├── stateMachineHeaders.yaml        ETag + If-Match für State-Machine
    └── securityHeaders.yaml            Content-Digest + Signature-Input + Signature
```

---

## Korrigierte Header-Namen

Folgende Abweichungen gegenüber der Präsentation wurden korrigiert:

| Vorlage | Korrektur | Begründung |
|---|---|---|
| `X-Request-Id` | **`X-Request-ID`** | Akronym ID großschreiben (HTTP-Header-Konvention) |
| `X-Message-Id` | **`X-Message-ID`** | Akronym ID großschreiben |
| `Idempotency-ID` | **`Idempotency-Key`** | RFC 8694 / Stripe-Standard; Präsentation zeigte im Beispiel bereits den richtigen Namen |
| `Etag:` | **`ETag`** | Kanonische IANA-Schreibweise; kein Doppelpunkt im Header-Namen |
| `X-Api-Spec-Version` | **`X-API-Spec-Version`** | Akronym API großschreiben |
| `X-Api-Spec-Ref` | **`X-API-Spec-Ref`** | Akronym API großschreiben |
| `X-Api-Spec-Id` | **`X-API-Spec-ID`** | Akronyme API und ID großschreiben |

---

## Alle Header im Überblick

### Gruppe 1: Allgemeine Header

#### Request-Header

| Header-Name | Datei | RFC/Standard | Pflicht | Beschreibung |
|---|---|---|---|---|
| `X-Request-ID` | `xRequestId.yaml` | Konvention | Nein | Eindeutige Kennung eines einzelnen Requests (UUID v4) |
| `X-Message-ID` | `xMessageId.yaml` | EDI@Energy | Nein | Prozess-übergreifende Transaktionskennung (UUID v4) |
| `Idempotency-Key` | `idempotencyKey.yaml` | RFC 8694 | Nein | Idempotenz-Schlüssel für sichere Retries (UUID v4, Client-generiert) |
| `traceparent` | `traceparent.yaml` | W3C Trace Context | Nein | End-to-End Distributed Tracing (Format: `00-{32hex}-{16hex}-{2hex}`) |
| `Prefer` | `prefer.yaml` | RFC 7240 | Nein | Client-Präferenz: `dry-run`, `respond-async`, `return=minimal` |
| `X-Client-Version` | `xClientVersion.yaml` | Konvention | Nein | Client-System-Version (Format: `{system}_{env}_{version}`) |

#### Response-Header

| Header-Name | Datei | RFC/Standard | Beschreibung |
|---|---|---|---|
| `X-Message-ID` | `xMessageId.yaml` | EDI@Energy | Echo der Prozess-ID aus dem Request |
| `Location` | `location.yaml` | RFC 9110 §10.2.2 | URI der erstellten/aufgelösten Ressource |
| `Preference-Applied` | `preferenceApplied.yaml` | RFC 7240 | Bestätigt angewandte `Prefer`-Tokens |
| `Retry-After` | `retryAfter.yaml` | RFC 9110 §10.2.4 | Frühester Retry-Zeitpunkt (HTTP-date oder Sekunden) |

### Gruppe 4: Sicherheits-Header (Security Headers)

| Header-Name | Datei | RFC | Pflicht | Beschreibung |
|---|---|---|---|---|
| `Content-Digest` | `contentDigest.yaml` | RFC 9530 | Ja bei Body | SHA-256-Hash des Request/Response-Body für HTTP-Message-Signatur |
| `Signature-Input` | `signatureInput.yaml` | RFC 9421 | Ja | Deklariert signierte Komponenten + Metadaten (created, keyid, alg) |
| `Signature` | `signature.yaml` | RFC 9421 | Ja | Base64url-kodierter Signaturwert (ECDSA P-256 oder Ed25519) |

**Signierte Komponenten POST/PATCH:** `"@method"` `"@authority"` `"@target-uri"` `"content-type"` `"accept"` `"content-digest"` `"date"` `"x-request-id"` `"x-api-spec-ref"` `"x-api-spec-version"`

**Signierte Komponenten GET:** `"@method"` `"@path"` `"@query"` `"host"` `"date"` `"x-request-id"` `"x-api-spec-ref"` `"x-api-spec-version"`

Vollständige Dokumentation: [`docs/security/README.md`](../docs/security/README.md)

### Gruppe 2: State-Machine Header

| Header-Name | Datei | Richtung | RFC | Beschreibung |
|---|---|---|---|---|
| `ETag` | `eTag.yaml` | Response | RFC 9110 §8.8.3 | Aktueller Zustand der Transaktion (`"state:running"`) |
| `If-Match` | `ifMatch.yaml` | Request | RFC 9110 §13.1.1 | Zustandsübergang nur wenn ETag übereinstimmt |

**State-Werte:** `"state:pending"` · `"state:running"` · `"state:completed"` · `"state:failed"` · `"state:cancelled"`

### Gruppe 3: Version-Control Header

| Header-Name | Datei | Richtung | Beschreibung |
|---|---|---|---|
| `X-Server-Version` | `xServerVersion.yaml` | Response | Version des Hub/Serversystems (SemVer) |
| `X-API-Spec-Version` | `xApiSpecVersion.yaml` | Response | Version der OpenAPI-Spec aus Git |
| `X-API-Spec-Ref` | `xApiSpecRef.yaml` | Response | Git-Referenz der API-Spec (`git:EDI-Energy/api-electricity@tag`) |
| `X-API-Spec-ID` | `xApiSpecId.yaml` | Response | Branch/Release-ID der aktiven API-Spec |
| `X-Client-Version` | `xClientVersion.yaml` | Request | Client-System-Version (Format: `{system}_{env}_{version}`) |
| `X-Backend-Version` | `xBackendVersion.yaml` | Response | Backend-System-Version (Format: `{system}_{env}_{version}`) |

---

## Wichtige RESTful-Regeln

### Response-only Header
`Location`, `Retry-After`, `ETag`, `Preference-Applied` sind **ausschließlich Response-Header**.
Sie dürfen **nicht** als `parameters[in: header]` definiert werden, sondern nur unter
`responses[x].headers`:

```yaml
# ✅ KORREKT – Response-Header
responses:
  '201':
    headers:
      Location:
        $ref: "./openapi.yaml#/components/headers/location"

# ❌ FALSCH – Response-Header als Parameter
parameters:
  - name: Location
    in: header   # nicht erlaubt für Response-only Header
```

### ETag-Werte müssen in Anführungszeichen stehen
RFC 9110 schreibt vor, dass ETag-Werte in doppelten Anführungszeichen stehen müssen:

```http
# ✅ Korrekt
ETag: "state:running"

# ❌ Falsch (Wert ohne Anführungszeichen)
ETag: state:running
```

### `traceparent` — Lowercase
Der W3C-Standard schreibt Lowercase vor. Niemals `Traceparent` oder `TraceParent`.

---

## Verwendung / Usage

### Einzelnen Header referenzieren (Request)

```yaml
parameters:
  - $ref: "./headers/openapi.yaml#/components/parameters/xRequestId"
  - $ref: "./headers/openapi.yaml#/components/parameters/idempotencyKey"
  - $ref: "./headers/openapi.yaml#/components/parameters/traceparent"
  - $ref: "./headers/openapi.yaml#/components/parameters/prefer"
```

### Einzelnen Header referenzieren (Response)

```yaml
responses:
  '202':
    description: Accepted
    headers:
      Location:
        $ref: "./headers/openapi.yaml#/components/headers/location"
      Retry-After:
        $ref: "./headers/openapi.yaml#/components/headers/retryAfter"
      ETag:
        $ref: "./headers/openapi.yaml#/components/headers/eTag"
```

### State-Machine Pattern (vollständig)

```yaml
# 1. GET: Server liefert aktuellen Zustand im ETag
GET /messages/{id}/state
→ Response: ETag: "state:running"

# 2. PATCH: Client sendet ETag zurück in If-Match
PATCH /messages/{id}/state
  If-Match: "state:running"
  { "targetState": "cancelled" }
→ Response 200: ETag: "state:cancelled"
→ Response 412: ETag: "state:completed"  (Zustand hat sich geändert)
```

### Sicherheits-Pattern POST mit JWE / Security pattern POST with JWE

```yaml
# Client erstellt JWS-signierten und JWE-verschlüsselten Body,
# berechnet SHA-256 des JWE-Tokens und signiert die HTTP-Nachricht:
POST /malo/{id}/registrations
  Content-Type: application/jose
  Content-Digest: sha-256=:uU0p7h6qv6bqGJgYy3m8n2mY0cKc6lQ5qJv8W2r9bLk=:
  Signature-Input: sig1=("@method" "@authority" "@target-uri" "content-type"
    "accept" "content-digest" "date" "x-request-id"
    "x-api-spec-ref" "x-api-spec-version");
    created=1769940930;expires=1769941230;
    keyid="client-http-sig-01";alg="ecdsa-p256-sha256"
  Signature: sig1=:m1dP0w7qZ8QmM8n6f0dVbQ4h2lJd0q3H6mQkq9Vxq8g=:
  Body: eyJhbGciOiJSU0EtT0FFUC0yNTYiLCJlbmMiOiJBMjU2R0NNIn0...
```

### Async-Pattern mit dry-run (vollständig)

```yaml
# 1. Client sendet Prefer: dry-run oder respond-async
POST /messages
  Prefer: dry-run
  Idempotency-Key: 2f6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9c1

# 2. Server bestätigt und liefert Poll-URL
→ Response 202:
  Preference-Applied: dry-run
  Location: /jobs/abc123/status
  Retry-After: 30
  ETag: "state:pending"
```

---

## Normative Quellen

| Standard | Anwendung |
|---|---|
| RFC 9110 | `Location`, `ETag`, `If-Match`, `Retry-After` |
| RFC 7240 | `Prefer`, `Preference-Applied` |
| RFC 8694 | `Idempotency-Key` |
| W3C Trace Context Level 2 | `traceparent` |
| IANA Header Field Registry | Alle Standardnamen |
| RFC 9421 | `Signature`, `Signature-Input` (HTTP Message Signatures) |
| RFC 9530 | `Content-Digest` (Digest Fields) |
| RFC 7515 | JSON Web Signature (JWS) — Payload-Signatur |
| RFC 7516 | JSON Web Encryption (JWE) — Payload-Verschlüsselung |
| EDI@Energy Konvention | `X-*` Custom-Header |
