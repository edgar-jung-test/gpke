/*
 * ============================================================================
 * BDEW Rollenmodell Marktkommunikation Energiemarkt - Version 2.2 (erweitert)
 * Microsoft SQL Server - Create Script
 *
 * Basierend auf:
 *   - UML-Klassendiagramm des BDEW v2.1
 *   - UTILMD AHB Strom v2.1 (außerordentliche Veroeffentlichung 11.12.2025)
 *
 * Erweiterungen gegenueber v2.1:
 *   - Stammdatenfelder aus UTILMD SG8/SG10 extrahiert
 *   - Adress-Tabellen (Marktlokationsadresse, Korrespondenzadresse, etc.)
 *   - Ansprechpartner / Kommunikationsadressen
 *   - Netzlokation und Tranche als eigene Entitaeten
 *   - Lookup-Tabellen fuer EDIFACT-Codes
 * ============================================================================
 */

-- ============================================================================
-- LOOKUP-TABELLEN (EDIFACT-Code-Listen)
-- ============================================================================

CREATE TABLE [dbo].[Marktrolle] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Kuerzel]       NVARCHAR(10)        NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    CONSTRAINT [PK_Marktrolle] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_Marktrolle_Kuerzel] UNIQUE ([Kuerzel])
);
GO

INSERT INTO [dbo].[Marktrolle] ([Kuerzel], [Bezeichnung]) VALUES
    (N'UNB',  N'Uebertragungsnetzbetreiber'),
    (N'BIKo', N'Bilanzkoordinator'),
    (N'BKV',  N'Bilanzkreisverantwortlicher'),
    (N'NB',   N'Netzbetreiber'),
    (N'LF',   N'Lieferant'),
    (N'MSB',  N'Messstellenbetreiber'),
    (N'MGV',  N'Marktgebietsverantwortlicher'),
    (N'DP',   N'Dienstleister'),
    (N'ESA',  N'Energieserviceanbieter'),
    (N'BTR',  N'Betreiber Technische Ressource'),
    (N'EIV',  N'Einsatzverantwortlicher'),
    (N'RB',   N'Registerbetreiber'),
    (N'KN',   N'Transportkunde'),
    (N'ND',   N'Nachfrager/Dienstleister');
GO

-- Lookup: Spannungsebene (SG10 CCI+E03)
CREATE TABLE [dbo].[LK_Spannungsebene] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Code]          NVARCHAR(10)        NOT NULL,
    [Bezeichnung]   NVARCHAR(100)       NOT NULL,
    CONSTRAINT [PK_LK_Spannungsebene] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_LK_Spannungsebene_Code] UNIQUE ([Code])
);
GO
INSERT INTO [dbo].[LK_Spannungsebene] ([Code], [Bezeichnung]) VALUES
    (N'E03', N'Hoechstspannung'),
    (N'E04', N'Hochspannung'),
    (N'E05', N'Mittelspannung'),
    (N'E06', N'Niederspannung'),
    (N'E07', N'HoeS/HS Umspannung'),
    (N'E08', N'HS/MS Umspannung'),
    (N'E09', N'MS/NS Umspannung');
GO

-- Lookup: Lieferrichtung (SG10 CCI+Z30)
CREATE TABLE [dbo].[LK_Lieferrichtung] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Code]          NVARCHAR(10)        NOT NULL,
    [Bezeichnung]   NVARCHAR(100)       NOT NULL,
    CONSTRAINT [PK_LK_Lieferrichtung] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_LK_Lieferrichtung_Code] UNIQUE ([Code])
);
GO
INSERT INTO [dbo].[LK_Lieferrichtung] ([Code], [Bezeichnung]) VALUES
    (N'Z06', N'Erzeugung'),
    (N'Z07', N'Verbrauch');
GO

-- Lookup: Messtechnische Einordnung (SG10 CCI+Z83)
CREATE TABLE [dbo].[LK_MesstechnischeEinordnung] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Code]          NVARCHAR(10)        NOT NULL,
    [Bezeichnung]   NVARCHAR(100)       NOT NULL,
    CONSTRAINT [PK_LK_MesstechnEinord] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_LK_MesstechnEinord_Code] UNIQUE ([Code])
);
GO
INSERT INTO [dbo].[LK_MesstechnischeEinordnung] ([Code], [Bezeichnung]) VALUES
    (N'Z52', N'iMS (intelligentes Messsystem)'),
    (N'Z53', N'kME / mME (konventionelle/moderne Messeinrichtung)'),
    (N'Z68', N'keine Messung');
GO

-- Lookup: Prognosegrundlage (SG10 CCI+ZA6/ZC0)
CREATE TABLE [dbo].[LK_Prognosegrundlage] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Code]          NVARCHAR(10)        NOT NULL,
    [Bezeichnung]   NVARCHAR(100)       NOT NULL,
    CONSTRAINT [PK_LK_Prognosegrundlage] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_LK_Prognosegrundlage_Code] UNIQUE ([Code])
);
GO
INSERT INTO [dbo].[LK_Prognosegrundlage] ([Code], [Bezeichnung]) VALUES
    (N'ZA6', N'Prognose auf Basis von Profilen'),
    (N'ZC0', N'Prognose auf Basis von Werten'),
    (N'E02', N'SLP/SEP (Standardlastprofil)'),
    (N'E14', N'TLP/TEP (Tagesparameterabhaengig)'),
    (N'Z36', N'TEP mit Referenzmessung');
GO

-- Lookup: Verbrauchsart (SG10 CCI Verbrauchsart)
CREATE TABLE [dbo].[LK_Verbrauchsart] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Code]          NVARCHAR(10)        NOT NULL,
    [Bezeichnung]   NVARCHAR(100)       NOT NULL,
    CONSTRAINT [PK_LK_Verbrauchsart] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_LK_Verbrauchsart_Code] UNIQUE ([Code])
);
GO
INSERT INTO [dbo].[LK_Verbrauchsart] ([Code], [Bezeichnung]) VALUES
    (N'Z64', N'Waermepumpe'),
    (N'Z65', N'Direktheizung'),
    (N'Z66', N'Speicherheizung'),
    (N'Z67', N'Sonstiger unterbrechbarer Verbrauch'),
    (N'ZA8', N'Nicht unterbrechbar');
GO

-- Lookup: Art der erzeugenden Marktlokation
CREATE TABLE [dbo].[LK_ArtErzeugendeMaLo] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Code]          NVARCHAR(10)        NOT NULL,
    [Bezeichnung]   NVARCHAR(100)       NOT NULL,
    CONSTRAINT [PK_LK_ArtErzMaLo] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_LK_ArtErzMaLo_Code] UNIQUE ([Code])
);
GO
INSERT INTO [dbo].[LK_ArtErzeugendeMaLo] ([Code], [Bezeichnung]) VALUES
    (N'Z29', N'Erzeugungsanlage (Wind)'),
    (N'Z30', N'Erzeugungsanlage (Solar)'),
    (N'Z31', N'Erzeugungsanlage (sonstige)'),
    (N'Z32', N'Speicher');
GO

-- Lookup: Veraeusserungsform
CREATE TABLE [dbo].[LK_Veraeusserungsform] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Code]          NVARCHAR(10)        NOT NULL,
    [Bezeichnung]   NVARCHAR(100)       NOT NULL,
    CONSTRAINT [PK_LK_Veraeusserungsform] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_LK_Veraeusserungsform_Code] UNIQUE ([Code])
);
GO
INSERT INTO [dbo].[LK_Veraeusserungsform] ([Code], [Bezeichnung]) VALUES
    (N'Z33', N'Marktpraemie'),
    (N'Z34', N'Einspeiseverguetung'),
    (N'Z35', N'Sonstige Direktvermarktung'),
    (N'ZA0', N'Mieterstromzuschlag');
GO

-- Lookup: MSB-Typ (Grundzustaendig/Wettbewerblich/Auffang)
CREATE TABLE [dbo].[LK_MSBTyp] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Code]          NVARCHAR(10)        NOT NULL,
    [Bezeichnung]   NVARCHAR(100)       NOT NULL,
    CONSTRAINT [PK_LK_MSBTyp] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_LK_MSBTyp_Code] UNIQUE ([Code])
);
GO
INSERT INTO [dbo].[LK_MSBTyp] ([Code], [Bezeichnung]) VALUES
    (N'Z39', N'Grundzustaendiger Messstellenbetreiber'),
    (N'Z40', N'Wettbewerblicher Messstellenbetreiber'),
    (N'Z41', N'Auffangmessstellenbetreiber');
GO

-- Lookup: Laendercode
CREATE TABLE [dbo].[LK_Laendercode] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Code]          NVARCHAR(3)         NOT NULL,
    [Bezeichnung]   NVARCHAR(100)       NOT NULL,
    CONSTRAINT [PK_LK_Laendercode] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_LK_Laendercode_Code] UNIQUE ([Code])
);
GO
INSERT INTO [dbo].[LK_Laendercode] ([Code], [Bezeichnung]) VALUES
    (N'DE', N'Deutschland'), (N'AT', N'Oesterreich'), (N'CH', N'Schweiz'),
    (N'FR', N'Frankreich'), (N'NL', N'Niederlande'), (N'BE', N'Belgien'),
    (N'PL', N'Polen'), (N'CZ', N'Tschechien'), (N'DK', N'Daenemark'),
    (N'LU', N'Luxemburg');
GO

-- ============================================================================
-- ADRESS-TABELLEN (nicht im BDEW-Rollenmodell, aber fuer UTILMD erforderlich)
-- ============================================================================

-- Allgemeine Adresse (wiederverwendbar fuer verschiedene Adresstypen)
CREATE TABLE [dbo].[Adresse] (
    [ID]                    INT IDENTITY(1,1)   NOT NULL,
    [Strasse]               NVARCHAR(200)       NULL,  -- NAD DE3042
    [Hausnummer]            NVARCHAR(20)        NULL,
    [HausnummerErgaenzung]  NVARCHAR(20)        NULL,
    [Postfach]              NVARCHAR(50)        NULL,  -- NAD DE3042 Alternative
    [Postleitzahl]          NVARCHAR(20)        NULL,  -- NAD DE3251
    [Ort]                   NVARCHAR(200)       NOT NULL, -- NAD DE3164
    [Ortsteil]              NVARCHAR(200)       NULL,
    [LaendercodeID]         INT                 NULL,  -- NAD DE3207
    [Stockwerk]             NVARCHAR(20)        NULL,
    [Gemarkung]             NVARCHAR(200)       NULL,
    [Flur]                  NVARCHAR(50)        NULL,
    [Flurstueck]            NVARCHAR(50)        NULL,
    [Zusatzinfo]            NVARCHAR(500)       NULL,  -- NAD DE3124
    CONSTRAINT [PK_Adresse] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_Adresse_Laendercode] FOREIGN KEY ([LaendercodeID])
        REFERENCES [dbo].[LK_Laendercode]([ID])
);
GO

-- Kontaktperson / Ansprechpartner (SG3 CTA/COM)
CREATE TABLE [dbo].[Ansprechpartner] (
    [ID]                INT IDENTITY(1,1)   NOT NULL,
    [Anrede]            NVARCHAR(20)        NULL,
    [Titel]             NVARCHAR(50)        NULL,
    [Vorname]           NVARCHAR(100)       NULL,
    [Nachname]          NVARCHAR(200)       NULL,
    [Firmenname]        NVARCHAR(200)       NULL,
    [Funktion]          NVARCHAR(100)       NULL,  -- CTA DE3139 (IC = Informationskontakt)
    [Telefon]           NVARCHAR(50)        NULL,  -- COM DE3148 + TE
    [TelefonWeiteres]   NVARCHAR(50)        NULL,  -- COM DE3148 + AJ
    [Telefax]           NVARCHAR(50)        NULL,  -- COM DE3148 + FX
    [Mobiltelefon]      NVARCHAR(50)        NULL,  -- COM DE3148 + AL
    [EMail]             NVARCHAR(200)       NULL,  -- COM DE3148 + EM
    CONSTRAINT [PK_Ansprechpartner] PRIMARY KEY CLUSTERED ([ID])
);
GO

-- Marktteilnehmer / Marktpartner (SG2/SG12 NAD MP-ID)
CREATE TABLE [dbo].[Marktteilnehmer] (
    [ID]                INT IDENTITY(1,1)   NOT NULL,
    [MPID]              NVARCHAR(20)        NOT NULL,  -- 13-stellige MP-ID (GS1 GLN oder BDEW-Code)
    [Codesystem]        NVARCHAR(10)        NOT NULL,  -- 9=GS1, 293=BDEW
    [Name1]             NVARCHAR(200)       NOT NULL,
    [Name2]             NVARCHAR(200)       NULL,
    [Name3]             NVARCHAR(200)       NULL,
    [MarktrolleID]      INT                 NULL,
    [AdresseID]         INT                 NULL,
    [AnsprechpartnerID] INT                 NULL,
    CONSTRAINT [PK_Marktteilnehmer] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_Marktteilnehmer_MPID] UNIQUE ([MPID]),
    CONSTRAINT [FK_Marktteilnehmer_Marktrolle] FOREIGN KEY ([MarktrolleID])
        REFERENCES [dbo].[Marktrolle]([ID]),
    CONSTRAINT [FK_Marktteilnehmer_Adresse] FOREIGN KEY ([AdresseID])
        REFERENCES [dbo].[Adresse]([ID]),
    CONSTRAINT [FK_Marktteilnehmer_Ansprechpartner] FOREIGN KEY ([AnsprechpartnerID])
        REFERENCES [dbo].[Ansprechpartner]([ID])
);
GO

-- ============================================================================
-- ZONEN / GEBIETE (unveraendert aus v2.1)
-- ============================================================================

CREATE TABLE [dbo].[Regelzone] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    [EICCode]       NVARCHAR(20)        NULL,  -- Energy Identification Code
    CONSTRAINT [PK_Regelzone] PRIMARY KEY CLUSTERED ([ID])
);
GO

CREATE TABLE [dbo].[Bilanzkreis] (
    [ID]                INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]       NVARCHAR(200)       NOT NULL,
    [BilanzkreisCode]   NVARCHAR(20)        NULL,  -- SG10 Bilanzkreis
    [RegelzoneID]       INT                 NOT NULL,
    CONSTRAINT [PK_Bilanzkreis] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_Bilanzkreis_Regelzone] FOREIGN KEY ([RegelzoneID])
        REFERENCES [dbo].[Regelzone]([ID])
);
GO

CREATE TABLE [dbo].[Marktgebiet] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    [RegelzoneID]   INT                 NOT NULL,
    CONSTRAINT [PK_Marktgebiet] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_Marktgebiet_Regelzone] FOREIGN KEY ([RegelzoneID])
        REFERENCES [dbo].[Regelzone]([ID])
);
GO

CREATE TABLE [dbo].[Bilanzierungsgebiet] (
    [ID]                      INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]             NVARCHAR(200)       NOT NULL,
    [BilanzierungsgebietCode] NVARCHAR(20)        NULL,  -- SG10 Bilanzierungsgebiet
    [MarktgebietID]           INT                 NOT NULL,
    CONSTRAINT [PK_Bilanzierungsgebiet] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_Bilanzierungsgebiet_Marktgebiet] FOREIGN KEY ([MarktgebietID])
        REFERENCES [dbo].[Marktgebiet]([ID])
);
GO

CREATE TABLE [dbo].[Netzgebiet] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    CONSTRAINT [PK_Netzgebiet] PRIMARY KEY CLUSTERED ([ID])
);
GO

CREATE TABLE [dbo].[Bilanzierungsgebiet_Netzgebiet] (
    [ID]                      INT IDENTITY(1,1)   NOT NULL,
    [BilanzierungsgebietID]   INT                 NOT NULL,
    [NetzgebietID]            INT                 NOT NULL,
    CONSTRAINT [PK_BilGeb_NetzGeb] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_BilGeb_NetzGeb_BilGeb] FOREIGN KEY ([BilanzierungsgebietID])
        REFERENCES [dbo].[Bilanzierungsgebiet]([ID]),
    CONSTRAINT [FK_BilGeb_NetzGeb_NetzGeb] FOREIGN KEY ([NetzgebietID])
        REFERENCES [dbo].[Netzgebiet]([ID]),
    CONSTRAINT [UQ_BilGeb_NetzGeb] UNIQUE ([BilanzierungsgebietID], [NetzgebietID])
);
GO

CREATE TABLE [dbo].[Netzkonto] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    [NetzgebietID]  INT                 NOT NULL,
    CONSTRAINT [PK_Netzkonto] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_Netzkonto_Netzgebiet] FOREIGN KEY ([NetzgebietID])
        REFERENCES [dbo].[Netzgebiet]([ID])
);
GO

CREATE TABLE [dbo].[Netzkopplungspunkt] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    CONSTRAINT [PK_Netzkopplungspunkt] PRIMARY KEY CLUSTERED ([ID])
);
GO

CREATE TABLE [dbo].[Netzgebiet_Netzkopplungspunkt] (
    [ID]                      INT IDENTITY(1,1)   NOT NULL,
    [NetzgebietID]            INT                 NOT NULL,
    [NetzkopplungspunktID]    INT                 NOT NULL,
    CONSTRAINT [PK_NetzGeb_NKP] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_NetzGeb_NKP_NetzGeb] FOREIGN KEY ([NetzgebietID])
        REFERENCES [dbo].[Netzgebiet]([ID]),
    CONSTRAINT [FK_NetzGeb_NKP_NKP] FOREIGN KEY ([NetzkopplungspunktID])
        REFERENCES [dbo].[Netzkopplungspunkt]([ID]),
    CONSTRAINT [UQ_NetzGeb_NKP] UNIQUE ([NetzgebietID], [NetzkopplungspunktID])
);
GO

-- ============================================================================
-- RESSOURCEN / STEUERUNG (erweitert mit UTILMD-Feldern)
-- ============================================================================

CREATE TABLE [dbo].[SteuerbareRessource] (
    [ID]                        INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]               NVARCHAR(200)       NOT NULL,
    [SteuerbareRessourceID_ext] NVARCHAR(50)        NULL,  -- Externe ID (SG5 LOC)
    [StatusFernsteuerbarkeit]   NVARCHAR(50)        NULL,  -- SG10 Status der Fernsteuerbarkeit
    CONSTRAINT [PK_SteuerbareRessource] PRIMARY KEY CLUSTERED ([ID])
);
GO

CREATE TABLE [dbo].[TechnischeRessource] (
    [ID]                          INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]                 NVARCHAR(200)       NOT NULL,
    [TechnischeRessourceID_ext]   NVARCHAR(50)        NULL,  -- Externe ID (SG5 LOC)
    [SteuerbareRessourceID]       INT                 NULL,
    CONSTRAINT [PK_TechnischeRessource] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_TechRes_SteuerbRes] FOREIGN KEY ([SteuerbareRessourceID])
        REFERENCES [dbo].[SteuerbareRessource]([ID])
);
GO

CREATE TABLE [dbo].[Steuereinrichtung] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    CONSTRAINT [PK_Steuereinrichtung] PRIMARY KEY CLUSTERED ([ID])
);
GO

CREATE TABLE [dbo].[Steuerbox] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    CONSTRAINT [PK_Steuerbox] PRIMARY KEY CLUSTERED ([ID])
);
GO

CREATE TABLE [dbo].[SteuerbareRessource_Steuereinrichtung] (
    [ID]                      INT IDENTITY(1,1)   NOT NULL,
    [SteuerbareRessourceID]   INT                 NOT NULL,
    [SteuereinrichtungID]     INT                 NOT NULL,
    CONSTRAINT [PK_StRes_StEin] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_StRes_StEin_StRes] FOREIGN KEY ([SteuerbareRessourceID])
        REFERENCES [dbo].[SteuerbareRessource]([ID]),
    CONSTRAINT [FK_StRes_StEin_StEin] FOREIGN KEY ([SteuereinrichtungID])
        REFERENCES [dbo].[Steuereinrichtung]([ID]),
    CONSTRAINT [UQ_StRes_StEin] UNIQUE ([SteuerbareRessourceID], [SteuereinrichtungID])
);
GO

CREATE TABLE [dbo].[SteuerbareRessource_Steuerbox] (
    [ID]                      INT IDENTITY(1,1)   NOT NULL,
    [SteuerbareRessourceID]   INT                 NOT NULL,
    [SteuerboxID]             INT                 NOT NULL,
    CONSTRAINT [PK_StRes_StBox] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_StRes_StBox_StRes] FOREIGN KEY ([SteuerbareRessourceID])
        REFERENCES [dbo].[SteuerbareRessource]([ID]),
    CONSTRAINT [FK_StRes_StBox_StBox] FOREIGN KEY ([SteuerboxID])
        REFERENCES [dbo].[Steuerbox]([ID]),
    CONSTRAINT [UQ_StRes_StBox] UNIQUE ([SteuerbareRessourceID], [SteuerboxID])
);
GO

-- ============================================================================
-- NETZLOKATION (neu - aus UTILMD SG8 SEQ+Z15)
-- ============================================================================
CREATE TABLE [dbo].[Netzlokation] (
    [ID]                    INT IDENTITY(1,1)   NOT NULL,
    [NetzlokationsID_ext]   NVARCHAR(50)        NOT NULL,  -- Netzlokations-ID (SG5 LOC+Z15)
    [Bezeichnung]           NVARCHAR(200)       NULL,
    [NetzgebietID]          INT                 NULL,
    [ObisKennzahl]          NVARCHAR(50)        NULL,  -- OBIS-Kennzahl der Netzlokation
    CONSTRAINT [PK_Netzlokation] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_Netzlokation_ExtID] UNIQUE ([NetzlokationsID_ext]),
    CONSTRAINT [FK_Netzlokation_Netzgebiet] FOREIGN KEY ([NetzgebietID])
        REFERENCES [dbo].[Netzgebiet]([ID])
);
GO

-- ============================================================================
-- MARKTLOKATION (erweitert mit UTILMD SG8 SEQ+Z01 Stammdatenfeldern)
-- NB verwaltet, LF nutzt, MSB nutzt, RB nutzt, UNB nutzt
-- ============================================================================
CREATE TABLE [dbo].[Marktlokation] (
    [ID]                            INT IDENTITY(1,1)   NOT NULL,
    [MarktlokationsID_ext]          NVARCHAR(33)        NOT NULL,  -- MaLo-ID (SG5 LOC DE3225)
    [Bezeichnung]                   NVARCHAR(200)       NULL,
    [NetzgebietID]                  INT                 NOT NULL,

    -- SG10 Stammdaten aus UTILMD
    [Lieferrichtung]                NVARCHAR(10)        NULL,  -- Z06=Erzeugung, Z07=Verbrauch
    [SpannungsebeneCode]            NVARCHAR(10)        NULL,  -- E03-E06
    [UmspannungCode]                NVARCHAR(10)        NULL,  -- E07-E09
    [MesstechnischeEinordnung]      NVARCHAR(10)        NULL,  -- Z52=iMS, Z53=kME/mME, Z68=keine
    [PrognosegrundlageCode]         NVARCHAR(10)        NULL,  -- ZA6/ZC0
    [ProfilartCode]                 NVARCHAR(10)        NULL,  -- E02=SLP/SEP, E14=TLP/TEP, Z36=TEP+Ref
    [ArtErzeugendeMaLoCode]         NVARCHAR(10)        NULL,  -- Z29-Z32
    [VeraeusserungsformCode]        NVARCHAR(10)        NULL,  -- Z33-Z35, ZA0
    [Grundversorgung]               NVARCHAR(10)        NULL,  -- ZD0

    -- Mengen (SG9 QTY)
    [JahresverbrauchsprognoseKWH]   DECIMAL(18,3)       NULL,  -- QTY+31 (kWh)
    [LeistungKW]                    DECIMAL(18,3)       NULL,  -- QTY+Z10 (kW)

    -- Zugeordnete Marktpartner (SG10 CCI+ZB3)
    [NetzbetreiberMPID]             NVARCHAR(20)        NULL,  -- NB MP-ID
    [UebertragungsnetzbetreiberMPID] NVARCHAR(20)       NULL,  -- UeNB MP-ID
    [MSB_MPID]                      NVARCHAR(20)        NULL,  -- MSB MP-ID
    [MSBTypCode]                    NVARCHAR(10)        NULL,  -- Z39/Z40/Z41

    -- Bilanzierung (SG10)
    [BilanzkreisID]                 INT                 NULL,
    [BilanzierungsgebietID]         INT                 NULL,
    [Zeitreihentyp]                 NVARCHAR(20)        NULL,  -- SG10 Zeitreihentyp
    [AggregationsverantwortungMaBiS] NVARCHAR(10)       NULL,  -- ZA8=NB, ZA9=UeNB
    [Netznutzung]                   NVARCHAR(50)        NULL,  -- SG10 Netznutzung
    [Abwicklungsmodell]             NVARCHAR(50)        NULL,  -- SG10 Abwicklungsmodell
    [PaketID]                       NVARCHAR(50)        NULL,  -- SG10 Paket-ID

    -- Referenzen auf Lokationsbuendel
    [LokationsbuendelCode]          NVARCHAR(50)        NULL,  -- SG8 SEQ+Z58

    -- Adressen
    [MarktlokationsadresseID]       INT                 NULL,
    [NetzlokationID]                INT                 NULL,

    -- Gueltigkeitszeitraum
    [GueltigAb]                     DATETIME2           NULL,
    [GueltigBis]                    DATETIME2           NULL,

    CONSTRAINT [PK_Marktlokation] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_Marktlokation_ExtID] UNIQUE ([MarktlokationsID_ext]),
    CONSTRAINT [FK_Marktlokation_Netzgebiet] FOREIGN KEY ([NetzgebietID])
        REFERENCES [dbo].[Netzgebiet]([ID]),
    CONSTRAINT [FK_Marktlokation_Bilanzkreis] FOREIGN KEY ([BilanzkreisID])
        REFERENCES [dbo].[Bilanzkreis]([ID]),
    CONSTRAINT [FK_Marktlokation_BilGeb] FOREIGN KEY ([BilanzierungsgebietID])
        REFERENCES [dbo].[Bilanzierungsgebiet]([ID]),
    CONSTRAINT [FK_Marktlokation_Adresse] FOREIGN KEY ([MarktlokationsadresseID])
        REFERENCES [dbo].[Adresse]([ID]),
    CONSTRAINT [FK_Marktlokation_Netzlokation] FOREIGN KEY ([NetzlokationID])
        REFERENCES [dbo].[Netzlokation]([ID])
);
GO

-- ============================================================================
-- TRANCHE (neu - aus UTILMD SG8 SEQ+Z03)
-- Tranche als Teilmenge einer Marktlokation
-- ============================================================================
CREATE TABLE [dbo].[Tranche] (
    [ID]                        INT IDENTITY(1,1)   NOT NULL,
    [TranchenID_ext]            NVARCHAR(50)        NOT NULL,  -- Tranchen-ID (SG5 LOC)
    [Bezeichnung]               NVARCHAR(200)       NULL,
    [MarktlokationID]           INT                 NOT NULL,
    [TranchengroesseKWH]        DECIMAL(18,3)       NULL,  -- SG9 QTY Tranchengroesse
    [BilanzkreisID]             INT                 NULL,
    [ProfilartCode]             NVARCHAR(10)        NULL,
    [GueltigAb]                 DATETIME2           NULL,
    [GueltigBis]                DATETIME2           NULL,
    CONSTRAINT [PK_Tranche] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_Tranche_ExtID] UNIQUE ([TranchenID_ext]),
    CONSTRAINT [FK_Tranche_Marktlokation] FOREIGN KEY ([MarktlokationID])
        REFERENCES [dbo].[Marktlokation]([ID]),
    CONSTRAINT [FK_Tranche_Bilanzkreis] FOREIGN KEY ([BilanzkreisID])
        REFERENCES [dbo].[Bilanzkreis]([ID])
);
GO

-- ============================================================================
-- MESSLOKATION (erweitert mit UTILMD SG8 SEQ+Z04 Feldern)
-- NB verwaltet, MSB nutzt
-- ============================================================================
CREATE TABLE [dbo].[Messlokation] (
    [ID]                        INT IDENTITY(1,1)   NOT NULL,
    [MesslokationsID_ext]       NVARCHAR(33)        NOT NULL,  -- MeLo-ID (SG5 LOC DE3225)
    [Bezeichnung]               NVARCHAR(200)       NULL,
    [NetzgebietID]              INT                 NOT NULL,
    [NetzkopplungspunktID]      INT                 NULL,

    -- SG10 Stammdaten
    [SpannungsebeneCode]        NVARCHAR(10)        NULL,  -- Netzebene/Spannungsebene der MeLo
    [Zaehlverfahren]            NVARCHAR(50)        NULL,
    [MSB_MPID]                  NVARCHAR(20)        NULL,
    [Zaehlzeitdefinition]       NVARCHAR(50)        NULL,  -- SG10 Zaehlzeitdefinition

    -- Adresse der Messlokation
    [MesslokationsadresseID]    INT                 NULL,

    [GueltigAb]                 DATETIME2           NULL,
    [GueltigBis]                DATETIME2           NULL,

    CONSTRAINT [PK_Messlokation] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [UQ_Messlokation_ExtID] UNIQUE ([MesslokationsID_ext]),
    CONSTRAINT [FK_Messlokation_Netzgebiet] FOREIGN KEY ([NetzgebietID])
        REFERENCES [dbo].[Netzgebiet]([ID]),
    CONSTRAINT [FK_Messlokation_NKP] FOREIGN KEY ([NetzkopplungspunktID])
        REFERENCES [dbo].[Netzkopplungspunkt]([ID]),
    CONSTRAINT [FK_Messlokation_Adresse] FOREIGN KEY ([MesslokationsadresseID])
        REFERENCES [dbo].[Adresse]([ID])
);
GO

-- M:N Zuordnungen
CREATE TABLE [dbo].[Marktlokation_Messlokation] (
    [ID]              INT IDENTITY(1,1)   NOT NULL,
    [MarktlokationID] INT                NOT NULL,
    [MesslokationID]  INT                NOT NULL,
    CONSTRAINT [PK_MaLo_MeLo] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_MaLo_MeLo_MaLo] FOREIGN KEY ([MarktlokationID])
        REFERENCES [dbo].[Marktlokation]([ID]),
    CONSTRAINT [FK_MaLo_MeLo_MeLo] FOREIGN KEY ([MesslokationID])
        REFERENCES [dbo].[Messlokation]([ID]),
    CONSTRAINT [UQ_MaLo_MeLo] UNIQUE ([MarktlokationID], [MesslokationID])
);
GO

CREATE TABLE [dbo].[Marktlokation_TechnischeRessource] (
    [ID]                      INT IDENTITY(1,1)   NOT NULL,
    [MarktlokationID]         INT                 NOT NULL,
    [TechnischeRessourceID]   INT                 NOT NULL,
    CONSTRAINT [PK_MaLo_TechRes] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_MaLo_TechRes_MaLo] FOREIGN KEY ([MarktlokationID])
        REFERENCES [dbo].[Marktlokation]([ID]),
    CONSTRAINT [FK_MaLo_TechRes_TechRes] FOREIGN KEY ([TechnischeRessourceID])
        REFERENCES [dbo].[TechnischeRessource]([ID]),
    CONSTRAINT [UQ_MaLo_TechRes] UNIQUE ([MarktlokationID], [TechnischeRessourceID])
);
GO

-- ============================================================================
-- KUNDEN- UND KORRESPONDENZADRESSEN (aus UTILMD SG12 NAD)
-- ============================================================================

-- Kunde eines Lieferanten (SG12 NAD+Z09)
CREATE TABLE [dbo].[Kunde] (
    [ID]                    INT IDENTITY(1,1)   NOT NULL,
    [Name]                  NVARCHAR(200)       NOT NULL,  -- NAD DE3036
    [Name2]                 NVARCHAR(200)       NULL,
    [Name3]                 NVARCHAR(200)       NULL,
    [Namensstruktur]        NVARCHAR(10)        NULL,  -- Z01=Person, Z02=Firma (NAD DE3045)
    [Anrede]                NVARCHAR(20)        NULL,
    [Titel]                 NVARCHAR(50)        NULL,
    [AnsprechpartnerID]     INT                 NULL,
    CONSTRAINT [PK_Kunde] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_Kunde_Ansprechpartner] FOREIGN KEY ([AnsprechpartnerID])
        REFERENCES [dbo].[Ansprechpartner]([ID])
);
GO

-- Korrespondenzanschrift des Kunden (SG12 NAD+Z04)
-- "Wenn keine Korrespondenzanschrift vorliegt, ist die Anschrift der Marktlokation zu uebermitteln"
CREATE TABLE [dbo].[Korrespondenzadresse] (
    [ID]                    INT IDENTITY(1,1)   NOT NULL,
    [KundeID]               INT                 NOT NULL,
    [AdresseID]             INT                 NOT NULL,
    [IstMarktlokationsadresse] BIT              NOT NULL DEFAULT 0,  -- Flag wenn MaLo-Adr. verwendet
    CONSTRAINT [PK_Korrespondenzadresse] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_KorrAdr_Kunde] FOREIGN KEY ([KundeID])
        REFERENCES [dbo].[Kunde]([ID]),
    CONSTRAINT [FK_KorrAdr_Adresse] FOREIGN KEY ([AdresseID])
        REFERENCES [dbo].[Adresse]([ID])
);
GO

-- Zuordnung: Kunde <-> Marktlokation (ueber den Lieferanten)
CREATE TABLE [dbo].[Kunde_Marktlokation] (
    [ID]                INT IDENTITY(1,1)   NOT NULL,
    [KundeID]           INT                 NOT NULL,
    [MarktlokationID]   INT                NOT NULL,
    [LieferantMPID]     NVARCHAR(20)        NULL,  -- MP-ID des zuordnenden LF
    [GueltigAb]         DATETIME2           NULL,
    [GueltigBis]        DATETIME2           NULL,
    CONSTRAINT [PK_Kunde_MaLo] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_Kunde_MaLo_Kunde] FOREIGN KEY ([KundeID])
        REFERENCES [dbo].[Kunde]([ID]),
    CONSTRAINT [FK_Kunde_MaLo_MaLo] FOREIGN KEY ([MarktlokationID])
        REFERENCES [dbo].[Marktlokation]([ID])
);
GO

-- ============================================================================
-- ZAEHLWESEN (erweitert)
-- ============================================================================

CREATE TABLE [dbo].[Zaehler] (
    [ID]                      INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]             NVARCHAR(200)       NOT NULL,
    [Zaehlernummer]           NVARCHAR(50)        NULL,  -- Geraetenummer
    [MesslokationID]          INT                 NULL,
    [NetzkopplungspunktID]    INT                 NULL,
    CONSTRAINT [PK_Zaehler] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_Zaehler_Messlokation] FOREIGN KEY ([MesslokationID])
        REFERENCES [dbo].[Messlokation]([ID]),
    CONSTRAINT [FK_Zaehler_NKP] FOREIGN KEY ([NetzkopplungspunktID])
        REFERENCES [dbo].[Netzkopplungspunkt]([ID]),
    CONSTRAINT [CK_Zaehler_Zuordnung] CHECK (
        ([MesslokationID] IS NOT NULL AND [NetzkopplungspunktID] IS NULL)
        OR ([MesslokationID] IS NULL AND [NetzkopplungspunktID] IS NOT NULL)
    )
);
GO

CREATE TABLE [dbo].[Gateway] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    [ZaehlerID]     INT                 NOT NULL,
    CONSTRAINT [PK_Gateway] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_Gateway_Zaehler] FOREIGN KEY ([ZaehlerID])
        REFERENCES [dbo].[Zaehler]([ID]),
    CONSTRAINT [UQ_Gateway_Zaehler] UNIQUE ([ZaehlerID])
);
GO

CREATE TABLE [dbo].[Wandlereinrichtung] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    [ZaehlerID]     INT                 NOT NULL,
    CONSTRAINT [PK_Wandlereinrichtung] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_Wandlereinrichtung_Zaehler] FOREIGN KEY ([ZaehlerID])
        REFERENCES [dbo].[Zaehler]([ID]),
    CONSTRAINT [UQ_Wandlereinrichtung_Zaehler] UNIQUE ([ZaehlerID])
);
GO

CREATE TABLE [dbo].[Tarifeinrichtung] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    [ZaehlerID]     INT                 NOT NULL,
    CONSTRAINT [PK_Tarifeinrichtung] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_Tarifeinrichtung_Zaehler] FOREIGN KEY ([ZaehlerID])
        REFERENCES [dbo].[Zaehler]([ID]),
    CONSTRAINT [UQ_Tarifeinrichtung_Zaehler] UNIQUE ([ZaehlerID])
);
GO

CREATE TABLE [dbo].[Kommunikationseinrichtung] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    [ZaehlerID]     INT                 NOT NULL,
    CONSTRAINT [PK_Kommunikationseinrichtung] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_Kommunikationseinrichtung_Zaehler] FOREIGN KEY ([ZaehlerID])
        REFERENCES [dbo].[Zaehler]([ID])
);
GO

CREATE TABLE [dbo].[Mengenumwerter] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    [ZaehlerID]     INT                 NOT NULL,
    CONSTRAINT [PK_Mengenumwerter] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_Mengenumwerter_Zaehler] FOREIGN KEY ([ZaehlerID])
        REFERENCES [dbo].[Zaehler]([ID]),
    CONSTRAINT [UQ_Mengenumwerter_Zaehler] UNIQUE ([ZaehlerID])
);
GO

CREATE TABLE [dbo].[Messdatenregistriergeraet] (
    [ID]                INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]       NVARCHAR(200)       NOT NULL,
    [ZaehlerID]         INT                 NULL,
    [MengenumwerterID]  INT                 NULL,
    CONSTRAINT [PK_Messdatenregistriergeraet] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_MessdatenReg_Zaehler] FOREIGN KEY ([ZaehlerID])
        REFERENCES [dbo].[Zaehler]([ID]),
    CONSTRAINT [FK_MessdatenReg_Mengenumwerter] FOREIGN KEY ([MengenumwerterID])
        REFERENCES [dbo].[Mengenumwerter]([ID]),
    CONSTRAINT [CK_MessdatenReg_Zuordnung] CHECK (
        ([ZaehlerID] IS NOT NULL AND [MengenumwerterID] IS NULL)
        OR ([ZaehlerID] IS NULL AND [MengenumwerterID] IS NOT NULL)
    )
);
GO

-- ============================================================================
-- REGISTER (unveraendert)
-- ============================================================================

CREATE TABLE [dbo].[Register_Zaehler] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    [ZaehlerID]     INT                 NOT NULL,
    [ObisKennzahl]  NVARCHAR(50)        NULL,
    CONSTRAINT [PK_Register_Zaehler] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_RegZaehler_Zaehler] FOREIGN KEY ([ZaehlerID])
        REFERENCES [dbo].[Zaehler]([ID])
);
GO

CREATE TABLE [dbo].[Register_Gateway] (
    [ID]            INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]   NVARCHAR(200)       NOT NULL,
    [GatewayID]     INT                 NOT NULL,
    [ObisKennzahl]  NVARCHAR(50)        NULL,
    CONSTRAINT [PK_Register_Gateway] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_RegGateway_Gateway] FOREIGN KEY ([GatewayID])
        REFERENCES [dbo].[Gateway]([ID])
);
GO

CREATE TABLE [dbo].[Register_Messdatenregistriergeraet] (
    [ID]                          INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]                 NVARCHAR(200)       NOT NULL,
    [MessdatenregistriergeraetID] INT                 NOT NULL,
    [ObisKennzahl]                NVARCHAR(50)        NULL,
    CONSTRAINT [PK_Register_MessdatenReg] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_RegMessdatenReg_MessdatenReg] FOREIGN KEY ([MessdatenregistriergeraetID])
        REFERENCES [dbo].[Messdatenregistriergeraet]([ID])
);
GO

CREATE TABLE [dbo].[Register_Mengenumwerter] (
    [ID]                INT IDENTITY(1,1)   NOT NULL,
    [Bezeichnung]       NVARCHAR(200)       NOT NULL,
    [MengenumwerterID]  INT                 NOT NULL,
    [ObisKennzahl]      NVARCHAR(50)        NULL,
    CONSTRAINT [PK_Register_Mengenumwerter] PRIMARY KEY CLUSTERED ([ID]),
    CONSTRAINT [FK_RegMengenumwerter_Mengenumwerter] FOREIGN KEY ([MengenumwerterID])
        REFERENCES [dbo].[Mengenumwerter]([ID])
);
GO

-- ============================================================================
-- UEBERSICHT ALLER TABELLEN (47 Stueck)
-- ============================================================================
-- NEU gegenueber v2.1:
--
-- Lookup-Tabellen (10 Stueck):
--   LK_Spannungsebene, LK_Lieferrichtung, LK_MesstechnischeEinordnung,
--   LK_Prognosegrundlage, LK_Verbrauchsart, LK_ArtErzeugendeMaLo,
--   LK_Veraeusserungsform, LK_MSBTyp, LK_Laendercode
--
-- Adress-/Kontakt-Tabellen (6 Stueck):
--   Adresse                  - Allgemeine Adressstruktur (Strasse, PLZ, Ort, Land)
--   Ansprechpartner          - Kontaktdaten (Tel, Fax, Mobil, E-Mail)
--   Marktteilnehmer          - Marktpartner mit MP-ID und Adresse
--   Kunde                    - Endkunde des Lieferanten
--   Korrespondenzadresse     - Kunden-Korrespondenzanschrift (oder MaLo-Adresse)
--   Kunde_Marktlokation      - Zuordnung Kunde <-> MaLo
--
-- Neue Entitaeten (2 Stueck):
--   Netzlokation             - Netzlokation mit NeLo-ID
--   Tranche                  - Tranche einer erzeugenden Marktlokation
--
-- Erweiterte Felder an bestehenden Tabellen:
--   Marktlokation            - +25 Felder (Lieferrichtung, Spannungsebene,
--                               Prognosegrundlage, JVP, Bilanzkreis, MSB, etc.)
--   Messlokation             - +5 Felder (Spannungsebene, Zaehlverfahren, etc.)
--   SteuerbareRessource      - +2 Felder (ext. ID, Fernsteuerbarkeit)
--   TechnischeRessource      - +1 Feld  (ext. ID)
--   Bilanzkreis              - +1 Feld  (BilanzkreisCode)
--   Bilanzierungsgebiet      - +1 Feld  (BilanzierungsgebietCode)
--   Regelzone                - +1 Feld  (EICCode)
--   Register_*               - +1 Feld  (ObisKennzahl) je Register-Tabelle
--   Zaehler                  - +1 Feld  (Zaehlernummer)
-- ============================================================================
