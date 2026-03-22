# API Security – HTTP Message Signatures, JWS & JWE

> Deutsch und Englisch in einer README.  
> German and English in one README.

---

## DE – Überblick / EN – Overview

### DE
Die EDI@Energy REST APIs verwenden ein dreischichtiges Sicherheitsmodell:

1. **Authentifizierung** — OAuth 2.0 Bearer Token (JWT)
2. **Payload-Integrität** — JWS (JSON Web Signature, RFC 7515): signiert den Body
3. **Payload-Vertraulichkeit** — JWE (JSON Web Encryption, RFC 7516): verschlüsselt den Body
4. **Nachrichtenintegrität** — HTTP Message Signatures (RFC 9421): signiert Header + Content-Digest

### EN
The EDI@Energy REST APIs use a three-layer security model:

1. **Authentication** — OAuth 2.0 Bearer Token (JWT)
2. **Payload integrity** — JWS (JSON Web Signature, RFC 7515): signs the body
3. **Payload confidentiality** — JWE (JSON Web Encryption, RFC 7516): encrypts the body
4. **Message integrity** — HTTP Message Signatures (RFC 9421): signs headers + Content-Digest

---

## Architektur / Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        HTTP/2 Request                           │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                       HEADERS                            │   │
│  │  Authorization: Bearer <JWT>          ← Layer 1: Auth    │   │
│  │  Content-Type: application/jose       ← JWE body         │   │
│  │  Content-Digest: sha-256=:<hash>:     ← Body hash        │   │
│  │  Signature-Input: sig1=(...)          ← What is signed   │   │
│  │  Signature: sig1=:<value>:            ← Layer 4: RFC 9421│   │
│  │  Date, X-Request-ID, X-Api-Spec-Ref, ...                │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                        BODY                              │   │
│  │                                                          │   │
│  │  JWE compact serialization:                             │   │
│  │  ┌─────────────────────────────────────────────────┐   │   │
│  │  │  JWE Header . Encrypted Key . IV . Ciphertext   │   │   │
│  │  │              └── contains ──┘                   │   │   │
│  │  │                   JWS token:                    │   │   │
│  │  │  ┌──────────────────────────────────────────┐  │   │   │
│  │  │  │  JWS Header . Payload . Signature        │  │   │   │
│  │  │  │              └── is ──┘                  │  │   │   │
│  │  │  │              JSON payload                │  │   │   │
│  │  │  └──────────────────────────────────────────┘  │   │   │
│  │  └─────────────────────────────────────────────────┘   │   │
│  │    Layer 2: JWS (integrity)                             │   │
│  │    Layer 3: JWE (confidentiality)                       │   │
│  └─────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```
Open interactive security-flow view](https://htmlpreview.github.io/?https://github.com/edgar-jung-test/gpke/blob/main/docs/security/security-flow.html)
---

## Layer 1 – Authentifizierung / Authentication (OAuth 2.0 JWT)

### DE
Jede Anfrage muss ein gültiges OAuth 2.0 Bearer-Token im `Authorization`-Header tragen.
Das Token ist ein JWT (JSON Web Token), das vom EDI@Energy-Autorisierungsserver ausgestellt wird.

### EN
Every request must carry a valid OAuth 2.0 Bearer token in the `Authorization` header.
The token is a JWT issued by the EDI@Energy authorization server.

```http
Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.
  eyJpc3MiOiJhdXRoLmVkaWVuZXJneS5kZSIsInN1YiI6Im1hcmtldHBhcnRuZXItMTIzIiwi
  YXVkIjoiYXBpLm1ha29odWIuY29tIiwiaWF0IjoxNzA2NzgyNTMwLCJleHAiOjE3MDY3ODYx
  MzB9.signature
```

**JWT Claims (DE/EN):**

| Claim | Beschreibung / Description |
|-------|---------------------------|
| `iss` | Aussteller / Issuer — EDI@Energy authorization server |
| `sub` | Marktpartner-ID / Market partner ID (MP-ID) |
| `aud` | Ziel-API / Target API endpoint |
| `iat` | Ausstellungszeitpunkt / Issued at (Unix timestamp) |
| `exp` | Ablaufzeit / Expiry (max. 1 hour) |
| `roles` | Marktrollen / Market roles (e.g. `["LF", "NB"]`) |

---

## Layer 2 – Payload-Integrität / Payload Integrity (JWS, RFC 7515)

### DE
Der JSON-Payload wird als JWS (JSON Web Signature) im Compact Serialization Format signiert.
Dies stellt sicher, dass der Inhalt auf dem Transportweg nicht verändert wurde und vom
angegebenen Absender stammt.

### EN
The JSON payload is signed as JWS (JSON Web Signature) in Compact Serialization format.
This ensures the content has not been modified in transit and originates from the
declared sender.

**Empfohlener Algorithmus / Recommended algorithm:** `ES256` (ECDSA with P-256 and SHA-256)

### JWS Header

```json
{
  "alg": "ES256",
  "typ": "JWT",
  "kid": "client:mabishub-client-key-40454580000000"
}
```

### JWS Payload (Beispiel / Example)

```json
{
  "iss": "client:mabishub-40454580000000",
  "aud": "mabishub/malo-registrations",
  "iat": 1706782530,
  "exp": 1706782830,
  "supplyStartDate": "2025-04-01",
  "transactionReason": "ZA1",
  "isHouseholdCustomer": true,
  "marketLocationIdentification": {
    "identificationMode": "maloIdOnly",
    "maLoId": "51238696781"
  }
}
```

### JWS Compact Serialization

```
eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImNsaWVudC1wYXlsb2FkLXNpZ24tMDEifQ
.
eyJpc3MiOiJjbGllbnQ6bWFiaXNodWItNDA0NTQ1ODAwMDAwMDAiLCJzdXBwbHlTdGFydERhdGUiOiIyMDI1LTA0LTAxIn0
.
MEUCIQDxx...signature
```

---

## Layer 3 – Payload-Vertraulichkeit / Payload Confidentiality (JWE, RFC 7516)

### DE
Das JWS-Token (signierter Payload) wird anschließend als JWE (JSON Web Encryption)
verschlüsselt. Das Ergebnis ist das finale Body-Token im Format `application/jose`.
Damit sind sowohl Integrität (JWS) als auch Vertraulichkeit (JWE) gewährleistet.

### EN
The JWS token (signed payload) is then encrypted as JWE (JSON Web Encryption).
The result is the final body token in `application/jose` format.
This ensures both integrity (JWS) and confidentiality (JWE).

**Empfohlener Algorithmus / Recommended algorithm:**
- Key encryption: `RSA-OAEP-256`
- Content encryption: `A256GCM`

### JWE Header

```json
{
  "alg": "RSA-OAEP-256",
  "enc": "A256GCM",
  "cty": "JWT",
  "kid": "hub-payload-enc-07"
}
```

### JWE Compact Serialization (5 parts)

```
eyJhbGciOiJSU0EtT0FFUC0yNTYiLCJlbmMiOiJBMjU2R0NNIiwiY3R5IjoiSldUIiwia2lkIjoiaHViLXBheWxvYWQtZW5jLTA3In0
.
m3kZ2...Q
.
48V1_ALb6US04U3b
.
u9f0c...uWQ
.
o2mP...8w
```

Structure: `JWE-Header . Encrypted-Key . IV . Ciphertext . Auth-Tag`

### Ablauf JWS → JWE / Flow JWS → JWE

```
1. JSON Payload
       │
       ▼
2. JWS Sign (ES256, client private key)
       │  Result: eyJhbGciOiJFUzI1NiJ9.payload.signature
       ▼
3. JWE Encrypt (RSA-OAEP-256 + A256GCM, server public key)
       │  Result: JWE compact token
       ▼
4. HTTP Body: Content-Type: application/jose
              Body: <JWE compact token>
```

---

## Layer 4 – Nachrichtenintegrität / Message Integrity (HTTP Message Signatures, RFC 9421)

### DE
Zusätzlich zur Payload-Signatur (JWS) wird die gesamte HTTP-Nachricht signiert.
Dies schützt vor Replay-Attacken und Header-Manipulation. Die Signatur deckt
ausgewählte HTTP-Header sowie den `Content-Digest` (SHA-256 des Body) ab.

### EN
In addition to the payload signature (JWS), the entire HTTP message is signed.
This protects against replay attacks and header manipulation. The signature covers
selected HTTP headers and the `Content-Digest` (SHA-256 of the body).

### Neue Header / New Headers

| Header | RFC | Pflicht / Required | Richtung / Direction |
|--------|-----|--------------------|----------------------|
| `Content-Digest` | RFC 9530 | Ja bei Body / Yes with body | Request + Response |
| `Signature-Input` | RFC 9421 | Ja / Yes | Request |
| `Signature` | RFC 9421 | Ja / Yes | Request |

### Abgedeckte Komponenten / Covered Components

**POST / PATCH (mit Body / with body):**
```
"@method" "@authority" "@target-uri" "content-type" "accept"
"content-digest" "date" "x-request-id" "x-api-spec-ref" "x-api-spec-version"
```

**GET (ohne Body / without body):**
```
"@method" "@path" "@query" "host" "date" "x-request-id"
"x-api-spec-ref" "x-api-spec-version"
```

### Algorithmen / Algorithms

| Algorithmus | Beschreibung | Empfehlung |
|-------------|-------------|-----------|
| `ecdsa-p256-sha256` | ECDSA mit P-256 und SHA-256 | Primär / Primary |
| `ed25519` | Edwards-Curve DSA | Alternativ / Alternative |

---

## Vollständige Beispiele / Complete Examples

### Beispiel 1: GET ohne Body / GET without body

```http
GET /malo/51238696781/registrations HTTP/2
Host: api.makohub.com
Accept: application/json
Date: Sun, 01 Feb 2026 10:15:30 GMT
Authorization: Bearer eyJhbGciOiJSUzI1NiJ9...
X-Request-Id: 7b5d3e2a-4c1a-4c0b-9e2a-1fd2c9a2b7d1
X-Api-Spec-Ref: git:EDI-Energy/api-electricity@2026-02-02-consultation
X-Api-Spec-Version: 1.2
Signature-Input: sig1=("@method" "@path" "@query" "host" "date"
  "x-request-id" "x-api-spec-ref" "x-api-spec-version");
  created=1706782530;expires=1706782830;
  keyid="client-ed25519-01";alg="ed25519"
Signature: sig1=:MEQCIG0H4V4F9H0X9Y5k3y9w5q4k3vV8d1qzH7XrFQq4Ai
  Bv3Z8f5h1Xz0M0H7mXyZq8m0b1Y2n5p8d0cH0A==:
```

### Beispiel 2: POST mit JWS-signiertem Body / POST with JWS-signed body

```http
POST /malo/51238696781/registrations HTTP/2
Host: api.makohub.com
Content-Type: application/json
Accept: application/json
Date: Sun, 01 Feb 2026 10:15:30 GMT
Authorization: Bearer eyJhbGciOiJSUzI1NiJ9...
X-Request-Id: 7b5d3e2a-4c1a-4c0b-9e2a-1fd2c9a2b7d1
X-Api-Spec-Ref: git:EDI-Energy/api-electricity@2026-02-02-consultation
X-Api-Spec-Version: 1.2
Content-Digest: sha-256=:X48E9qOokqqrvdts8nOJRJN3OWDUoyWxBf7kbu9DBPE=:
Signature-Input: sig1=("@method" "@authority" "@target-uri" "content-type"
  "accept" "content-digest" "date" "x-request-id" "x-api-spec-ref"
  "x-api-spec-version");created=1706782530;expires=1706782830;
  keyid="client-http-sig-01";alg="ecdsa-p256-sha256"
Signature: sig1=:m1dP0w7qZ8QmM8n6f0dVbQ4h2lJd0q3H6mQkq9Vxq8g=:

eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImNsaWVudC1wYXlsb2FkLXNpZ24tMDEifQ.
eyJzdXBwbHlTdGFydERhdGUiOiIyMDI1LTA0LTAxIiwidHJhbnNhY3Rpb25SZWFzb24iOiJaQTEifQ.
MEUCIQDxxxx...signature
```

### Beispiel 3: POST mit JWE-verschlüsseltem Body / POST with JWE-encrypted body

```http
POST /malo/51238696781/registrations HTTP/2
Host: api.makohub.com
Content-Type: application/jose
Accept: application/json
Date: Sun, 01 Feb 2026 10:15:30 GMT
Authorization: Bearer eyJhbGciOiJSUzI1NiJ9...
X-Request-Id: 7b5d3e2a-4c1a-4c0b-9e2a-1fd2c9a2b7d1
X-Api-Spec-Ref: git:EDI-Energy/api-electricity@2026-02-02-consultation
X-Api-Spec-Version: 1.2
Content-Digest: sha-256=:uU0p7h6qv6bqGJgYy3m8n2mY0cKc6lQ5qJv8W2r9bLk=:
Signature-Input: sig1=("@method" "@authority" "@target-uri" "content-type"
  "accept" "content-digest" "date" "x-request-id" "x-api-spec-ref"
  "x-api-spec-version");created=1769940930;expires=1769941230;
  keyid="client-http-sig-01";alg="ecdsa-p256-sha256"
Signature: sig1=:m1dP0w7qZ8QmM8n6f0dVbQ4h2lJd0q3H6mQkq9Vxq8g=:

eyJhbGciOiJSU0EtT0FFUC0yNTYiLCJlbmMiOiJBMjU2R0NNIiwiY3R5IjoiSldUIiwia2lkIjoiaHViLXBheWxvYWQtZW5jLTA3In0.
m3kZ2...Q.48V1_ALb6US04U3b.u9f0c...uWQ.o2mP...8w
```

---

## Schlüsselverwaltung / Key Management

### DE
Jeder Marktpartner (MP) benötigt zwei Schlüsselpaare:

1. **Payload-Signaturschlüssel** (für JWS)
   - Algorithmus: ECDSA P-256
   - Key-ID Format: `client:<mp-id>-payload-sign-<version>`
   - Beispiel: `client:mabishub-40454580000000-sign-01`

2. **HTTP-Signaturschlüssel** (für RFC 9421)
   - Algorithmus: ECDSA P-256 oder Ed25519
   - Key-ID Format: `client-http-sig-<version>`
   - Beispiel: `client-http-sig-01`

Der Server stellt seinen **öffentlichen JWE-Verschlüsselungsschlüssel** bereit:
   - Algorithmus: RSA-OAEP-256 (Key) + A256GCM (Content)
   - Key-ID Format: `hub-payload-enc-<version>`
   - Beispiel: `hub-payload-enc-07`

### EN
Each market participant (MP) requires two key pairs:

1. **Payload signing key** (for JWS)
   - Algorithm: ECDSA P-256
   - Key-ID format: `client:<mp-id>-payload-sign-<version>`

2. **HTTP signing key** (for RFC 9421)
   - Algorithm: ECDSA P-256 or Ed25519
   - Key-ID format: `client-http-sig-<version>`

The server provides its **public JWE encryption key**:
   - Algorithm: RSA-OAEP-256 (key wrap) + A256GCM (content encryption)
   - Key-ID format: `hub-payload-enc-<version>`

---

## Verarbeitungsreihenfolge (Server) / Processing Order (Server)

### Eingehende Anfrage / Incoming request

```
1. Bearer Token prüfen (OAuth 2.0)            ← Sofortige Ablehnung bei Fehler
        │
2. HTTP Message Signature prüfen (RFC 9421)   ← Content-Digest + Signature verifizieren
        │
3. Content-Digest gegen Body prüfen           ← SHA-256 des empfangenen Body
        │
4. JWE entschlüsseln (wenn application/jose) ← Server private key
        │
5. JWS-Signatur prüfen                        ← Client public key
        │
6. JWS Claims prüfen (iss, aud, iat, exp)
        │
7. Fachliche Verarbeitung
```

---

## Fehlercodes / Error Codes

| HTTP Status | Code | Beschreibung / Description |
|-------------|------|---------------------------|
| `401` | `SIGNATURE_MISSING` | Signature-Header fehlt / Signature header missing |
| `401` | `SIGNATURE_INVALID` | Signatur ungültig / Invalid signature |
| `401` | `TOKEN_EXPIRED` | Bearer Token abgelaufen / Bearer token expired |
| `400` | `DIGEST_MISMATCH` | Content-Digest stimmt nicht überein / Content-Digest mismatch |
| `400` | `JWE_DECRYPTION_FAILED` | JWE konnte nicht entschlüsselt werden / JWE decryption failed |
| `400` | `JWS_VERIFICATION_FAILED` | JWS-Signatur ungültig / JWS signature invalid |
| `400` | `CLAIMS_INVALID` | JWT Claims ungültig (exp, aud) / Invalid JWT claims |

---

## Normative Referenzen / Normative References

| RFC | Titel | Verwendung / Usage |
|-----|-------|-------------------|
| RFC 9421 | HTTP Message Signatures | Header-Signatur / Header signing |
| RFC 9530 | Digest Fields | `Content-Digest` Header |
| RFC 7515 | JSON Web Signature (JWS) | Payload-Signatur / Payload signing |
| RFC 7516 | JSON Web Encryption (JWE) | Payload-Verschlüsselung / Payload encryption |
| RFC 7517 | JSON Web Key (JWK) | Schlüsselformat / Key format |
| RFC 7519 | JSON Web Token (JWT) | Bearer Token + Claims |
| RFC 8941 | Structured Field Values for HTTP | Header-Syntax für Signature/Signature-Input |
| RFC 7540 | HTTP/2 | Transportprotokoll / Transport protocol |
