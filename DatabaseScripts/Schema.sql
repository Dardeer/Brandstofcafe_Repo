﻿-- Initialiseer de database
create database if not exists brandstofcafe;
use brandstofcafe;

﻿-- Secties-tabel: Groepeert tafels in secties
CREATE TABLE Secties (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Naam VARCHAR (50) NOT NULL
);

﻿﻿-- Tafels_Tabel: Vertegenwoordigt tafels in het cafe, gekoppeld aan Secties_tabel
create table Tafels (
	ID int auto_increment primary key,
	SectieID int not null,
	TafelNummer int not null,
	IsBezet boolean not null default false,
	unique (SectieID, TafelNummer),
	foreign key (SectieID) references Secties(ID) on delete restrict
	);

﻿-- Obers-tabel: Slaat obers op voor bonnetjes en bestelrondes
create table Obers (
ID int auto_increment primary key,
Naam varchar (100) not null
);

-- Categorieen-tabel: organiseert producten in een hierarchische structuur
create table Categorieen (
ID int auto_increment primary key,
    Naam varchar(50) not null,
    BovenCategorieID int null,
    foreign key (BovenCategorieID) references Categorieen(ID) on delete set null,
    unique (Naam, BovenCategorieID)		 -- Unieke combinatie: binnen dezelfde bovenlaag mag een naam niet dubbel zijn
);


-- Producten-tabel: Bevat menu-items van het café
create table Producten (
	ID int auto_increment primary key,
    Naam varchar(100) not null,
    Prijs decimal (5,2) not null,
    CategorieID int not null,
    foreign key (CategorieID) references Categorieen(ID) on delete restrict,
    UNIQUE (Naam, CategorieID) 			-- Niet dezelfde naam in dezelfde categorie, maar wel dezelfde naam in andere categorieën
);

-- AddOnGroep-tabel: Groepeert add-ons voor exclusieve keuzes (bijv. één melksoort)
create table AddOnGroep (
    ID int auto_increment primary key,
    Naam varchar(50) not null
);

-- AddOns-tabel: Extra opties voor producten, optioneel gekoppeld aan een groep
create table AddOns (
    ID int auto_increment primary key,
    Naam varchar(50) not null,
    Prijs decimal(5,2) not null,
    ProductID int not null,
    GroepID int null,
    foreign key (ProductID) references Producten(ID) on delete cascade,
    foreign key (GroepID) references AddOnGroep(ID) on delete set null
);

-- ProductPopulaireTijden-tabel: Koppelt producten aan populaire tijdsperiodes
create table ProductPopulaireTijden (
ID int auto_increment primary key,
ProductID int not null,
Tijdsperiode ENUM ('Ochtend', 'Middag', 'Avond') not null,
foreign key (ProductID) references Producten(ID) on delete cascade, -- Als een product wordt verwijderd, verdwijnen de gekoppelde tijdstippen automatisch.
unique (ProductID, Tijdsperiode)  -- Zorgt dat een product niet dubbel is voor dezelfde tijdsperiode
);

-- Bestelrondes-tabel: Groepeert bestellingen per tafel en ober
create table Bestelrondes (
ID int auto_increment primary key,
TafelID int not null,
OberID int not null,
Tijdstip datetime not null,
foreign key (TafelID) references Tafels(ID) on delete restrict,
foreign key (OberID) references Obers(ID) on delete restrict
);

-- Bestellingen-tabel: Bevat individuele bestellingen binnen een bestelronde
create table Bestellingen (
ID int auto_increment primary key,
BestelrondeID int not null,
ProductID int not null,
Aantal int not null check (Aantal > 0),
foreign key (BestelrondeID) references bestelrondes (id) on delete cascade,
foreign key (ProductID) references producten (id) on delete restrict
);


-- BestellingExemplaren-tabel: Vertegenwoordigt individuele exemplaren (kopjes) binnen een bestelling
create table BestellingExemplaren (
	ID int auto_increment primary key,
    BestellingID int not null,
    BestelrondeID int not null,
    ExemplaarNummer int not null,        -- Volgnummer van het item binnen een specifieke BestellingID (bijv. 1e of 2e Cappuccino)
    Status ENUM ('Besteld', 'WordtBereid', 'Bereid', 'Uitleveren') not null default 'Besteld',
    volgorde int not null,  			 -- UNIEK volgnummer binnen de HELE Bestelronde (voor het bonnetje)
    foreign key (BestellingID) references bestellingen(ID) on delete cascade,
    foreign key (BestelrondeID) references Bestelrondes(ID) on delete cascade,
    unique (BestellingID, ExemplaarNummer),
    unique (BestelrondeID, volgorde),
    check (ExemplaarNummer > 0),
    check (volgorde > 0)
); 

--  BestellingAddOns-tabel: Koppelt add-ons aan individuele exemplaren (kopjes)
create table BestellingAddons (
	ID int auto_increment primary key,
    BestellingExemplaarID int not null, 
    AddOnID int not null,
    foreign key (BestellingExemplaarID) references bestellingexemplaren (ID) on delete cascade,
    foreign key (AddOnID) references addons (id) on delete restrict,
    unique (BestellingExemplaarID, AddOnID)
);

-- !IsBetaald Kolom toevoegen aan BestellingExemplaren

Alter table bestellingexemplaren
add column IsBetaald boolean not null default false;   	-- De status indicator op BestellingExemplaren
														-- voor elk van de door de ober geselecteerde exemplaren (voltooide betaling), wordt IsBetaald gezet op TRUE.


-- Betalingen-tabel: Registreert de hoofdtransactie van een betaling.
create table Betalingen (
	id int auto_increment primary key,
    BestelrondeID int not null,
    OberID int not null, 								-- Welke ober de betaling heeft afgehandeld
    Tijdstip datetime not null,
    TotaalBetaaldBedrag decimal (8,2) not null, 	
    BetaalMethode varchar (50) not null,
    EmailBon varchar (255) null,
    foreign key (BestelrondeID) references Bestelrondes(id) on delete restrict,
    foreign key (OberID) references Obers(Id) on delete restrict
);

-- BestellingExemplaarBetalingen_tabel: Voor per persoon_betalingen en het bijhouden van de afgerekende status van individuele items.
create table BestellingExemplaarBetalingen (
	 ID int auto_increment primary key,
     BetalingID int not null,
     BestellingExemplaarID int not null,
     foreign key (BetalingID) references Betalingen (id) on delete cascade,
     foreign key (BestellingExemplaarID) references bestellingexemplaren(ID) on delete restrict,
     unique (BetalingID, BestellingExemplaarID)
);
                                                        
