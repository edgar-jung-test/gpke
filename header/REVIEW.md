# API Header Review – EDI@Energy HTTP API Headers

**Basis:** Präsentation „API Header – Erweiterung der EDI@Energy HTTP API Header"  
**Prüfung:** RESTful Best Practices · HTTP RFC-Konformität · OpenAPI 3.0 Kompatibilität

---

## Bewertungsübersicht

| Header (vorgeschlagen) | Korrektur / Empfehlung | RFC/Standard | Bewertung |
|---|---|---|---|
| `X-Request-Id` | ✅ korrekt; alternativ: **`X-Request-ID`** (ID groß, RFC-üblich) | Konvention | ✅ OK |
| `X-Message-Id` | → **`X-Message-ID`** (ID groß) | Konvention | ⚠️ Kleinschreibung |
| `Idempotency-ID` | → **`Idempotency-Key`** (IANA-registriert, RFC 8694) | RFC 8694 | ❌ Falscher Name |
| `traceparent` | ✅ korrekt (W3C Trace Context, alles lowercase) | W3C TR 2021 | ✅ OK |
| `Location` | ✅ Standard-HTTP-Header; nur in Response zulässig | RFC 9110 | ⚠️ Nur Response |
| `Prefer` | ✅ IANA-registriert; Wert `respond-async` für async besser als `dry-run` | RFC 7240 | ⚠️ Wert prüfen |
| `Preference-Applied` | ✅ korrekt (Response-Pendant zu `Prefer`) | RFC 7240 | ✅ OK |
| `Retry-After` | ✅ Standard-HTTP-Header; nur in Response (429/503) | RFC 9110 | ⚠️ Nur Response |
| `ETag` | → **`ETag`** (nicht `Etag:` – Doppelpunkt gehört nicht zum Namen) | RFC 9110 | ⚠️ Schreibweise |
| `If-Match` | ✅ korrekt; Standard-HTTP-Conditional-Header | RFC 9110 | ✅ OK |
| `X-Server-Version` | ✅ akzeptabel; Konvention | Konvention | ✅ OK |
| `X-Api-Spec-Version` | → **`X-API-Spec-Version`** (API-Akronym groß) | Konvention | ⚠️ Kleinschreibung |
| `X-Api-Spec-Ref` | → **`X-API-Spec-Ref`** | Konvention | ⚠️ Kleinschreibung |
| `X-Api-Spec-Id` | → **`X-API-Spec-ID`** | Konvention | ⚠️ Kleinschreibung |
| `X-Client-Version` | ✅ akzeptabel; Konvention | Konvention | ✅ OK |
| `X-Backend-Version` | ✅ akzeptabel; Konvention | Konvention | ✅ OK |

---

## Detailbewertung

### `Idempotency-ID` → `Idempotency-Key`
Das Beispiel in der Präsentation zeigt bereits den korrekten Namen `Idempotency-Key`
(Stripe-Standard, seit RFC 8694 quasi-normiert). Der Spalten-Header `Idempotency-ID`
ist ein Fehler in der Präsentation. **Verbindlich: `Idempotency-Key`**.

### `ETag` – Schreibweise
HTTP-Header-Namen sind case-insensitive (RFC 9110 §5.1), aber `ETag` ist die
kanonische Schreibweise laut IANA-Registry. In OpenAPI-Schemas immer `ETag` schreiben
(nicht `Etag`, nicht `etag`).

### `Location` und `Retry-After` – nur Response-Header
Beide sind reine **Response-Header** (RFC 9110). Sie dürfen nicht als Request-Header
definiert werden. In OpenAPI werden sie unter `responses[x].headers` eingetragen,
nicht unter `parameters[in: header]`.

### `Prefer` – Wert `dry-run`
`dry-run` ist ein verbreiteter, aber kein offiziell registrierter `Prefer`-Token.
Für asynchrone Verarbeitung ist `respond-async` (RFC 7240 §4.1) standardisiert.
Für Testläufe ist `dry-run` als Custom-Extension-Token zulässig, sollte aber
dokumentiert werden. **Empfehlung:** Beide Werte explizit im Schema beschreiben.

### `X-Api-*` Schreibweise
HTTP-Header-Namen sind per RFC case-insensitive, aber Großschreibung von Akronymen
(`API`, `ID`) ist die verbreitete Konvention bei custom `X-`-Headern
(vgl. `X-Request-ID`, `X-Forwarded-For`). **Empfehlung:** `X-API-*` und `*-ID`.

### `traceparent`
Korrekt in **lowercase** – W3C Trace Context Spec schreibt lowercase vor.
Format: `{version}-{traceId}-{parentId}-{traceFlags}` mit festen Längen.

---

## Korrigierte Header-Namen (finale Liste)

### Gruppe 1: Allgemein (Request)
| Finaler Name | Richtung |
|---|---|
| `X-Request-ID` | Request |
| `X-Message-ID` | Request + Response |
| `Idempotency-Key` | Request |
| `traceparent` | Request |
| `Prefer` | Request |

### Gruppe 1: Allgemein (Response)
| Finaler Name | Richtung |
|---|---|
| `Location` | Response |
| `Preference-Applied` | Response |
| `Retry-After` | Response |

### Gruppe 2: State-Machine
| Finaler Name | Richtung |
|---|---|
| `ETag` | Response |
| `If-Match` | Request |

### Gruppe 3: Version-Control
| Finaler Name | Richtung |
|---|---|
| `X-Server-Version` | Response |
| `X-API-Spec-Version` | Response |
| `X-API-Spec-Ref` | Response |
| `X-API-Spec-ID` | Response |
| `X-Client-Version` | Request |
| `X-Backend-Version` | Response |
