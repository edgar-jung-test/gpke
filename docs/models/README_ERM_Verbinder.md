# BDEW Rollenmodell ERM v2.2 – Verbinder & Beziehungstypen

**Symbole · Bedeutung · Kardinalitäten · 52 Verbindungen im Überblick**

---

## 1. ERM-Notationssymbole (Crow's Foot)

Bedeutung der Endmarker auf Verbindungslinien im Entity-Relationship-Diagramm.

| Symbol | Bezeichnung | Bedeutung | Beispiel |
|--------|-------------|-----------|---------|
| `‖` | **ERmandOne** – Pflicht-Eins | Genau 1 – Die Beziehung ist zwingend erforderlich. Auf dieser Seite steht immer genau ein Datensatz. | Bilanzkreis muss zu genau 1 Regelzone gehören. |
| `○\|` | **ERzeroToOne** – Optional-Eins | 0 oder 1 – Die Beziehung ist optional. Es kann kein oder genau ein verknüpfter Datensatz existieren. | Messlokation kann optional zu 0 oder 1 Netzkopplungspunkt gehören. |
| `‖<` | **ERmany** – Pflicht-Viele | 1 oder viele – Crow's Foot: Mindestens ein Datensatz auf dieser Seite muss vorhanden sein. | Eine Regelzone hat mindestens 1 Bilanzkreis (kann viele haben). |
| `○<` | **ERzeroToMany** – Optional-Viele | 0 oder viele – Optional-Crow's Foot: Es können kein, ein oder viele Datensätze verknüpft sein. | Eine Adresse kann 0 oder viele Marktteilnehmer haben. |

---

## 2. Die 5 Verbindertypen im BDEW ERM

Kombinationen der Crow's-Foot-Notation mit Häufigkeit und Kardinalitätsregel.

| Verbindertyp | Kardinalität | Lesart | Anzahl im ERM |
|---|---|---|---|
| **1:N** (Pflicht) | Genau 1 → 1 oder N | Links: muss genau 1 sein · Rechts: mindestens 1 (oder viele) | **30** (häufigster Typ) |
| **0..1:0..N** (Optional) | 0 oder 1 → 0 oder N | Links: optional, max. 1 · Rechts: kein, einer oder viele | **13** |
| **1:0..1** (Exklusiv) | Genau 1 → 0 oder 1 | Links: zwingend 1 · Rechts: optional, max. 1 (1:1-Beziehung mit optionaler Seite) | **4** |
| **1:0..N** (Pflicht-Optional) | Genau 1 → 0 oder N | Links: zwingend 1 · Rechts: kein, einer oder viele | **2** |
| **0..1:0..1** (XOR) | 0 oder 1 → 0 oder 1 | Beide Seiten optional · Wird für XOR-Constraints verwendet | **2** (XOR-Constraints) |
| **0..1:N** (Selten) | 0 oder 1 → 1 oder N | Links: optional · Rechts: mindestens einer muss vorhanden sein | **1** |

---

## 3. Verbindertyp 1: 1:N (Pflicht) – `‖ ———— ‖<`

**30 Verbindungen · häufigster Typ · Hierarchische Eltern-Kind-Beziehungen**

Symbolik: Start `‖` (zwei Striche = genau 1, Pflicht) · Ende `<` (Hahnenfuß = viele, Pflicht)

| Von (Source) | Nach (Target) | Beispiel-Lesart |
|---|---|---|
| Regelzone | Bilanzkreis | Eine Regelzone enthält mindestens 1 Bilanzkreis. Jeder Bilanzkreis gehört zu genau 1 Regelzone. |
| Regelzone | Marktgebiet | |
| Marktgebiet | Bilanzierungsgebiet | |
| Netzgebiet | Netzkonto | |
| Bilanzierungsgebiet | BilGeb_NetzGeb | |
| Netzgebiet | BilGeb_NetzGeb | |
| Netzgebiet | NetzGeb_NKP | |
| Netzkopplungspunkt | NetzGeb_NKP | |
| Netzgebiet | Marktlokation | Ein Netzgebiet hat mindestens 1 MaLo. Jede MaLo ist genau 1 Netzgebiet zugeordnet. |
| Netzgebiet | Messlokation | |
| Marktlokation | MaLo_MeLo | |
| Messlokation | MaLo_MeLo | |
| Marktlokation | MaLo_TechRes | |
| TechnischeRessource | MaLo_TechRes | |
| SteuerbareRessource | StRes_StEin | |
| Steuereinrichtung | StRes_StEin | |
| SteuerbareRessource | StRes_StBox | |
| Steuerbox | StRes_StBox | |
| Messlokation | Zaehler | Eine MeLo hat mindestens 1 Zähler. Jeder Zähler gehört zu genau 1 MeLo. |
| Zaehler | Register_Zaehler | |
| Gateway | Register_Gateway | |
| Messdatenregistriergeraet | Reg_MDR | |
| Mengenumwerter | Register_MU | |
| Adresse | Korrespondenzadresse | |
| Kunde | Korrespondenzadresse | |
| Kunde | Kunde_Marktlokation | |
| Marktlokation | Kunde_Marktlokation | |
| Netzgebiet | Netzlokation | |
| Marktlokation | Tranche | |
| Bilanzkreis | Tranche | |

---

## 4. Verbindertyp 2: 0..1:0..N (Optional) – `○| ———— ○<`

**13 Verbindungen · Optionale Zuordnungen · Häufig für schwache Referenzen**

Symbolik: Start `○|` (Kreis + Strich = 0 oder 1, optional) · Ende `○<` (Kreis + Hahnenfuß = 0 oder viele)

Lesart: *„Links kann vorhanden sein (optional), Rechts können beliebig viele zugeordnet sein."*

| Von (Source) | Nach (Target) | Beispiel-Lesart |
|---|---|---|
| Netzkopplungspunkt | Messlokation | |
| Adresse | Marktteilnehmer | Eine Adresse kann keinem, einem oder mehreren Marktteilnehmern zugeordnet sein. Ein Marktteilnehmer hat optional eine Adresse. |
| Ansprechpartner | Marktteilnehmer | |
| Marktrolle | Marktteilnehmer | |
| Ansprechpartner | Kunde | |
| Adresse | Marktlokation | |
| Adresse | Messlokation | |
| Netzlokation | Marktlokation | |
| Bilanzkreis | Tranche | Eine MaLo kann optional einem Bilanzkreis zugeordnet sein. Ein Bilanzkreis kann viele MaLos enthalten. |
| Bilanzkreis | Marktlokation | |
| Bilanzierungsgebiet | Marktlokation | |
| LK_Laendercode | Adresse | Ein Ländercode-Eintrag kann optional in vielen Adressen verwendet werden. Eine Adresse hat optional einen Ländercode. |
| Netzkopplungspunkt | Messlokation | |

---

## 5. Verbindertypen 3, 4 und 5 – Spezialbeziehungen

### Typ 3: 1:0..1 (Exklusiv) – `‖ ———— ○|`

**4 Verbindungen · Exklusive optionale Abhängigkeit**

Links (Parent): muss existieren (Pflicht-1). Rechts (Child): optional, max. 1 Child pro Parent. Typisch für optionale 1:1-Erweiterungen (Zähler-Geräte).

| Von (Source) | Nach (Target) |
|---|---|
| Zähler | Gateway |
| Zähler | Wandlereinrichtung |
| Zähler | Mengenumwerter |
| Gateway | Tarifeinrichtung |

> **Beispiel:** Ein Zähler kann optional ein Gateway haben – aber jedes Gateway gehört genau einem Zähler.

---

### Typ 4: 1:0..N (Pflicht-Optional) – `‖ ———— ○<`

**2 Verbindungen · Pflicht-Parent mit optionalen Kindern**

Links: Pflicht-1 (muss existieren). Rechts: 0 oder N Kinder möglich. Gleich wie 1:N, aber Kinder sind optional (nicht zwingend vorhanden).

| Von (Source) | Nach (Target) |
|---|---|
| SteuerbareRessource | TechnischeRessource |
| Zähler | Kommunikationseinrichtung |

> **Beispiel:** Ein Zähler kann 0, 1 oder viele Kommunikationseinrichtungen haben – muss aber nicht.

---

### Typ 5: 0..1:0..1 (XOR) – `○| ———— ○|`

**2 Verbindungen · Bidirektional optional · XOR-Nutzung**

Beide Seiten optional (0 oder 1). Im BDEW ERM für XOR-Constraints: Genau einer der optionalen FKs muss gesetzt sein (nie beide, nie keiner).

| Von (Source) | Nach (Target) |
|---|---|
| Zähler | Messdatenregistriergerät |
| Mengenumwerter | Messdatenregistriergerät |

> **Beispiel:** Ein MDR gehört entweder zu einem Zähler ODER zu einem Mengenumwerter – nie zu beiden (XOR-Constraint im CK).

---

## 6. Vollständiges Verzeichnis aller 52 Verbinder (r01–r50)

| ID | Von (Source) | Nach (Target) | Typ |
|---|---|---|---|
| r01 | Regelzone | Bilanzkreis | 1:N |
| r02 | Regelzone | Marktgebiet | 1:N |
| r03 | Marktgebiet | Bilanzierungsgebiet | 1:N |
| – | Netzgebiet | Netzkonto | 1:N |
| r05 | Bilanzierungsgebiet | BilGeb_NetzGeb | 1:N |
| r06 | Netzgebiet | BilGeb_NetzGeb | 1:N |
| r07 | Netzgebiet | NetzGeb_NKP | 1:N |
| r08 | Netzkopplungspunkt | NetzGeb_NKP | 1:N |
| r09 | Netzgebiet | Marktlokation | 1:N |
| r10 | Netzgebiet | Messlokation | 1:N |
| r11 | Marktlokation | MaLo_MeLo | 1:N |
| r12 | Messlokation | MaLo_MeLo | 1:N |
| r13 | Marktlokation | MaLo_TechRes | 1:N |
| r14 | TechnischeRessource | MaLo_TechRes | 1:N |
| r16 | SteuerbareRessource | StRes_StEin | 1:N |
| r17 | Steuereinrichtung | StRes_StEin | 1:N |
| r18 | SteuerbareRessource | StRes_StBox | 1:N |
| r19 | Steuerbox | StRes_StBox | 1:N |
| r20 | Messlokation | Zaehler | 1:N |
| – | NKP | Zaehler | 0..1:N |
| – | Zaehler | Gateway | 1:0..1 |
| – | Zaehler | Wandlereinrichtung | 1:0..1 |
| – | Gateway | Tarifeinrichtung | 1:0..1 |
| – | Zaehler | Mengenumwerter | 1:0..1 |
| – | SteuerbareRessource | TechnischeRessource | 1:0..N |
| – | Zaehler | Kommunikationseinrichtung | 1:0..N |
| – | Zaehler | Messdatenregistriergeraet | 0..1:0..1 |
| – | Mengenumwerter | MDR | 0..1:0..1 |
| r27 | Zaehler | Register_Zaehler | 1:N |
| r28 | Gateway | Register_Gateway | 1:N |
| r29 | MDR | Register_MDR | 1:N |
| r30 | Mengenumwerter | Register_MU | 1:N |
| r31 | NKP | Messlokation | 0..1:0..N |
| r34 | Adresse | Korrespondenzadresse | 1:N |
| – | Kunde | Korrespondenzadresse | 1:N |
| – | Kunde | Kunde_Marktlokation | 1:N |
| – | Marktlokation | Kunde_Marktlokation | 1:N |
| r38 | Adresse | Marktteilnehmer | 0..1:0..N |
| – | Ansprechpartner | Marktteilnehmer | 0..1:0..N |
| – | Marktrolle | Marktteilnehmer | 0..1:0..N |
| – | Ansprechpartner | Kunde | 0..1:0..N |
| – | Adresse | Marktlokation | 0..1:0..N |
| – | Adresse | Messlokation | 0..1:0..N |
| – | Netzlokation | Marktlokation | 0..1:0..N |
| r48 | Bilanzkreis | Marktlokation | 0..1:0..N |
| – | Bilanzkreis | Tranche | 0..1:0..N |
| – | Bilanzierungsgebiet | Marktlokation | 0..1:0..N |
| r50 | LK_Laendercode | Adresse | 0..1:0..N |
| – | Netzgebiet | Netzlokation | 1:N |
| – | Marktlokation | Tranche | 1:N |
| – | Bilanzkreis | Tranche | 1:N |

---

## 7. Praxisbeispiel: Haushaltskundin mit Stromzähler

Vollständige Datenkette inkl. aller Verbindertypen – von Regelzone bis Register.

### Kern-Hierarchie (1:N Pflicht)

```
Regelzone          →  Bilanzkreis         (r01 · 1:N)
    APG (AT) / 50Hertz (DE)    BK-DE-0001234

Netzgebiet         →  Marktlokation       (r09 · 1:N)
    NGT-Berlin-Nord            DE00123456789012345678901234567

Marktlokation ↔ Messlokation              (MaLo_MeLo · n:m)
                               DE0123456789012345678901234567 8

Messlokation       →  Zähler              (r20 · 1:N)
                               Gerät: EHZ363W4, Nr: 1234567

Zähler             →  Register            (r27 · 1:N)
                               OBIS: 1-0:1.8.0 (Wirkarbeit +)
```

### Optionale Geräte am Zähler

| Beziehung | Typ | Beschreibung |
|---|---|---|
| Zähler → Gateway | 1:0..1 | Optional – jedes Gateway gehört genau einem Zähler |
| Zähler → Kommunikationseinrichtung | 1:0..N | Optional – 0, 1 oder viele möglich |
| Zähler → Wandlereinrichtung | 1:0..1 | Optional – max. 1 Wandler pro Zähler |

### Akteur-Verbindungen (über Beziehungstabellen)

- **Marktteilnehmer (MPID)** → via r38–r40: Adresse, Ansprechpartner, Marktrolle
- **Kunde** → via Kunde_Marktlokation (r36/r37): verknüpft mit MaLo
- **Korrespondenzadresse** → via r34/r35: Adresse + Kunde kombiniert

### Verbindertypen im Beispiel

| Typ | Relationen | Verwendung |
|---|---|---|
| 1:N (Pflicht) | r01, r09, r20, r27 | Kern-Hierarchie |
| n:m (Auflösung) | MaLo_MeLo | Viele-zu-Viele |
| 1:0..1 (Optional) | Zähler → Gateway / Wandler | Optionale Geräte |
| 1:0..N (Pflicht-Opt) | Zähler → Kommunikationseinr. | Optionale Mehrfachgeräte |
| 0..1:0..N (Opt-Opt) | Adresse / Ansprechpartner → MT | Schwache Referenzen |

---

*BDEW ERM v2.2 | Verbinder & Beziehungstypen*
