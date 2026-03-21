# EDI@Energy API Headers – Vollständige Dokumentation / Complete Documentation

**Version:** 1.0.0  
**Standard:** RFC 9110 · RFC 7240 · RFC 8694 · W3C Trace Context · OpenAPI 3.0.3  
**Referenz / Reference:** [edi-energy.de](https://www.edi-energy.de) · [www.bdew-mako.de](https://www.bdew-mako.de)

---

> **Hinweis zur Sprache / Language note**  
> Diese Dokumentation ist vollständig zweisprachig (Deutsch / Englisch).  
> Jeder Abschnitt enthält zunächst die englische, dann die deutsche Beschreibung.  
> This documentation is fully bilingual (German / English).  
> Each section contains the English description first, followed by the German description.

---

## Inhaltsverzeichnis / Table of Contents

1. [Überblick / Overview](#1-überblick--overview)
2. [Korrekturen gegenüber Vorlage / Corrections vs. Presentation](#2-korrekturen--corrections)
3. [Gruppe 1: Allgemeine Header / General Headers](#3-gruppe-1-allgemeine-header--general-headers)
   - [X-Request-ID](#x-request-id)
   - [X-Message-ID](#x-message-id)
   - [Idempotency-Key](#idempotency-key)
   - [traceparent](#traceparent)
   - [Prefer](#prefer)
   - [Preference-Applied](#preference-applied)
   - [Location](#location)
   - [Retry-After](#retry-after)
4. [Gruppe 2: State-Machine Header](#4-gruppe-2-state-machine-header)
   - [ETag](#etag)
   - [If-Match](#if-match)
5. [Gruppe 3: Version-Control Header](#5-gruppe-3-version-control-header)
   - [X-Server-Version](#x-server-version)
   - [X-API-Spec-Version](#x-api-spec-version)
   - [X-API-Spec-Ref](#x-api-spec-ref)
   - [X-API-Spec-ID](#x-api-spec-id)
   - [X-Client-Version](#x-client-version)
   - [X-Backend-Version](#x-backend-version)
6. [Verwendungsmuster / Usage Patterns](#6-verwendungsmuster--usage-patterns)
7. [OpenAPI 3.0 Einbindung / OpenAPI 3.0 Integration](#7-openapi-30-einbindung--openapi-30-integration)
8. [Normative Quellen / Normative References](#8-normative-quellen--normative-references)

---

## 1. Überblick / Overview

### English

HTTP headers are metadata fields transmitted alongside an HTTP request or response.
They control behavior, carry identification, enable tracing, and support versioning
without requiring changes to the URL structure or request body.

The EDI@Energy API uses three categories of headers:

| Category | Purpose |
|---|---|
| **General** | Request correlation, idempotency, distributed tracing, dry-run mode |
| **State-Machine** | Optimistic concurrency control for long-running transactions |
| **Version-Control** | Identifying server, client, API specification, and backend versions |

**Important RESTful rules:**
- Response-only headers (`Location`, `Retry-After`, `ETag`, `Preference-Applied`) must
  be defined under `responses[x].headers` in OpenAPI — **never** as `parameters[in: header]`.
- Custom headers (`X-*`) are application-specific extensions not defined by HTTP standards.
- Standard headers (defined in RFC 9110 and IANA registry) must use their canonical
  spelling exactly — they are case-insensitive at runtime but canonical names matter
  for documentation, code generation, and interoperability.

### Deutsch

HTTP-Header sind Metadaten-Felder, die zusammen mit einem HTTP-Request oder einer
HTTP-Response übertragen werden. Sie steuern das Verhalten, transportieren Identifikationen,
ermöglichen Tracing und unterstützen Versionierung — ohne Änderungen an der URL-Struktur
oder am Request-Body.

Die EDI@Energy API verwendet drei Header-Kategorien:

| Kategorie | Zweck |
|---|---|
| **Allgemein** | Request-Korrelation, Idempotenz, Distributed Tracing, Testbetrieb |
| **State-Machine** | Optimistische Nebenläufigkeitskontrolle bei Long-Running Transactions |
| **Version-Control** | Identifikation von Server, Client, API-Spezifikation und Backend |

**Wichtige RESTful-Regeln:**
- Reine Response-Header (`Location`, `Retry-After`, `ETag`, `Preference-Applied`) werden
  in OpenAPI unter `responses[x].headers` definiert — **niemals** als `parameters[in: header]`.
- Custom-Header (`X-*`) sind anwendungsspezifische Erweiterungen, die nicht durch den
  HTTP-Standard definiert sind.
- Standard-Header (aus RFC 9110 und IANA-Registry) müssen exakt in ihrer kanonischen
  Schreibweise verwendet werden — sie sind zur Laufzeit case-insensitive, aber für
  Dokumentation, Code-Generierung und Interoperabilität ist die korrekte Schreibweise wichtig.

---

## 2. Korrekturen / Corrections

### English

The following corrections were applied to the names proposed in the presentation:

| Presentation (wrong) | Corrected | Reason |
|---|---|---|
| `X-Request-Id` | **`X-Request-ID`** | Acronyms (ID, API) are written in uppercase by HTTP convention |
| `X-Message-Id` | **`X-Message-ID`** | Same rule |
| `Idempotency-ID` | **`Idempotency-Key`** | RFC 8694 / Stripe standard. The example in the presentation already showed the correct name. |
| `Etag:` | **`ETag`** | Canonical IANA spelling. No colon in the header name. |
| `X-Api-Spec-Version` | **`X-API-Spec-Version`** | Acronym API in uppercase |
| `X-Api-Spec-Ref` | **`X-API-Spec-Ref`** | Acronym API in uppercase |
| `X-Api-Spec-Id` | **`X-API-Spec-ID`** | Both acronyms API and ID in uppercase |

Additionally: `Location` and `Retry-After` are **response-only** headers (RFC 9110).
The presentation positioned them as general headers — they must be defined as response
headers in OpenAPI, not as request parameters.

### Deutsch

Folgende Korrekturen wurden gegenüber der Präsentation vorgenommen:

| Vorlage (falsch) | Korrigiert | Begründung |
|---|---|---|
| `X-Request-Id` | **`X-Request-ID`** | Akronyme (ID, API) werden per HTTP-Konvention großgeschrieben |
| `X-Message-Id` | **`X-Message-ID`** | Gleiche Regel |
| `Idempotency-ID` | **`Idempotency-Key`** | RFC 8694 / Stripe-Standard. Das Beispiel in der Präsentation zeigte bereits den korrekten Namen. |
| `Etag:` | **`ETag`** | Kanonische IANA-Schreibweise. Kein Doppelpunkt im Header-Namen. |
| `X-Api-Spec-Version` | **`X-API-Spec-Version`** | Akronym API großschreiben |
| `X-Api-Spec-Ref` | **`X-API-Spec-Ref`** | Akronym API großschreiben |
| `X-Api-Spec-Id` | **`X-API-Spec-ID`** | Akronyme API und ID großschreiben |

Zusätzlich: `Location` und `Retry-After` sind **ausschließlich Response-Header** (RFC 9110).
Die Präsentation ordnete sie allgemeinen Headern zu — in OpenAPI müssen sie als
Response-Header definiert werden, nicht als Request-Parameter.

---

## 3. Gruppe 1: Allgemeine Header / General Headers

---

### X-Request-ID

**Richtung / Direction:** Request → Response (Echo)  
**Pflicht / Required:** Nein / No  
**Standard:** HTTP Convention  
**Datei / File:** `headers/xRequestId.yaml`

#### English

**Purpose:**
`X-Request-ID` uniquely identifies a single HTTP request. Its lifetime is scoped
to exactly one request/response cycle. It can be generated by either the client
or the server.

**Use cases:**
- **Log correlation:** Every log line on client and server carries the same ID,
  making it trivial to filter all log entries for a specific request.
- **Debugging:** When a request fails, the support team can search by `X-Request-ID`
  across distributed log systems (ELK, Splunk, CloudWatch) to reconstruct the
  full request lifecycle.
- **Alternative to Idempotency-Key:** For non-mutating (GET) or non-critical operations
  where idempotent retry semantics are not required but request identification is
  still useful.

**Behavior:**
- If the client sends `X-Request-ID`, the server **SHOULD** echo it unchanged in
  the response. This closes the loop: the client can match the response to its request.
- If the client does not send it, the server MAY generate and return its own UUID.
- The value MUST be a UUID v4 (RFC 4122) — a 128-bit randomly generated identifier
  in the format `xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`.

**Relationship to other headers:**
- `X-Request-ID`: per-request scope
- `X-Message-ID`: per-process scope (multiple requests)
- `traceparent`: per-span scope (distributed tracing, W3C standard)

**HTTP exchange example:**
```http
→ Request
GET /marketLocations/51238696781 HTTP/1.1
X-Request-ID: 7c9b3a2e-3c8a-4f0e-9a16-2a4efc0d2b8a
traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01

← Response
HTTP/1.1 200 OK
X-Request-ID: 7c9b3a2e-3c8a-4f0e-9a16-2a4efc0d2b8a   ← server echoes it back
```

**Schema:**
```yaml
type: string
format: uuid
pattern: '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'
minLength: 36
maxLength: 36
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `UUIDv4` | `7c9b3a2e-3c8a-4f0e-9a16-2a4efc0d2b8a` | Standard UUID v4 |
| `AnotherUUID` | `a1b2c3d4-e5f6-7890-abcd-ef1234567890` | Second example UUID v4 |

#### Deutsch

**Zweck:**
`X-Request-ID` identifiziert eindeutig einen einzelnen HTTP-Request. Die Lebensdauer
ist auf genau einen Request-/Response-Zyklus begrenzt. Er kann vom Client oder vom
Server erzeugt werden.

**Anwendungsfälle:**
- **Log-Korrelation:** Jede Log-Zeile auf Client und Server trägt dieselbe ID,
  wodurch alle Log-Einträge zu einem bestimmten Request einfach gefiltert werden können.
- **Debugging:** Wenn ein Request fehlschlägt, kann das Support-Team über alle
  verteilten Log-Systeme (ELK, Splunk, CloudWatch) nach der `X-Request-ID` suchen und
  den vollständigen Request-Lebenszyklus rekonstruieren.
- **Alternative zu Idempotency-Key:** Für nicht-verändernde (GET) oder unkritische
  Operationen, bei denen keine idempotente Retry-Semantik erforderlich ist, eine
  Request-Identifikation aber dennoch nützlich ist.

**Verhalten:**
- Wenn der Client `X-Request-ID` sendet, **SOLLTE** der Server sie unverändert in der
  Response zurücksenden. Dies schließt den Kreis: Der Client kann die Response seinem
  Request zuordnen.
- Wenn der Client sie nicht sendet, KANN der Server eine eigene UUID generieren und
  zurückgeben.
- Der Wert MUSS eine UUID v4 (RFC 4122) sein — ein 128-Bit zufällig generierter
  Bezeichner im Format `xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`.

**Beziehung zu anderen Headern:**
- `X-Request-ID`: Request-Scope (ein Request)
- `X-Message-ID`: Prozess-Scope (mehrere Requests)
- `traceparent`: Span-Scope (Distributed Tracing, W3C-Standard)

---

### X-Message-ID

**Richtung / Direction:** Request + Response (Echo)  
**Pflicht / Required:** Nein / No  
**Standard:** EDI@Energy Convention  
**Datei / File:** `headers/xMessageId.yaml`

#### English

**Purpose:**
`X-Message-ID` is a process-level correlation identifier that spans the entire
lifecycle of a business process — from the initial API call through all subsequent
calls, callbacks, and confirmations. It corresponds to the TransactionID concept
in EDI@Energy's EDIFACT-based processes.

**Use cases:**
- **Process tracing:** A supplier change (Lieferantenwechsel) involves multiple API
  calls: submit → confirm → acknowledge. All calls share the same `X-Message-ID`,
  making it possible to reconstruct the entire process from logs.
- **Audit trail:** For regulatory and compliance purposes, every step of a business
  process can be linked via its `X-Message-ID`.
- **Cross-system correlation:** When a message passes through multiple systems (hub,
  backend, ERP), each system logs the `X-Message-ID`, creating a unified audit chain.

**Lifecycle:**
1. Client generates a UUID v4 at the start of a business process.
2. The UUID is sent in `X-Message-ID` on every request in that process.
3. The server echoes the same `X-Message-ID` in every response.
4. Intermediate systems (hubs, proxies) must propagate this header unchanged.
5. The ID remains stable until the business process is fully completed.

**Difference to X-Request-ID:**

| Header | Scope | Lifetime | Who creates |
|---|---|---|---|
| `X-Request-ID` | Single HTTP request | One request/response | Client or server |
| `X-Message-ID` | Entire business process | Multiple requests/days | Client (process initiator) |

**HTTP exchange example:**
```http
→ Step 1: Submit supplier change
POST /messages HTTP/1.1
X-Message-ID: 3e6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9a1
X-Request-ID: 7c9b3a2e-3c8a-4f0e-9a16-2a4efc0d2b8a

← Response 202 Accepted
X-Message-ID: 3e6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9a1  ← echoed

→ Step 2: Poll for result (same X-Message-ID, new X-Request-ID)
GET /messages/3e6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9a1/status HTTP/1.1
X-Message-ID: 3e6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9a1
X-Request-ID: b2c4e6f8-1234-5678-90ab-cdef12345678
```

**Schema:**
```yaml
type: string
format: uuid
pattern: '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'
minLength: 36
maxLength: 36
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `ProcessA` | `3e6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9a1` | Supplier change process A |
| `ProcessB` | `f47ac10b-58cc-4372-a567-0e02b2c3d479` | Grid location update process B |

#### Deutsch

**Zweck:**
`X-Message-ID` ist ein prozess-übergreifender Korrelationsbezeichner, der den gesamten
Lebenszyklus eines Geschäftsprozesses umspannt — vom initialen API-Aufruf über alle
folgenden Aufrufe, Callbacks und Bestätigungen. Er entspricht dem TransaktionsID-Konzept
in den EDIFACT-basierten EDI@Energy-Prozessen.

**Anwendungsfälle:**
- **Prozesskettenverfolgung:** Ein Lieferantenwechsel umfasst mehrere API-Aufrufe:
  Anmeldung → Bestätigung → Quittierung. Alle Aufrufe teilen dieselbe `X-Message-ID`,
  sodass der gesamte Prozess aus Logs rekonstruiert werden kann.
- **Audit-Trail:** Für regulatorische Zwecke kann jeder Schritt eines Geschäftsprozesses
  über seine `X-Message-ID` verknüpft werden.
- **Systemübergreifende Korrelation:** Wenn eine Nachricht mehrere Systeme durchläuft
  (Hub, Backend, ERP), protokolliert jedes System die `X-Message-ID` und schafft
  damit eine einheitliche Audit-Kette.

**Lebenszyklus:**
1. Client erzeugt eine UUID v4 zu Beginn eines Geschäftsprozesses.
2. Die UUID wird in `X-Message-ID` bei jedem Request dieses Prozesses gesendet.
3. Der Server gibt dieselbe `X-Message-ID` in jeder Response zurück.
4. Zwischensysteme (Hubs, Proxies) müssen diesen Header unverändert weiterleiten.
5. Die ID bleibt stabil, bis der Geschäftsprozess vollständig abgeschlossen ist.

**Unterschied zu X-Request-ID:**

| Header | Scope | Lebensdauer | Wer erzeugt |
|---|---|---|---|
| `X-Request-ID` | Einzelner HTTP-Request | Ein Request/Response | Client oder Server |
| `X-Message-ID` | Gesamter Geschäftsprozess | Mehrere Requests/Tage | Client (Prozess-Initiator) |

---

### Idempotency-Key

**Richtung / Direction:** Request  
**Pflicht / Required:** Empfohlen für POST/PATCH / Recommended for POST/PATCH  
**Standard:** RFC 8694, Stripe Idempotency Standard  
**Datei / File:** `headers/idempotencyKey.yaml`

#### English

**Purpose:**
`Idempotency-Key` enables safe retries of HTTP requests that create or modify data.
If a network failure occurs after the server processes a request but before the client
receives the response, the client can safely retry with the same key — the server
recognizes the duplicate and returns the original response without executing the
operation a second time.

**Critical rules:**
1. **Generated by the client only.** The server must never generate or modify this value.
2. **Stable across retries.** The key MUST be identical on every retry of the same operation.
3. **UUID v4 format.** Use a cryptographically random UUID to avoid key collisions.
4. **Scoped to one logical operation.** A new operation requires a new key.
5. **Server-side TTL.** Servers should cache the response for 24 hours (recommended).
   After TTL expiry, a matching key is treated as a new request.

**What makes a request idempotent?**
An operation is idempotent if executing it multiple times has the same effect as
executing it once. GET and DELETE are naturally idempotent. POST is not — without
`Idempotency-Key`, submitting a supplier change twice creates two separate transactions.
With `Idempotency-Key`, the server detects the duplicate and returns the first response.

**Server behavior:**
```
Request received → Key known? → YES → Return cached response (no re-execution)
                              → NO  → Process request → Cache response → Return response
```

**Difference to X-Request-ID:**
`X-Request-ID` is for request identification and logging only — it has no retry semantics.
`Idempotency-Key` actively prevents duplicate execution on the server side.

**Correction vs. presentation:**
The presentation listed this header as `Idempotency-ID` in the column header, but the
example column already showed the correct name `Idempotency-Key`. The correct name is
`Idempotency-Key` (RFC 8694).

**HTTP exchange example:**
```http
→ First attempt (network timeout before client receives response)
POST /messages HTTP/1.1
Idempotency-Key: 2f6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9c1
Content-Type: application/json
{ "type": "supplierChange", "maLoId": "51238696781" }

← (no response received — timeout)

→ Retry (same Idempotency-Key)
POST /messages HTTP/1.1
Idempotency-Key: 2f6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9c1
Content-Type: application/json
{ "type": "supplierChange", "maLoId": "51238696781" }

← Response 202 Accepted   ← same response as the first attempt
X-Message-ID: 3e6d3f3d-...
(No duplicate transaction created)
```

**Schema:**
```yaml
type: string
format: uuid
pattern: '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'
minLength: 36
maxLength: 36
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `RetryableOperation` | `2f6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9c1` | POST /messages – supplier change |
| `AnotherOperation` | `550e8400-e29b-41d4-a716-446655440000` | POST /marketLocations – new MaLo |

#### Deutsch

**Zweck:**
`Idempotency-Key` ermöglicht sichere Wiederholungen (Retries) von HTTP-Requests, die
Daten erstellen oder verändern. Wenn ein Netzwerkfehler auftritt, nachdem der Server
einen Request verarbeitet hat, der Client aber keine Response erhalten hat, kann der
Client den Request mit demselben Key sicher wiederholen — der Server erkennt das Duplikat
und gibt die ursprüngliche Response zurück, ohne die Operation nochmals auszuführen.

**Wichtige Regeln:**
1. **Nur vom Client erzeugt.** Der Server darf diesen Wert niemals erzeugen oder ändern.
2. **Stabil über Retries hinweg.** Der Key MUSS bei jedem Retry derselben Operation identisch sein.
3. **UUID v4 Format.** Eine kryptografisch zufällige UUID verwenden, um Key-Kollisionen zu vermeiden.
4. **Auf eine logische Operation begrenzt.** Eine neue Operation benötigt einen neuen Key.
5. **Server-seitiges TTL.** Server sollten die Response 24 Stunden zwischenspeichern (empfohlen).
   Nach TTL-Ablauf wird ein übereinstimmender Key als neuer Request behandelt.

**Korrektur gegenüber Vorlage:**
Die Präsentation führte diesen Header als `Idempotency-ID` im Spaltentitel, das Beispiel
zeigte aber bereits den korrekten Namen `Idempotency-Key`. Der korrekte Name ist
`Idempotency-Key` (RFC 8694).

---

### traceparent

**Richtung / Direction:** Request  
**Pflicht / Required:** Nein / No  
**Standard:** W3C Trace Context Level 2  
**Datei / File:** `headers/traceparent.yaml`

#### English

**Purpose:**
`traceparent` is the W3C-standardized header for distributed tracing. It carries
a globally unique trace identifier that follows a request end-to-end through all
systems — API gateway, hub, backend services, databases. Every system that receives
this header must propagate it unchanged to downstream systems.

**Why distributed tracing?**
In a microservices architecture, a single business operation may touch 5–15 different
services. When an error occurs, it is impossible to diagnose without knowing the full
call chain. `traceparent` solves this by providing a single key that correlates all
spans across all systems into one trace tree, visible in tools like Jaeger, Zipkin,
Datadog, or AWS X-Ray.

**Format breakdown:**
```
00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01
│   │                                 │                │
│   │                                 │                └─ traceFlags (2 hex)
│   │                                 │                   01 = sampled, 00 = not sampled
│   │                                 └─ parentId (16 hex = 64-bit)
│   │                                    ID of the calling span
│   └─ traceId (32 hex = 128-bit)
│      Globally unique trace identifier
└─ version (2 hex, always 00)
```

**Critical spelling rule:**
The W3C specification mandates **lowercase** for the header name: `traceparent`.
Never write `Traceparent` or `TraceParent` — some implementations are case-sensitive
in header matching.

**Propagation rule:**
Every intermediate system (API gateway, proxy, hub) MUST forward this header
unchanged. Creating a new `traceparent` breaks the trace chain and makes the
upstream call invisible in tracing tools.

**HTTP exchange example:**
```http
→ Client to API Gateway
POST /messages HTTP/1.1
traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01

→ API Gateway to Hub (same traceId, new parentId)
POST /internal/messages HTTP/1.1
traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-b9c4a3d2e1f05678-01
                          ^^^^^^^^^^^^^^^^^^^^^^^^ same traceId
                                                   ^^^^^^^^^^^^^^^^ new parentId
```

**Schema:**
```yaml
type: string
pattern: '^00-[0-9a-f]{32}-[0-9a-f]{16}-[0-9a-f]{2}$'
minLength: 55
maxLength: 55
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `Sampled` | `00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01` | Sampled trace (flags=01) |
| `NotSampled` | `00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-00` | Not sampled (flags=00) |

#### Deutsch

**Zweck:**
`traceparent` ist der W3C-standardisierte Header für Distributed Tracing. Er trägt
eine global eindeutige Trace-Kennung, die einem Request Ende-zu-Ende durch alle
Systeme folgt — API-Gateway, Hub, Backend-Services, Datenbanken. Jedes System, das
diesen Header empfängt, muss ihn unverändert an nachgelagerte Systeme weiterleiten.

**Format-Erklärung:**
```
00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01
│   │                                 │                │
│   │                                 │                └─ traceFlags (2 Hex)
│   │                                 │                   01 = gesampelt, 00 = nicht gesampelt
│   │                                 └─ parentId (16 Hex = 64 Bit)
│   │                                    ID des aufrufenden Spans
│   └─ traceId (32 Hex = 128 Bit)
│      Global eindeutige Trace-Kennung
└─ version (2 Hex, immer 00)
```

**Wichtige Schreibregel:**
Die W3C-Spezifikation schreibt **Lowercase** für den Header-Namen vor: `traceparent`.
Niemals `Traceparent` oder `TraceParent` schreiben — einige Implementierungen
sind beim Header-Matching case-sensitive.

---

### Prefer

**Richtung / Direction:** Request  
**Pflicht / Required:** Nein / No  
**Standard:** RFC 7240  
**Datei / File:** `headers/prefer.yaml`

#### English

**Purpose:**
`Prefer` allows the client to express processing preferences to the server.
The server is not obligated to honor them — it is advisory, not mandatory.
If the server honors a preference, it confirms this with `Preference-Applied`.

**IANA-registered tokens (RFC 7240):**

| Token | Meaning |
|---|---|
| `respond-async` | Client prefers asynchronous processing; server should return `202 Accepted` immediately |
| `return=minimal` | Client only needs a minimal response body (e.g., just the ID of a created resource) |
| `return=representation` | Client wants the full updated resource in the response body after PUT/POST |
| `handling=strict` | Reject the request if the server cannot honor all preferences |
| `handling=lenient` | Process the request even if some preferences cannot be honored |

**EDI@Energy extension token:**

| Token | Meaning |
|---|---|
| `dry-run` | Execute the full validation and processing logic, but do **not** persist any data. No side effects. Used for integration testing and pre-production validation. |

> `dry-run` is **not** an IANA-registered token. It is documented here as an
> EDI@Energy-specific extension. Servers that do not support `dry-run` should
> return `200 OK` or `202 Accepted` without the `Preference-Applied: dry-run` echo.

**Combining tokens:**
Multiple preferences can be combined: `Prefer: respond-async, return=minimal`

**HTTP exchange example — dry-run:**
```http
→ Request with dry-run preference
POST /messages HTTP/1.1
Prefer: dry-run
Idempotency-Key: 2f6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9c1
Content-Type: application/json
{ "type": "supplierChange", "maLoId": "51238696781" }

← Response: validation passed, no data written
HTTP/1.1 200 OK
Preference-Applied: dry-run
Content-Type: application/json
{ "validationStatus": "passed", "warnings": [] }
```

**HTTP exchange example — async:**
```http
→ Request preferring async processing
POST /messages HTTP/1.1
Prefer: respond-async
Idempotency-Key: 550e8400-e29b-41d4-a716-446655440000

← Server accepted, returns immediately without waiting for processing
HTTP/1.1 202 Accepted
Preference-Applied: respond-async
Location: /messages/3e6d3f3d/status
Retry-After: 30
ETag: "state:pending"
```

**Schema:**
```yaml
type: string
description: One or more preference tokens, comma-separated.
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `DryRun` | `dry-run` | Test run — no data persisted |
| `RespondAsync` | `respond-async` | Prefer async processing, 202 response |
| `ReturnMinimal` | `return=minimal` | Return only minimal response body |
| `AsyncMinimal` | `respond-async, return=minimal` | Async + minimal combined |

#### Deutsch

**Zweck:**
`Prefer` ermöglicht es dem Client, dem Server Verarbeitungspräferenzen mitzuteilen.
Der Server ist nicht verpflichtet, sie zu berücksichtigen — es ist empfehlend, nicht
zwingend. Berücksichtigt der Server eine Präferenz, bestätigt er dies mit `Preference-Applied`.

**IANA-registrierte Tokens (RFC 7240):**

| Token | Bedeutung |
|---|---|
| `respond-async` | Client bevorzugt asynchrone Verarbeitung; Server soll sofort `202 Accepted` zurücksenden |
| `return=minimal` | Client benötigt nur minimale Response (z.B. nur die ID der erstellten Ressource) |
| `return=representation` | Client möchte die vollständige aktualisierte Ressource im Response-Body nach PUT/POST |
| `handling=strict` | Request ablehnen, wenn Server nicht alle Präferenzen erfüllen kann |
| `handling=lenient` | Request verarbeiten, auch wenn einige Präferenzen nicht erfüllt werden können |

**EDI@Energy Extension-Token:**

| Token | Bedeutung |
|---|---|
| `dry-run` | Vollständige Validierungs- und Verarbeitungslogik ausführen, aber **keine** Daten persistieren. Keine Seiteneffekte. Für Integrationstests und Pre-Production-Validierung. |

> `dry-run` ist **kein** IANA-registrierter Token. Er ist hier als EDI@Energy-spezifische
> Erweiterung dokumentiert. Server, die `dry-run` nicht unterstützen, sollten
> `200 OK` oder `202 Accepted` zurücksenden, ohne `Preference-Applied: dry-run` zu echoen.

---

### Preference-Applied

**Richtung / Direction:** Response  
**Pflicht / Required:** Nein / No  
**Standard:** RFC 7240 §3  
**Datei / File:** `headers/preferenceApplied.yaml`

#### English

**Purpose:**
`Preference-Applied` is the server's confirmation that it honored one or more tokens
from the client's `Prefer` header. It lists only the tokens that were actually applied
— not the ones that were received but ignored.

**Rules:**
- The server MUST NOT include tokens it did not honor.
- The server SHOULD include this header whenever at least one `Prefer` token was applied.
- The value must exactly match the applied token(s) from the request.

**HTTP exchange example:**
```http
→ Request
POST /messages HTTP/1.1
Prefer: dry-run, return=minimal

← Server applied dry-run but not return=minimal
HTTP/1.1 200 OK
Preference-Applied: dry-run
```

**Schema:**
```yaml
type: string
description: Applied preference tokens (subset of Prefer request header).
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `DryRunApplied` | `dry-run` | Server confirmed dry-run mode |
| `AsyncApplied` | `respond-async` | Server processes asynchronously |
| `MinimalApplied` | `return=minimal` | Server returns minimal response |

#### Deutsch

**Zweck:**
`Preference-Applied` ist die Bestätigung des Servers, dass er einen oder mehrere
Tokens aus dem `Prefer`-Header des Clients berücksichtigt hat. Er listet nur die
tatsächlich angewandten Tokens — nicht die empfangenen, aber ignorierten.

**Regeln:**
- Der Server DARF NICHT Tokens aufführen, die er nicht berücksichtigt hat.
- Der Server SOLLTE diesen Header senden, wenn mindestens ein `Prefer`-Token angewendet wurde.
- Der Wert muss genau den angewendeten Token(s) aus dem Request entsprechen.

---

### Location

**Richtung / Direction:** Response only / Nur Response  
**Pflicht / Required:** Nein / No  
**Standard:** RFC 9110 §10.2.2  
**Datei / File:** `headers/location.yaml`

#### English

**Purpose:**
`Location` is a standard HTTP response header that provides the URI of:
1. A newly created resource (`201 Created`)
2. A status endpoint for polling an asynchronous operation (`202 Accepted`)
3. The target of a redirect (`301`, `302`, `307`, `308`)

**EDI@Energy context:**
When a client calls `/maloIdent/` and the server resolves this to a concrete resource
(e.g., by looking up the MaLo identifier), the canonical URI is returned in `Location`.
This decouples the client's logical address from the server's internal resource paths.

**⚠️ RESTful rule — Response header only:**
`Location` is **exclusively** a response header (RFC 9110 §10.2.2).
In OpenAPI 3.0 it must be defined under `responses[x].headers`, **never** under
`parameters[in: header]`.

**HTTP exchange example — 201 Created:**
```http
→ Request
POST /marketLocations HTTP/1.1
Content-Type: application/json
{ "address": { "street": "Reinhardtstraße 32", "city": "Berlin" } }

← Response
HTTP/1.1 201 Created
Location: /marketLocations/51238696781
```

**HTTP exchange example — 202 Accepted (async):**
```http
→ Request
POST /messages HTTP/1.1
Prefer: respond-async

← Response
HTTP/1.1 202 Accepted
Location: /jobs/a1b2c3d4-e5f6-7890-abcd-ef1234567890/status
Retry-After: 30
```

**Schema:**
```yaml
type: string
format: uri
description: Absolute or relative URI of the target resource.
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `CreatedResource` | `/malo/ident/45073` | URI of newly created MaLo |
| `AsyncStatus` | `/jobs/a1b2c3d4-e5f6-7890-abcd-ef1234567890/status` | Polling endpoint |
| `AbsoluteUri` | `https://api.example.com/malo/ident/45073` | Absolute URI variant |

#### Deutsch

**Zweck:**
`Location` ist ein Standard-HTTP-Response-Header, der die URI angibt von:
1. Einer neu erstellten Ressource (`201 Created`)
2. Einem Status-Endpunkt für das Polling einer asynchronen Operation (`202 Accepted`)
3. Dem Ziel einer Weiterleitung (`301`, `302`, `307`, `308`)

**EDI@Energy-Kontext:**
Wenn ein Client `/maloIdent/` aufruft und der Server dies auf eine konkrete Ressource
auflöst, wird die kanonische URI in `Location` zurückgegeben. Dies entkoppelt die
logische Adresse des Clients von den internen Ressourcenpfaden des Servers.

**⚠️ RESTful-Regel — Nur Response-Header:**
`Location` ist **ausschließlich** ein Response-Header (RFC 9110 §10.2.2).
In OpenAPI 3.0 wird er unter `responses[x].headers` definiert, **niemals** unter
`parameters[in: header]`.

---

### Retry-After

**Richtung / Direction:** Response only / Nur Response  
**Pflicht / Required:** Nein / No  
**Standard:** RFC 9110 §10.2.4  
**Datei / File:** `headers/retryAfter.yaml`

#### English

**Purpose:**
`Retry-After` tells the client the earliest time it should retry a request.
It prevents aggressive retry storms that could overload a recovering server.

**Used with:**

| HTTP Status | Context |
|---|---|
| `202 Accepted` | Estimated completion time for an async operation (client should poll after this time) |
| `429 Too Many Requests` | Rate limit reset time (client must not retry before this) |
| `503 Service Unavailable` | Expected service recovery time |

**Value formats:**
Both formats are valid per RFC 9110:
1. **HTTP-date:** `Tue, 24 Feb 2026 10:00:00 GMT` — absolute point in time
2. **Delay-seconds:** `120` — relative seconds from now

**⚠️ RESTful rule — Response header only:**
`Retry-After` is exclusively a response header. Define it under `responses[x].headers`.

**HTTP exchange example:**
```http
← Rate limit exceeded
HTTP/1.1 429 Too Many Requests
Retry-After: 60
Content-Type: application/json
{ "error": "rate_limit_exceeded", "limit": 100, "window": "1m" }

← Async operation accepted
HTTP/1.1 202 Accepted
Location: /jobs/abc123/status
Retry-After: Tue, 24 Feb 2026 10:00:00 GMT
```

**Schema:**
```yaml
type: string
description: HTTP-date or delay-seconds integer.
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `HttpDate` | `Tue, 24 Feb 2026 10:00:00 GMT` | Absolute retry timestamp |
| `DelaySeconds` | `120` | Wait 120 seconds before retry |
| `RateLimitReset` | `Fri, 01 Jan 2027 00:00:00 GMT` | Rate limit reset time |

#### Deutsch

**Zweck:**
`Retry-After` teilt dem Client den frühestmöglichen Zeitpunkt für einen Retry mit.
Er verhindert aggressive Retry-Stürme, die einen sich erholenden Server überlasten könnten.

**Wird verwendet bei:**

| HTTP-Status | Kontext |
|---|---|
| `202 Accepted` | Geschätzte Fertigstellungszeit einer async. Operation (Client soll danach pollen) |
| `429 Too Many Requests` | Rate-Limit-Reset-Zeitpunkt (Client darf vorher nicht erneut versuchen) |
| `503 Service Unavailable` | Erwartete Wiederherstellungszeit des Dienstes |

**Wertformate:**
Beide Formate sind laut RFC 9110 gültig:
1. **HTTP-date:** `Tue, 24 Feb 2026 10:00:00 GMT` — absoluter Zeitpunkt
2. **Delay-Sekunden:** `120` — relative Sekunden ab jetzt
## 4. Gruppe 2: State-Machine Header

The state-machine headers implement optimistic concurrency control for long-running
transactions. They ensure that state transitions only occur when the resource is in
the expected state — preventing race conditions when multiple clients interact with
the same transaction simultaneously.

Die State-Machine-Header implementieren optimistische Nebenläufigkeitskontrolle für
Long-Running Transactions. Sie stellen sicher, dass Zustandsübergänge nur dann erfolgen,
wenn sich die Ressource im erwarteten Zustand befindet — und verhindern so Race Conditions
bei gleichzeitigem Zugriff mehrerer Clients auf dieselbe Transaktion.

---

### ETag

**Richtung / Direction:** Response only / Nur Response  
**Pflicht / Required:** Nein / No  
**Standard:** RFC 9110 §8.8.3  
**Datei / File:** `headers/eTag.yaml`

#### English

**Purpose:**
`ETag` (Entity Tag) is a standard HTTP response header that identifies a specific
version or state of a resource. In the EDI@Energy state-machine context, the ETag
carries the **current processing state** of a long-running transaction rather than
a version hash.

**State-machine model:**
```
pending → running → completed
                 ↘ failed
                 ↘ cancelled
```

Each state transition returns a new `ETag` value. The client stores this value and
uses it in the next `If-Match` header to ensure the transition only proceeds if the
resource is still in the expected state.

**ETag value rules (RFC 9110):**
- Values MUST be enclosed in **double quotes**: `"state:running"` — not `state:running`
- Weak ETags are prefixed with `W/`: `W/"v2.4.1"` — semantically equivalent but not byte-identical
- The canonical IANA spelling is `ETag` — not `Etag`, not `etag`, not `ETAG`

**Correction vs. presentation:**
The presentation wrote `Etag:` (lowercase t, trailing colon). Both are wrong:
- Canonical spelling: `ETag` (capital T, no colon)
- Values with typographic quotes `„state:running"` are invalid — use ASCII double quotes `"`

**EDI@Energy state values:**

| ETag value | State | Description |
|---|---|---|
| `"state:pending"` | Pending | Transaction received, queued for processing |
| `"state:running"` | Running | Currently being processed |
| `"state:completed"` | Completed | Successfully processed |
| `"state:failed"` | Failed | Processing failed (see error details) |
| `"state:cancelled"` | Cancelled | Cancelled by client or timeout |

**HTTP exchange example:**
```http
← Initial response (202 Accepted)
HTTP/1.1 202 Accepted
ETag: "state:pending"
Location: /messages/abc123/status
Retry-After: 5

← Poll after 5 seconds
HTTP/1.1 200 OK
ETag: "state:running"

← Poll again later
HTTP/1.1 200 OK
ETag: "state:completed"
```

**Schema:**
```yaml
type: string
pattern: '^(W/)?"[^"]*"$'
description: |
  Entity tag in double quotes. EDI@Energy state values:
  "state:pending", "state:running", "state:completed", "state:failed", "state:cancelled"
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `StateRunning` | `"state:running"` | Transaction currently processing |
| `StatePending` | `"state:pending"` | Transaction queued |
| `StateCompleted` | `"state:completed"` | Transaction finished successfully |
| `StateFailed` | `"state:failed"` | Transaction failed |
| `WeakETag` | `W/"v2.4.1-abc123"` | Weak ETag for version-based concurrency |

#### Deutsch

**Zweck:**
`ETag` (Entity Tag) ist ein Standard-HTTP-Response-Header, der eine bestimmte Version
oder einen Zustand einer Ressource identifiziert. Im EDI@Energy-State-Machine-Kontext
trägt der ETag den **aktuellen Verarbeitungszustand** einer Long-Running Transaction
anstelle eines Versions-Hashes.

**State-Machine-Modell:**
```
pending → running → completed
                 ↘ failed
                 ↘ cancelled
```

Jeder Zustandsübergang gibt einen neuen `ETag`-Wert zurück. Der Client speichert
diesen Wert und verwendet ihn im nächsten `If-Match`-Header, um sicherzustellen,
dass der Übergang nur stattfindet, wenn sich die Ressource noch im erwarteten Zustand befindet.

**ETag-Wert-Regeln (RFC 9110):**
- Werte MÜSSEN in **doppelten Anführungszeichen** stehen: `"state:running"` — nicht `state:running`
- Schwache ETags haben das Präfix `W/`: `W/"v2.4.1"` — semantisch äquivalent, aber nicht Byte-identisch
- Die kanonische IANA-Schreibweise ist `ETag` — nicht `Etag`, nicht `etag`, nicht `ETAG`

**Korrektur gegenüber Vorlage:**
Die Präsentation schrieb `Etag:` (kleines t, abschließender Doppelpunkt). Beides ist falsch:
- Korrekte Schreibweise: `ETag` (großes T, kein Doppelpunkt)
- Werte mit typografischen Anführungszeichen `„state:running"` sind ungültig — ASCII-Doppelquotes `"` verwenden

---

### If-Match

**Richtung / Direction:** Request  
**Pflicht / Required:** Nein / No  
**Standard:** RFC 9110 §13.1.1  
**Datei / File:** `headers/ifMatch.yaml`

#### English

**Purpose:**
`If-Match` is a conditional request header. It instructs the server to execute
the operation **only if** the resource's current ETag matches the provided value.
If the ETags do not match, the server returns `412 Precondition Failed`.

**State-machine concurrency control:**
In a distributed system, two clients might try to transition the same transaction
simultaneously. Without `If-Match`:
- Client A reads state `running`, intends to cancel
- Client B reads state `running`, completes the transaction (→ `completed`)
- Client A sends cancel request — but the resource is now `completed`
- Without `If-Match`, the cancel might succeed incorrectly

With `If-Match`:
- Client A sends `If-Match: "state:running"` with the cancel request
- Server checks: current state is `completed`, not `running`
- Server returns `412 Precondition Failed` — race condition prevented

**Special value `*`:**
`If-Match: *` means "execute only if the resource exists at all."
Use with caution — it does not check the state, only existence.

**Full state-machine pattern:**
```
Step 1: Client polls state
GET /messages/abc123/status
← ETag: "state:running"

Step 2: Client sends state transition with If-Match
PATCH /messages/abc123/state
If-Match: "state:running"
{ "targetState": "cancelled" }

← 200 OK: transition succeeded
ETag: "state:cancelled"

OR

← 412 Precondition Failed: state changed between poll and transition
ETag: "state:completed"
(Client must re-read state and decide whether to retry)
```

**Schema:**
```yaml
type: string
pattern: '^(\*|(W/)?"[^"]*"(,\s*(W/)?"[^"]*")*)$'
description: One or more ETag values in double quotes, or `*`.
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `MatchRunning` | `"state:running"` | Proceed only if transaction is running |
| `MatchPending` | `"state:pending"` | Proceed only if transaction is pending |
| `MatchAny` | `*` | Proceed if resource exists (use with caution) |
| `MultipleStates` | `"state:running", "state:pending"` | Accept either state |

#### Deutsch

**Zweck:**
`If-Match` ist ein bedingter Request-Header. Er weist den Server an, die Operation
**nur dann** auszuführen, wenn der aktuelle ETag der Ressource mit dem angegebenen
Wert übereinstimmt. Stimmen die ETags nicht überein, gibt der Server `412 Precondition Failed` zurück.

**State-Machine-Nebenläufigkeitskontrolle:**
In einem verteilten System könnten zwei Clients gleichzeitig versuchen, dieselbe
Transaktion zu übergehen. Ohne `If-Match` könnte ein Stornierungsauftrag fälschlicherweise
auf eine bereits abgeschlossene Transaktion angewendet werden. Mit `If-Match: "state:running"`
schlägt die Stornierung fehl (`412`), wenn die Transaktion inzwischen `completed` ist.

**Vollständiges State-Machine-Pattern:** → Siehe English-Abschnitt oben.

---

## 5. Gruppe 3: Version-Control Header

Version-control headers provide transparency about which versions of which systems
are involved in processing a request. They enable automated compatibility testing,
precise debugging, and audit trails.

Version-Control-Header schaffen Transparenz darüber, welche Versionen welcher Systeme
an der Verarbeitung eines Requests beteiligt sind. Sie ermöglichen automatisiertes
Kompatibilitätstesten, präzises Debugging und Audit-Trails.

---

### X-Server-Version

**Richtung / Direction:** Response  
**Pflicht / Required:** Nein / No  
**Standard:** EDI@Energy Convention  
**Datei / File:** `headers/xServerVersion.yaml`

#### English

**Purpose:**
`X-Server-Version` identifies the version of the hub or server system that responded
to the request. This allows clients and support teams to:
- Identify which server version processed a specific request during debugging
- Detect mismatches between client expectations and server capabilities
- Automate compatibility verification in integration test pipelines
- Correlate behavioral changes after a server upgrade

**Format:** Semantic versioning (SemVer): `MAJOR.MINOR.PATCH`
Optional pre-release suffix: `MAJOR.MINOR.PATCH-{suffix}`

**HTTP exchange example:**
```http
← Response
HTTP/1.1 200 OK
X-Server-Version: 2.4.21
X-API-Spec-Version: 1.7.1
X-Backend-Version: SAP_prod_19.2.7
```

**Schema:**
```yaml
type: string
pattern: '^\d+\.\d+(\.\d+)?(-[a-zA-Z0-9.]+)?$'
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `StableRelease` | `2.4.21` | Production stable release |
| `MinorVersion` | `2.4` | Without patch number |
| `PreRelease` | `3.0.0-rc1` | Release candidate |

#### Deutsch

**Zweck:**
`X-Server-Version` identifiziert die Version des Hubs oder Serversystems, das auf
den Request geantwortet hat. Dies ermöglicht Clients und Support-Teams:
- Zu identifizieren, welche Server-Version einen bestimmten Request bei der
  Fehlersuche verarbeitet hat
- Inkompatibilitäten zwischen Client-Erwartungen und Server-Fähigkeiten zu erkennen
- Automatisierte Kompatibilitätsprüfungen in Integrationstests-Pipelines
- Verhaltensänderungen nach einem Server-Update zu korrelieren

**Format:** Semantic Versioning (SemVer): `MAJOR.MINOR.PATCH`

---

### X-API-Spec-Version

**Richtung / Direction:** Response  
**Pflicht / Required:** Nein / No  
**Standard:** EDI@Energy Convention  
**Datei / File:** `headers/xApiSpecVersion.yaml`

#### English

**Purpose:**
`X-API-Spec-Version` communicates which version of the OpenAPI specification the
server is currently implementing. This replaces the traditional approach of embedding
the version number in the URI path (e.g., `/v1/`, `/v2/`).

**Why avoid version in the URI?**
URI versioning (`/v1/marketLocations`) creates several problems:
- All existing links and bookmarks break when upgrading from v1 to v2
- Documentation references need mass updates on every release
- Clients must hard-code version numbers, requiring client updates for every API upgrade

With `X-API-Spec-Version`, the base URL remains stable (`/marketLocations`)
and the version is communicated via header. Clients that need a specific version
can request it via an `Accept` header negotiation pattern.

**Format:** Semantic versioning or date-based release tags matching the GitHub release tag.

**HTTP exchange example:**
```http
← Response
HTTP/1.1 200 OK
X-API-Spec-Version: 1.7.1
X-API-Spec-Ref: git:EDI-Energy/api-electricity@v1.7.1
X-API-Spec-ID: release-2026-q1
```

**Schema:**
```yaml
type: string
pattern: '^\d+\.\d+(\.\d+)?(-[a-zA-Z0-9._-]+)?$'
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `StableVersion` | `1.7.1` | Stable API spec version |
| `ConsultationRelease` | `2026.02.02` | Date-based consultation release |
| `RcVersion` | `2.0.0-rc1` | Release candidate |

#### Deutsch

**Zweck:**
`X-API-Spec-Version` kommuniziert, welche Version der OpenAPI-Spezifikation der
Server aktuell implementiert. Dies ersetzt den klassischen Ansatz, die Versionsnummer
in den URI-Pfad einzubetten (z.B. `/v1/`, `/v2/`).

**Warum Version nicht in der URI?**
URI-Versionierung (`/v1/marktlokationen`) erzeugt mehrere Probleme:
- Alle bestehenden Links und Lesezeichen werden beim Wechsel von v1 auf v2 ungültig
- Dokumentationsreferenzen müssen bei jedem Release massenhaft aktualisiert werden
- Clients müssen Versionsnummern hartkodieren und bei jedem API-Upgrade aktualisiert werden

Mit `X-API-Spec-Version` bleibt die Basis-URL stabil (`/marketLocations`) und die
Version wird über den Header kommuniziert.

---

### X-API-Spec-Ref

**Richtung / Direction:** Response  
**Pflicht / Required:** Nein / No  
**Standard:** EDI@Energy Convention  
**Datei / File:** `headers/xApiSpecRef.yaml`

#### English

**Purpose:**
`X-API-Spec-Ref` provides a direct, machine-readable reference to the exact API
specification file in the EDI@Energy GitHub repository. This allows:
- Automated tools to fetch the exact specification used by the responding server
- Developers to instantly navigate to the specification in their browser
- CI/CD pipelines to verify that the deployed server matches a specific spec version

**Format:** `git:{owner}/{repo}@{ref}`
- `{owner}`: GitHub organization (e.g., `EDI-Energy`)
- `{repo}`: Repository name (e.g., `api-electricity`)
- `@{ref}`: Optional — tag, branch, or commit hash. Omit for main/default branch.

**HTTP exchange example:**
```http
← Specific consultation release
X-API-Spec-Ref: git:EDI-Energy/api-electricity@2026-02-02-consultation

← Main/default branch
X-API-Spec-Ref: git:EDI-Energy/api-electricity

← Tagged stable release
X-API-Spec-Ref: git:EDI-Energy/api-electricity@v1.7.1
```

**Schema:**
```yaml
type: string
pattern: '^git:[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+(@[A-Za-z0-9_./-]+)?$'
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `ConsultationBranch` | `git:EDI-Energy/api-electricity@2026-02-02-consultation` | Consultation release branch |
| `MainBranch` | `git:EDI-Energy/api-electricity` | Main/default branch |
| `TaggedRelease` | `git:EDI-Energy/api-electricity@v1.7.1` | Tagged stable release |

#### Deutsch

**Zweck:**
`X-API-Spec-Ref` bietet eine direkte, maschinenlesbare Referenz auf die exakte
API-Spezifikationsdatei im EDI@Energy-GitHub-Repository. Dies ermöglicht:
- Automatisierten Tools, die exakte Spezifikation des antwortenden Servers abzurufen
- Entwicklern, sofort zur Spezifikation im Browser zu navigieren
- CI/CD-Pipelines, zu verifizieren, dass der bereitgestellte Server einer bestimmten Spec-Version entspricht

**Format:** `git:{owner}/{repo}@{ref}`

---

### X-API-Spec-ID

**Richtung / Direction:** Response  
**Pflicht / Required:** Nein / No  
**Standard:** EDI@Energy Convention  
**Datei / File:** `headers/xApiSpecId.yaml`

#### English

**Purpose:**
`X-API-Spec-ID` is a short, human-readable identifier for the active API specification
variant. While `X-API-Spec-Ref` provides the full git reference and `X-API-Spec-Version`
provides the semantic version, `X-API-Spec-ID` provides the branch or release name
used in EDI@Energy's release management process.

**Typical values:**
- `main` — Current main branch (latest stable)
- `2026-02-02-consultation` — Public consultation release from February 2026
- `release-2026-q1` — Q1 2026 production release

**HTTP exchange example:**
```http
← All three version headers together
X-API-Spec-Version: 1.7.1
X-API-Spec-Ref: git:EDI-Energy/api-electricity@2026-02-02-consultation
X-API-Spec-ID: 2026-02-02-consultation
```

**Schema:**
```yaml
type: string
maxLength: 100
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `ConsultationId` | `2026-02-02-consultation` | Consultation release identifier |
| `MainBranch` | `main` | Main branch |
| `ReleaseTag` | `release-2026-q1` | Q1 2026 production release |

#### Deutsch

**Zweck:**
`X-API-Spec-ID` ist ein kurzer, menschenlesbarer Bezeichner für die aktive API-Spezifikationsvariante.
Während `X-API-Spec-Ref` die vollständige Git-Referenz und `X-API-Spec-Version` die
semantische Version liefert, gibt `X-API-Spec-ID` den Branch- oder Release-Namen aus
dem Release-Management-Prozess der EDI@Energy an.

---

### X-Client-Version

**Richtung / Direction:** Request  
**Pflicht / Required:** Nein / No  
**Standard:** EDI@Energy Convention  
**Datei / File:** `headers/xClientVersion.yaml`

#### English

**Purpose:**
`X-Client-Version` identifies the calling client system, its deployment environment,
and its software version. This enables servers and support teams to:
- Identify which client system caused a specific error
- Restrict access to clients using outdated or incompatible versions
- Track adoption of new client versions after an upgrade
- Correlate incidents with specific client deployments

**Format:** `{system}_{environment}_{version}`

| Segment | Values | Example |
|---|---|---|
| `system` | Identifier of the client software | `nginx`, `sap`, `java-sdk`, `python-client` |
| `environment` | Deployment stage | `test`, `prod`, `staging`, `dev` |
| `version` | SemVer or system-specific version | `3.12`, `2.1.0`, `19.2.7` |

**HTTP exchange example:**
```http
→ Request from nginx client in test environment
POST /messages HTTP/1.1
X-Client-Version: nginx_test_3.12
X-Request-ID: 7c9b3a2e-3c8a-4f0e-9a16-2a4efc0d2b8a
traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01
```

**Schema:**
```yaml
type: string
pattern: '^[a-zA-Z0-9._-]+_[a-zA-Z0-9._-]+_[a-zA-Z0-9._-]+$'
maxLength: 100
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `NginxTest` | `nginx_test_3.12` | nginx in test environment, version 3.12 |
| `JavaSdkProd` | `java-sdk_prod_2.1.0` | Java SDK in production, version 2.1.0 |
| `SapTest` | `sap_test_19.2.7` | SAP integration in test, version 19.2.7 |

#### Deutsch

**Zweck:**
`X-Client-Version` identifiziert das aufrufende Client-System, seine Bereitstellungsumgebung
und seine Softwareversion. Dies ermöglicht Servern und Support-Teams:
- Zu identifizieren, welches Client-System einen bestimmten Fehler verursacht hat
- Den Zugriff auf Clients mit veralteten oder inkompatiblen Versionen einzuschränken
- Die Einführung neuer Client-Versionen nach einem Upgrade zu verfolgen
- Vorfälle mit bestimmten Client-Bereitstellungen zu korrelieren

**Format:** `{system}_{environment}_{version}`

| Segment | Werte | Beispiel |
|---|---|---|
| `system` | Bezeichner der Client-Software | `nginx`, `sap`, `java-sdk`, `python-client` |
| `environment` | Bereitstellungsstufe | `test`, `prod`, `staging`, `dev` |
| `version` | SemVer oder systemspezifische Version | `3.12`, `2.1.0`, `19.2.7` |

---

### X-Backend-Version

**Richtung / Direction:** Response  
**Pflicht / Required:** Nein / No  
**Standard:** EDI@Energy Convention  
**Datei / File:** `headers/xBackendVersion.yaml`

#### English

**Purpose:**
`X-Backend-Version` identifies the backend system that actually processed the business
logic of the request (as opposed to `X-Server-Version` which identifies the API gateway
or hub). This distinction matters in layered architectures:

```
Client → API Gateway (X-Server-Version) → Hub → Backend ERP (X-Backend-Version)
```

**Use cases:**
- **Incident analysis:** When a bug is reported, immediately know which backend version
  was involved — no guessing across environments.
- **Compatibility gating:** Refuse requests from incompatible client versions at the
  backend level.
- **Deployment verification:** Confirm after a rolling deployment that the new backend
  version is serving traffic.
- **Multi-vendor environments:** When multiple backend systems are deployed, identify
  which specific instance handled the request.

**Format:** `{system}_{environment}_{version}`

**HTTP exchange example:**
```http
← Full version response headers
HTTP/1.1 200 OK
X-Server-Version: 2.4.21
X-API-Spec-Version: 1.7.1
X-API-Spec-Ref: git:EDI-Energy/api-electricity@v1.7.1
X-API-Spec-ID: release-2026-q1
X-Backend-Version: SAP_prod_19.2.7
```

**Schema:**
```yaml
type: string
pattern: '^[a-zA-Z0-9._-]+_[a-zA-Z0-9._-]+_[a-zA-Z0-9._-]+$'
maxLength: 100
```

**Examples:**

| Example key | Value | Description |
|---|---|---|
| `SapProd` | `SAP_prod_19.2.7` | SAP backend in production, version 19.2.7 |
| `OracleTest` | `oracle_test_12.2.1` | Oracle backend in test, version 12.2.1 |
| `CustomServiceProd` | `malo-service_prod_1.4.0` | Custom MaLo microservice in production |

#### Deutsch

**Zweck:**
`X-Backend-Version` identifiziert das Backend-System, das die eigentliche Geschäftslogik
des Requests verarbeitet hat (im Gegensatz zu `X-Server-Version`, das das API-Gateway
oder den Hub identifiziert). Diese Unterscheidung ist wichtig in Schichtarchitekturen.

**Anwendungsfälle:**
- **Vorfallsanalyse:** Bei einem gemeldeten Fehler sofort wissen, welche Backend-Version
  beteiligt war — kein Rätselraten zwischen Umgebungen.
- **Kompatibilitätssteuerung:** Anfragen von inkompatiblen Client-Versionen auf Backend-Ebene ablehnen.
- **Deployment-Verifizierung:** Nach einem Rolling-Deployment bestätigen, dass die neue
  Backend-Version Traffic verarbeitet.

---

## 6. Verwendungsmuster / Usage Patterns

### Pattern 1: Synchroner Request mit Idempotenz / Synchronous Request with Idempotency

#### English

Use this pattern for `POST`/`PATCH` operations that create or modify data and must
be safely retryable.

#### Deutsch

Dieses Pattern für `POST`/`PATCH`-Operationen, die Daten erstellen oder verändern
und sicher wiederholt werden können müssen.

```http
→ Request
POST /marketLocations HTTP/1.1
X-Request-ID: 7c9b3a2e-3c8a-4f0e-9a16-2a4efc0d2b8a
X-Message-ID: 3e6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9a1
Idempotency-Key: 2f6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9c1
traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01
X-Client-Version: java-sdk_prod_2.1.0
Content-Type: application/json

{ "maLoId": "51238696781", "address": { ... } }

← Response
HTTP/1.1 201 Created
X-Request-ID: 7c9b3a2e-3c8a-4f0e-9a16-2a4efc0d2b8a
X-Message-ID: 3e6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9a1
Location: /marketLocations/51238696781
X-Server-Version: 2.4.21
X-API-Spec-Version: 1.7.1
X-Backend-Version: SAP_prod_19.2.7
```

---

### Pattern 2: Asynchroner Request mit Polling / Asynchronous Request with Polling

#### English

Use this pattern for long-running operations. The server returns `202 Accepted`
immediately and the client polls the `Location` endpoint.

#### Deutsch

Dieses Pattern für Long-Running Operations. Der Server gibt sofort `202 Accepted`
zurück und der Client pollt den `Location`-Endpunkt.

```http
→ Request (Prefer: respond-async for explicit async preference)
POST /messages HTTP/1.1
X-Request-ID: 7c9b3a2e-3c8a-4f0e-9a16-2a4efc0d2b8a
X-Message-ID: 3e6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9a1
Idempotency-Key: 2f6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9c1
Prefer: respond-async
traceparent: 00-4bf92f3577b34da6a3ce929d0e0e4736-00f067aa0ba902b7-01

← Immediate response
HTTP/1.1 202 Accepted
X-Message-ID: 3e6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9a1
Preference-Applied: respond-async
Location: /messages/3e6d3f3d/status
Retry-After: 30
ETag: "state:pending"

→ Poll after 30 seconds
GET /messages/3e6d3f3d/status HTTP/1.1
X-Request-ID: b2c4e6f8-1234-5678-90ab-cdef12345678
X-Message-ID: 3e6d3f3d-2c3d-4b45-9f2b-3b2bb7f2b9a1

← Still running
HTTP/1.1 200 OK
ETag: "state:running"
Retry-After: 15

→ Poll again
← Completed
HTTP/1.1 200 OK
ETag: "state:completed"
```

---

### Pattern 3: Testlauf (dry-run) / Test Run (dry-run)

#### English

Use this pattern to validate a request without persisting any data.
Ideal for pre-production integration testing.

#### Deutsch

Dieses Pattern zur Validierung eines Requests ohne Datenpersistenz.
Ideal für Pre-Production-Integrationstests.

```http
→ Request mit dry-run
POST /messages HTTP/1.1
Prefer: dry-run
Idempotency-Key: 550e8400-e29b-41d4-a716-446655440000
X-Client-Version: sap_test_19.2.7
Content-Type: application/json

{ "type": "supplierChange", "maLoId": "51238696781" }

← Validation passed, no data written
HTTP/1.1 200 OK
Preference-Applied: dry-run
Content-Type: application/json

{
  "validationStatus": "passed",
  "warnings": [],
  "estimatedProcessingTime": "PT30S"
}
```

---

### Pattern 4: State-Machine Transition

#### English

Use this pattern for controlled state transitions on long-running transactions.
`If-Match` prevents race conditions.

#### Deutsch

Dieses Pattern für gesteuerte Zustandsübergänge bei Long-Running Transactions.
`If-Match` verhindert Race Conditions.

```http
→ Step 1: Read current state
GET /messages/abc123/status HTTP/1.1
X-Request-ID: 11111111-1111-1111-1111-111111111111

← Current state
HTTP/1.1 200 OK
ETag: "state:running"

→ Step 2: Cancel — only if still running
PATCH /messages/abc123/state HTTP/1.1
X-Request-ID: 22222222-2222-2222-2222-222222222222
If-Match: "state:running"
Content-Type: application/json

{ "targetState": "cancelled" }

← Success: transition applied
HTTP/1.1 200 OK
ETag: "state:cancelled"

← OR: state changed between read and write
HTTP/1.1 412 Precondition Failed
ETag: "state:completed"
Content-Type: application/json
{ "error": "precondition_failed",
  "message": "Resource state changed. Current state: completed." }
```

---

## 7. OpenAPI 3.0 Einbindung / OpenAPI 3.0 Integration

### English — How to reference headers in an API spec

**Request headers** are referenced as `parameters` with `in: header`:

```yaml
# In an endpoint definition:
parameters:
  - $ref: "./headers/openapi.yaml#/components/parameters/xRequestId"
  - $ref: "./headers/openapi.yaml#/components/parameters/xMessageId"
  - $ref: "./headers/openapi.yaml#/components/parameters/idempotencyKey"
  - $ref: "./headers/openapi.yaml#/components/parameters/traceparent"
  - $ref: "./headers/openapi.yaml#/components/parameters/prefer"
  - $ref: "./headers/openapi.yaml#/components/parameters/xClientVersion"
  - $ref: "./headers/openapi.yaml#/components/parameters/ifMatch"
```

**Response headers** are referenced under `responses[x].headers`:

```yaml
responses:
  '201':
    description: Resource created
    headers:
      Location:
        $ref: "./headers/openapi.yaml#/components/headers/location"
      X-Message-ID:
        $ref: "./headers/openapi.yaml#/components/headers/xMessageId"
      X-Server-Version:
        $ref: "./headers/openapi.yaml#/components/headers/xServerVersion"
      X-API-Spec-Version:
        $ref: "./headers/openapi.yaml#/components/headers/xApiSpecVersion"
      X-API-Spec-Ref:
        $ref: "./headers/openapi.yaml#/components/headers/xApiSpecRef"
      X-API-Spec-ID:
        $ref: "./headers/openapi.yaml#/components/headers/xApiSpecId"
      X-Backend-Version:
        $ref: "./headers/openapi.yaml#/components/headers/xBackendVersion"
  '202':
    description: Accepted (async)
    headers:
      Location:
        $ref: "./headers/openapi.yaml#/components/headers/location"
      Retry-After:
        $ref: "./headers/openapi.yaml#/components/headers/retryAfter"
      Preference-Applied:
        $ref: "./headers/openapi.yaml#/components/headers/preferenceApplied"
      ETag:
        $ref: "./headers/openapi.yaml#/components/headers/eTag"
  '412':
    description: Precondition Failed (state mismatch)
    headers:
      ETag:
        $ref: "./headers/openapi.yaml#/components/headers/eTag"
```

### Deutsch — Einbindung in eine API-Spezifikation

**Request-Header** werden als `parameters` mit `in: header` referenziert.
**Response-Header** werden unter `responses[x].headers` referenziert.
Beide Beispiele → Siehe English-Abschnitt oben.

---

## 8. Normative Quellen / Normative References

| Standard | Anwendung / Application |
|---|---|
| **RFC 9110** – HTTP Semantics | `Location` (§10.2.2), `Retry-After` (§10.2.4), `ETag` (§8.8.3), `If-Match` (§13.1.1) |
| **RFC 7240** – Prefer Header | `Prefer`, `Preference-Applied` |
| **RFC 8694** – Idempotency-Key | `Idempotency-Key` |
| **RFC 4122** – UUID | Format für alle UUID-basierten Header |
| **W3C Trace Context Level 2** | `traceparent` (https://www.w3.org/TR/trace-context/) |
| **IANA Header Field Registry** | Kanonische Schreibweisen aller Standard-Header |
| **EDI@Energy Konvention** | `X-*` Custom-Header (X-Request-ID, X-Message-ID etc.) |
| **Stripe Idempotency Standard** | Idempotency-Key Retry-Semantik |
| **OpenAPI Specification 3.0.3** | Schema-Struktur für Header-Definitionen |
