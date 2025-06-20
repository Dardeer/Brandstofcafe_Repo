-- Initiële data voor Secties
insert into Secties (Naam) VALUES ('Binnen'), ('Buiten');

-- Initiële data voor Tafels
insert into Tafels (SectieID, TafelNummer, IsBezet) values
    (1, 1, FALSE),
    (1, 2, TRUE),
    (1, 3, FALSE),
    (1, 4, TRUE),
    (1, 5, FALSE),
    (1, 6, TRUE),
    (2, 1, FALSE),
    (2, 2, TRUE),
    (2, 3, FALSE),
    (2, 4, TRUE);

-- Initiële data voor Obers
insert into Obers (Naam) values
('Jan Bakker'),
('Emma Jansen');
		
-- Initiële data voor Categorieen
insert into Categorieen (Naam, BovenCategorieID) values
    ('Warme Dranken', NULL),  -- Id: 1 Hoofdcategorie
    ('Koffie', 1),            -- Id: 2 (Subcategorie van Warme dranken)
    ('Thee', 1),              -- Id: 3 (Subcategorie van Warme dranken)
    ('Koude Dranken', NULL),  -- Id: 4 Hoofdcategorie
    ('Frisdranken', 4),      -- Id: 5 (Subcategorie van Koude dranken)
    ('Alcohol', 4);           -- Id: 6 (Subcategorie van Koude dranken)

-- Initiële data voor Producten
insert into Producten (Naam, Prijs, CategorieID) values
-- Koffie (CategorieID: 2)
('Espresso', 2.50, (select ID from categorieen where Naam = 'Koffie')),
('Dubbele Espresso', 3.50, (select ID from categorieen where Naam = 'Koffie')),
('Cappuccino', 3.00, 2),
('Latte Macchiato', 3.50, 2),
('Americano', 2.75, 2),
('Chocolademelk', 3.00, 2),
('Cortado', 2.75, 2),
('Flat White', 3.25, 2),
-- Thee (CategorieID: 3)
('Earl Grey', 2.75, (select ID from categorieen where Naam = 'Thee')),
('Groene Thee', 2.75, 3),
('Matcha Thee', 3.50, 3),
('Gemberthee', 3.00, 3),
('Vruchtenthee', 2.75, 3),
-- Frisdranken (CategorieId: 5)
('Soda', 2.50, (select ID from categorieen where Naam = 'Frisdranken')),
('Iced Latte', 3.75, 5),
    ('Frappuccino', 4.00, 5),
    ('Iced Tea', 3.00, 5),
    ('Bubble Tea', 4.50, 5),
    ('Kokoswater', 3.00, 5),
    ('Water', 2.00, 5),
    ('Sinas', 2.50, 5),
    ('Aardbeiensap', 3.50, 5),
    ('Banaansap', 3.50, 5),
    ('Cola', 2.50, 5),
    ('Cola Zero', 2.50, 5),
    ('Limonade', 2.50, 5),
    -- Alcohol (CategorieId: 6)
    ('Guinness Bier', 4.50, (select ID from categorieen where Naam = 'Alcohol')),
    ('Heineken', 3.00, 6),
    ('Amstel', 3.00, 6);


-- Initiële data voor AddOnGroep
insert into AddOnGroep (Naam) values
    ('Melk'),
    ('Siroop'),
    ('Bubble Tea');

-- Initiële data voor AddOns
insert into AddOns (Naam, Prijs, ProductID, GroepID) values
    -- Cappuccino (ProductID: 3)
    ('Sojamelk', 0.75, 3, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Havermelk', 0.75, 3, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Amandelmelk', 0.80, 3, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Koemelk', 0.00, 3, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Zonder melk', 0.00, 3, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Slagroom', 0.50, 3, NULL),
    ('Karamelsiroop', 0.50, 3, (select ID from AddOnGroep WHERE Naam = 'Siroop')),
    ('Vanillesiroop', 0.50, 3, (select ID from AddOnGroep WHERE Naam = 'Siroop')),
    -- Latte Macchiato (ProductID: 4)
    ('Sojamelk', 0.75, 4, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Havermelk', 0.75, 4, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Amandelmelk', 0.80, 4, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Koemelk', 0.00, 4, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Zonder melk', 0.00, 4, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Slagroom', 0.50, 4, NULL),
    ('Karamelsiroop', 0.50, 4, (select ID from AddOnGroep WHERE Naam = 'Siroop')),
    ('Vanillesiroop', 0.50, 4, (select ID from AddOnGroep WHERE Naam = 'Siroop')),
    -- Flat White (ProductID: 8)
    ('Sojamelk', 0.75, 8, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Havermelk', 0.75, 8, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Amandelmelk', 0.80, 8, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Koemelk', 0.00, 8, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Zonder melk', 0.00, 8, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Slagroom', 0.50, 8, NULL),
    ('Karamelsiroop', 0.50, 8, (select ID from AddOnGroep WHERE Naam = 'Siroop')),
    ('Vanillesiroop', 0.50, 8, (select ID from AddOnGroep WHERE Naam = 'Siroop')),
    -- Cortado (ProductID: 7)
    ('Sojamelk', 0.75, 7, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Havermelk', 0.75, 7, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Koemelk', 0.00, 7, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Zonder melk', 0.00, 7, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    -- Chocolademelk (ProductID: 6)
    ('Sojamelk', 0.75, 6, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Havermelk', 0.75, 6, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Koemelk', 0.00, 6, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Zonder melk', 0.00, 6, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Slagroom', 0.50, 6, NULL),
    ('Karamelsiroop', 0.50, 6, (select ID from AddOnGroep WHERE Naam = 'Siroop')),
    ('Chocoladesiroop', 0.50, 6, (select ID from AddOnGroep WHERE Naam = 'Siroop')),
    -- Earl Grey (ProductID: 9)
    ('Honing', 0.50, 9, NULL),
    ('Citroen', 0.50, 9, NULL),
    ('Extra suiker', 0.00, 9, NULL),
    -- Groene Thee (ProductID: 10)
    ('Honing', 0.50, 10, NULL),
    ('Citroen', 0.50, 10, NULL),
    ('Extra suiker', 0.00, 10, NULL),
    -- Matcha Thee (ProductID: 11)
    ('Sojamelk', 0.75, 11, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Havermelk', 0.75, 11, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Koemelk', 0.00, 11, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Zonder melk', 0.00, 11, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Honing', 0.50, 11, NULL),
    ('Extra suiker', 0.00, 11, NULL),
    -- Gemberthee (ProductID: 12)
    ('Honing', 0.50, 12, NULL),
    ('Citroen', 0.50, 12, NULL),
    ('Extra suiker', 0.00, 12, NULL),
    -- Vruchtenthee (ProductID: 13)
    ('Honing', 0.50, 13, NULL),
    ('Citroen', 0.50, 13, NULL),
    ('Extra suiker', 0.00, 13, NULL),
    -- Iced Latte (ProductID: 15)
    ('Sojamelk', 0.75, 15, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Havermelk', 0.75, 15, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Amandelmelk', 0.80, 15, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Koemelk', 0.00, 15, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Zonder melk', 0.00, 15, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Slagroom', 0.50, 15, NULL),
    ('Karamelsiroop', 0.50, 15, (select ID from AddOnGroep WHERE Naam = 'Siroop')),
    ('Vanillesiroop', 0.50, 15, (select ID from AddOnGroep WHERE Naam = 'Siroop')),
    -- Frappuccino (ProductID: 16)
    ('Sojamelk', 0.75, 16, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Havermelk', 0.75, 16, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Amandelmelk', 0.80, 16, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Koemelk', 0.00, 16, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Zonder melk', 0.00, 16, (select ID from AddOnGroep WHERE Naam = 'Melk')),
    ('Slagroom', 0.50, 16, NULL),
    ('Karamelsiroop', 0.50, 16, (select ID from AddOnGroep WHERE Naam = 'Siroop')),
    ('Vanillesiroop', 0.50, 16, (select ID from AddOnGroep WHERE Naam = 'Siroop')),
    -- Iced Tea (ProductID: 17)
    ('Citroen', 0.50, 17, NULL),
    ('Honing', 0.50, 17, NULL),
    ('Extra suiker', 0.00, 17, NULL),
    -- Bubble Tea (ProductID: 18)
    ('Tapiocaparels', 1.00, 18, (select ID from AddOnGroep WHERE Naam = 'Bubble Tea')),
    ('Fruitjelly', 1.00, 18, (select ID from AddOnGroep WHERE Naam = 'Bubble Tea')),
    ('Mangosiroop', 0.50, 18, (select ID from AddOnGroep WHERE Naam = 'Siroop')),
    ('Aardbeisiroop', 0.50, 18, (select ID from AddOnGroep WHERE Naam = 'Siroop'));

-- Initiële data voor ProductPopulaireTijden
insert into ProductPopulaireTijden (ProductID, Tijdsperiode) values
    -- Ochtend: Koffies en Chocolademelk
    ((select ID from Producten where Naam = 'Cappuccino'), 'Ochtend'),
    ((select ID from Producten where Naam = 'Latte Macchiato'), 'Ochtend'),
    ((select ID from Producten where Naam = 'Flat White'), 'Ochtend'),
    ((select ID from Producten where Naam = 'Cortado'), 'Ochtend'),
    ((select ID from Producten where Naam = 'Chocolademelk'), 'Ochtend'),
    -- Middag: Theeën
    ((select ID from Producten where Naam = 'Earl Grey'), 'Middag'),
    ((select ID from Producten where Naam = 'Groene Thee'), 'Middag'),
    ((select ID from Producten where Naam = 'Matcha Thee'), 'Middag'),
    ((select ID from Producten where Naam = 'Gemberthee'), 'Middag'),
    ((select ID from Producten where Naam = 'Vruchtenthee'), 'Middag'),
    -- Avond: Bieren
    ((select ID from Producten where Naam = 'Guinness Bier'), 'Avond'),
    ((select ID from Producten where Naam = 'Heineken'), 'Avond'),
    ((select ID from Producten where Naam = 'Amstel'), 'Avond');

-- Initiële data voor Bestelrondes
insert into bestelrondes (TafelID, OberID, Tijdstip) values
((select id from tafels where SectieID = (select id from secties where naam = 'Binnen') and TafelNummer = 1),
(select id from obers where naam = 'Jan Bakker'), '2025-05-19 09:00:00'),
((select id from tafels where sectieid = (select id from secties where naam = 'Buiten') and tafelnummer = 2),
(select id from obers where naam ='Emma Jansen'), '2025-05-19 15:00:00'),
((select id from tafels where sectieid = (select id from secties where naam = 'Buiten') and TafelNummer = 3), 
(select id from obers where naam = 'Jan Bakker'), '2025-05-19 20:00:00');

-- Initiële data voor Bestellingen
insert into Bestellingen (bestelrondeID, ProductID, Aantal) values
-- Ochtendronde
(1, (select id from producten where naam = 'Cappuccino'), 2),
(1, (select id from producten where naam = 'Chocolademelk'), 1),

-- Middagronde
(2, (select id from producten where naam = 'Groene Thee'), 1),
(2, (select id from producten where naam = 'Matcha Thee'), 1),
-- Avondronde
(3, (select id from producten where naam = 'Heineken'), 2);
 
-- Ontbrekende Bestelling (Latte Macchiato) toevoegen
-- De ochtendronde (BestelrondeID=1) 
-- Ervoor zorgen dat Bestelronde ID en Product ID correct zijn!
insert into Bestellingen (BestelrondeID, ProductID, Aantal) values
(
	1, (select id from producten where naam = 'Latte Macchiato'), 2
);	


-- Initiële data voor BestellingExemplaren
insert into BestellingExemplaren 
(BestellingID, BestelrondeID, ExemplaarNummer, Status, volgorde) values
-- Bestelronde 1 (BestelrondeID = 1)  Ochtendronde
-- BestellingID 1: ProductID 3 (Cappuccino, Aantal = 2)
(1, 1, 1, 'Besteld', 1), 		--  Eerste item in hele ronde, 1e Cappuccion
(1, 1, 2, 'Besteld', 2),		-- Tweede item in hele ronde, 2e Cappucino
-- BestellingID 2: ProductID 6 (Chocolademelk, Aantal = 1)
(2, 1, 1, 'Besteld', 3 ), 		-- Derde item in hele ronde, 1e Chocolademelk
-- BestellingID 6: ProductID 4 (Latte Macchiato, Aantal = 2)
(6, 1, 1, 'Besteld', 4), 		-- Vierde item in hele ronde, 1e Latte Macchiato
(6, 1, 2, 'Besteld', 5), 		-- Vijfde item in hele ronde, 2e Latte Macchiato

-- Bestelronde 2 (BestelrondeID = 2) Middagronde
-- BestellingID 3 : ProductID 10 (Groene Thee, Aantal = 1)
(3, 2, 1, 'Besteld', 1), 		-- Eerst item in ronde 2

-- BestellingID 4: ProductID 11 (Matcha Thee, Aantal = 1)
(4, 2, 1, 'Besteld', 2), 		-- Tweede item in ronde 2

-- Bestelronde 3 (BestelrondeID = 3) Avondronde
-- BestellingID = 5: ProductID 28 (Heiniken, Aanta = 2)
(5, 3, 1, 'Besteld', 1), 		-- Eerste item in ronde 3
(5, 3, 2, 'Besteld', 2);	



-- Initiële data voor BestellingAddOns
insert into BestellingAddOns (BestellingExemplaarID, AddonID) values
(1, 6), 		-- ID_EXENUM_CAPP_1 = 1, ID_ADDON_SLAGROOM_CAPP_1 = 6 | ((SELECT ID FROM BestellingExemplaren WHERE BestellingID = 1 AND ExemplaarNummer = 1),
(2, 7),  		-- ID_EXENUM_CAPP_2 = 2, ID_ADDON_Karamelsiroop_CAPP_2 = 7
(3, 33), 		-- ID_EXENUM_CHOCOMELK_1 = 3, ID_ADDON_SLAGROOM_CHOCO_1 = 33
(4, 10),		-- ID_EXENUM_LATTE_1 = 4, ID_ADDON_HAVERMELK_LATTE_1 = 10
(5, 16);		-- ID_EXENUM_LATTE_2 = 5, ID_ADDON_HAVERMELK_Vanillesiroop_1 = 16

-- Initiële data voor Betalingen
-- Gast 1 betaalt 1e Cappuccino | INVOEGEN VOOR BETALING 1
insert into Betalingen (BestelrondeID, OberID, Tijdstip, TotaalBetaaldBedrag, Betaalmethode,EmailBon) values
(1, 1, '2025-05-25 10:00:00', 3.50, 'Pin', 'gast1@voorbeeld.nl');
-- EINDE VAN INVOEGEN VOOR BETALING 1.

-- Gast 2 betaalt 2e Cappuccino en Chocolademelk | INVOEGEN VOOR BETALING 2
insert into Betalingen (bestelrondeID, OberID, Tijdstip, TotaalBetaaldBedrag, BetaalMethode,EmailBon) values
(1, 1, '2025-05-25 10:15:00', 7.00, 'Contant', null);
-- EINDE VAN INVOEGEN VOOR BETALING 2

-- Bedrijf betaalt 2 Latte Macchiato's (Op Rekening) | INVOEGEN VOOR BETALING 3
insert into Betalingen (bestelrondeID, OberID, Tijdstip, TotaalBetaaldBedrag, BetaalMethode,EmailBon) values
(1, 1, '2025-05-25 10:30:00', 8.25, 'Op Rekening', 'finance@bedrijf.nl');
-- EINDE VAN INVOEGEN VOOR BETALING 3

-- Initiële data voor BestellingExemplaarBetalingen
-- START 1e CAPP_Betaling
insert into BestellingExemplaarBetalingen (BetalingID, BestellingExemplaarID) values (1 , 1); -- (BETALING_ID_GAST1, ID_EXEMP_CAPP_1)

UPDATE BestellingExemplaren
SET IsBetaald = TRUE
WHERE Id = 1;  			-- ID_EXEMP_CAPP_1 
-- EIND 1e CAPP IsBetaald

-- START 2e Cappuccino en Chocolademelk Betaling
insert into BestellingExemplaarBetalingen (BetalingID, BestellingExemplaarID) values 
(2 , 2),  		-- (BETALING_ID_GAST2, ID_EXEMP_CAPP_2)
(2, 3);  		-- (BETALING_ID_GAST2, ID_EXEMP_CHOCO_1)

UPDATE BestellingExemplaren
SET IsBetaald = TRUE
WHERE Id IN (2, 3); 		-- (ID_EXEMP_CAPP_2, ID_EXEMP_CHOCO_1 )  	
-- EIND 2e Cappuccino en Chocolademelk IsBetaald

-- START  2 Latte Macchiato's Betaling
insert into BestellingExemplaarBetalingen (BetalingID, BestellingExemplaarID) values
(3 , 4),  		-- (BETALING_ID_Bedrijf, ID_EXEMP_LATTE_1)
(3, 5);  		-- (BETALING_ID_Bedrijf, ID_EXEMP_LATTE_2)


UPDATE BestellingExemplaren
SET IsBetaald = TRUE
WHERE Id IN (4, 5);
-- EIND 2 Latte Macchiato's IsBetaald

-- Initiële data voor Orders
create table Orders (
ID int not null auto_increment primary key,
TafelID int not null,
BestelDatum timestamp default current_timestamp,
TotaalPrijs decimal(10, 2) not null default 0.00,
Status varchar(50) not null default 'Open',
foreign key (TafelID) references tafels(ID)
);

-- Initiële data voor OrderItem
create table OrderItems (
ID int auto_increment primary key,
OrderID int not null,
ProductID int not null,
ProductName varchar(255) not null,
ProductPrijs Decimal(10, 2) not null,
Quantity int not null,
foreign key (OrderID) references Orders(ID),
foreign key (ProductID) references Producten(ID)
);

-- Initiële data voor OrderItemAddOns
create table OrderItemAddOns (
Id int auto_increment primary key,
OrderItemID int not null,
AddOnID int not null,
AddOnName varchar(255) not null,
AddOnPrijs Decimal (10, 2) not null,
foreign key (OrderItemID) references orderitems(ID),
foreign key (AddOnID) references AddOns(ID)
)
