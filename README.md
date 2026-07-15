# NHL_Brandstofcafe
Database ontwerpen die sluit aan bij het process en de wensen van de klant
Statische website gemaakt met HTML/CSS/Bootsrap en C# voor Backend, werkt op verschillende schermgrottes
# Opdracht Omschrijving
Een ober komt aan een tafel in het Brandstofcafé. Deze neemt de bestelling op van de producten. Dit kan meerdere keren gebeuren (bestelrondes). Het café heeft meerdere tafels, in verschillende delen (secties, b.v. binnen, buiten, etc). 

Bestelronde opnemen
Een product behoort tot een categorie (eventueel meerdere lagen diep, b.v. warme dranken -> koffie of thee -> latte macchiato). Tip: bekijk de menukaart eens!
Deze categorisering is handig voor het gemakkelijk kunnen vinden van producten. Ook is het fijn als er naar producten gezocht kan worden op naam, en dat de meest bestelde producten snel te vinden zijn. (Het zou wel heel mooi zijn dat in de ochtend de koffie bovenaan staat en ‘s middags de thee of aan het begin van de avond de biertjes.) 
Een product wordt geselecteerd voor een bestelling en wordt toegevoegd aan het besteloverzicht (van deze bestelronde). Een product kan een extra add-ons hebben (soja, havermelk, karamelsmaakje, slagroom, etc.). Van deze add-ons kunnen soms meerder gekozen worden, soms per groep 1 keuze (soja, haver, koe, geen melk). De ober moet erop geattendeerd worden bij het selecteren van bv. chocolademelk dat er slagroom bij kan zodat de ober dit aan de klant kan vragen. 

Bereiden en Uitleveren 
Als een bestelronde klaar is, gaat het proces een stap verder. De producten worden bereid (status gaat dan van bestelling naar bereid). De ober moet een overzicht hebben van welke bestellingen zijn gedaan zodat deze kunnen worden overgenomen in het ICT-systeem van het café.
Als de producten klaar zijn moeten deze worden uitgeleverd aan tafel (status gaat dan van bereid naar uitleveren). Per bestelling wordt er een bonnetje uitgedraaid van de bestelronde, zodat de ober weet naar welke tafel de producten moeten en welke producten gereed zijn voor uitlevering. Deze staan in volgorde van bestellen zodat bij het uitleveren van de producten aan de tafel de ober niet hoeft te vragen voor wie welke bestelling is (de ober neem namelijk in een vaste volgorde de bestelling op). 
Een tafel kan meerdere bestelrondes doorlopen.

Betalen
Tussendoor of aan het eind kan er betaald worden. Als er betaald moeten worden moet er een overzichtelijk overzicht getoond kunnen worden aan de ober en de klanten.
Er kan per persoon worden betaald, dan wordt er verteld aan de ober hoeveel producten een gast heeft genuttigd en de ober past dit aan in het overzicht en verteld uiteindelijk de prijs. Na het afreken kan de klant een overzicht zien met de genuttigde producten.
Soms wordt er ook voor gekozen om alles in 1 keer te betalen. Dan moet er nog de mogelijkheid zijn om eventueel te betalen op kostenplaatsnummer. Ook hiervoor moet de gast na betalen een overzicht kunnen krijgen. Op de bonnetjes staat ook de naam van de ober die geholpen heeft. Trouwens de bonnetjes mag de klant op het scherm zien van de ober, echter een afdruk krijgen is lastig (kost bomen), dus kan de ober de bon mailen. 

Ober
Een ober logt in om vervolgens bestellingen te kunnen opnemen. Een ober selecteert natuurlijk de tafel, daarna wordt daarvoor de bestelling opgenomen.
Als de dienst van een ober stopt logt hij uit. 

