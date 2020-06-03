--CREATE TABLE---------------------------------------------------------

CREATE TABLE Seance (
  codeSeance int PRIMARY KEY,
  jour DATE NOT NULL,
  heureDebut int NOT NULL,
  duree int NOT NULL,
  placeOccupees int NOT NULL,
  placeVendues int NOT NULL,
  CONSTRAINT check_heureDebut CHECK (heureDebut <= 2359 AND heureDebut>= 0),
  CONSTRAINT check_duree CHECK (duree > 0),
  CONSTRAINT check_placeOccupees CHECK (placeOccupees > 0),
  CONSTRAINT check_Vendeur CHECK (placeVendues > 0)
)

CREATE TABLE Client(
  idClient int PRIMARY KEY,
  nom varchar NOT NULL,
  prenom varchar NOT NULL,
  dateNaissance DATE NOT NULL,
  ageClient = DATEDIFF(year, dateNaissance, CURDATE()),
  CONSTRAINT check_dateNaissance CHECK (dateNaissance <= now())
)

CREATE TABLE Film(
  codeFilm int PRIMARY KEY,
  titre varchar NOT NULL,
  dateSortie DATE NOT NULL,
  ageLimit int NOT NULL,
  CONSTRAINT check_dateSortie CHECK (dateSortie <= now()),
  CONSTRAINT check_ageLimit CHECK (ageLimit > 0)
)

----------------------------------------------------------------------------------------------------
CREATE TABLE Distributeur(
  idDistributeur int PRIMARY KEY,
  nom varchar NOT NULL
)

CREATE TABLE Relisateur(
  idRealisateur int PRIMARY KEY,
  nom varchar NOT NULL,
  prenom varchar NOT NULL
)

CREATE TABLE Producteur(
  idProducteur int PRIMARY KEY,
  nom varchar NOT NULL,
  prenom varchar NOT NULL
)

CREATE TABLE Genre(
  idGenre int PRIMARY KEY,
  type varchar NOT NULL
)

CREATE TABLE gérant(
  idDistributeur int NOT NULL,
  codeFilm int NOT NULL,
  PRIMARY KEY(idDistributeur, codeFilm),
  CONSTRAINT fk_gérant FOREIGN KEY (idDistributeur) REFERENCES Distributeur(idDistributeur),
  CONSTRAINT fk_gérant FOREIGN KEY (codeFilm) REFERENCES Film(codeFilm)
)

CREATE TABLE participé(
  idRealisateur int NOT NULL,
  codeFilm int NOT NULL,
  PRIMARY KEY(idRealisateur, codeFilm),
  CONSTRAINT fk_participé FOREIGN KEY (idRealisateur) REFERENCES Relisateur(idRealisateur),
  CONSTRAINT fk_participé FOREIGN KEY (codeFilm) REFERENCES Film(codeFilm)
)

CREATE TABLE crée(
  idProducteur int NOT NULL,
  codeFilm int NOT NULL,
  PRIMARY KEY(idProducteur, codeFilm),
  CONSTRAINT fk_crée FOREIGN KEY (idProducteur) REFERENCES Producteur(idProducteur),
  CONSTRAINT fk_crée FOREIGN KEY (codeFilm) REFERENCES Film(codeFilm)
)

CREATE TABLE comprises(
  idGenre int NOT NULL,
  codeFilm int NOT NULL,
  PRIMARY KEY(idGenre, codeFilm),
  CONSTRAINT fk_comprises FOREIGN KEY (idGenre) REFERENCES Genre(idGenre),
  CONSTRAINT fk_comprises FOREIGN KEY (codeFilm) REFERENCES Film(codeFilm)
)

------------------------------------------------------------------------------------------------------
CREATE TABLE Salle(
  idSalle int PRIMARY KEY,
  nombre varchar NOT NULL,
  capacite int NOT NULL,
  CONSTRAINT check_capacite CHECK (capacite > 0)
)

CREATE TABLE projetedans(
  idSalle int NOT NULL,
  codeSeance int NOT NULL,
  PRIMARY KEY(idSalle, codeSeance),
  CONSTRAINT fk_projetedans FOREIGN KEY (idSalle) REFERENCES Salle(idSalle),
  CONSTRAINT fk_projetedans FOREIGN KEY (codeSeance) REFERENCES Seance(codeSeance)
)

-------------------------------------------------------------------------------------------------------
CREATE TABLE Projection(
  idProjection int PRIMARY KEY,
  codeFilm int NOT NULL,
  doublage varchar NOT NULL,
  CONSTRAINT fk_Projection FOREIGN KEY (codeFilm) REFERENCES Film(codeFilm),
  CONSTRAINT check_doublage CHECK (doublage IN ('VF', 'VOST'))
)

CREATE TABLE projecter(
  codeSeance int NOT NULL,
  idProjection int NOT NULL,
  PRIMARY KEY(codeSeance, idProjection),
  CONSTRAINT fk_projecter FOREIGN KEY (codeSeance) REFERENCES Seance(codeSeance),
  CONSTRAINT fk_projecter FOREIGN KEY (idProjection) REFERENCES Projection(idProjection)
)

------------------------------------------------------------------------------------------------
CREATE TABLE Vendeur(
  idVendeur int PRIMARY KEY,
  nom varchar NOT NULL,
  prenom varchar NOT NULL
)

--------------------------------------------------------------------------------------------
CREATE TABLE Entree(
  #codeticket int PRIMARY KEY,
  idVendeur int NOT NULL,
  idClient int NOT NULL,
  codeSeance int NOT NULL,
  CONSTRAINT fk_Entree FOREIGN KEY (idVendeur) REFERENCES Vendeur(idVendeur),
  CONSTRAINT fk_Entree FOREIGN KEY (idClient) REFERENCES Client(idClient),
  CONSTRAINT fk_Entree FOREIGN KEY (codeSeance) REFERENCES Seance(codeSeance)
)

CREATE TABLE ticketCatre(
  codeticket int NOT NULL,
  PRIMARY KEY(codeticket),
  CONSTRAINT fk_ticketCatre FOREIGN KEY (codeticket) REFERENCES Entree(codeticket)
)

CREATE TABLE ticketUnitaire(
  codeticket int NOT NULL,
  typeTarif varchar NOT NULL,
  PRIMARY KEY(codeticket),
  CONSTRAINT fk_ticketUnitaire FOREIGN KEY (codeticket) REFERENCES Entree(codeticket),
  CONSTRAINT check_typeTarif CHECK (typeTarif IN {'Adulte','Etudiant','Enfant','Dimanche'})
)

-----------------------------------------------------------------------------------------------------
CREATE TABLE Abonnement(
  idAbonnement int PRIMARY KEY,
  idClient int NOT NULL,
  idVendeur int NOT NULL,
  placeEncore int NOT NULL,
  CONSTRAINT check_placeEncore CHECK (placeEncore > 0),
  CONSTRAINT fk_Abonnement FOREIGN KEY (idClient) REFERENCES Client(idClient),
  CONSTRAINT fk_Abonnement FOREIGN KEY (idVendeur) REFERENCES Vendeur(idVendeur)
)

CREATE TABLE produit(
  idproduit int PRIMARY KEY
)

CREATE TABLE boisson(
  idproduit int NOT NULL,
  nomboisson varchar NOT NULL,
  tarifboisson int NOT NULL,
  PRIMARY KEY(idproduit),
  CONSTRAINT check_tarifboisson CHECK (tarifboisson >0),
  CONSTRAINT fk_boisson FOREIGN KEY (idproduit) REFERENCES produit(idproduit)
)

CREATE TABLE alimentaire(
  idproduit int NOT NULL,
  nomalimentaire varchar NOT NULL,
  tarifalimentaire int NOT NULL,
  PRIMARY KEY(idproduit),
  CONSTRAINT check_tarifalimentaire CHECK (tarifalimentaire > 0),
  CONSTRAINT fk_alimentaire FOREIGN KEY (idproduit) REFERENCES produit(idproduit)
)

--------------------------------------------------------------------------------------------------
CREATE TABLE vendre(
  idVendeur int NOT NULL,
  idproduit int NOT NULL,
  PRIMARY KEY(idVendeur, idproduit),
  CONSTRAINT fk_vendre FOREIGN KEY (idVendeur) REFERENCES Vendeur(idVendeur),
  CONSTRAINT fk_vendre FOREIGN KEY (idproduit) REFERENCES produit(idproduit)
)

CREATE TABLE payer(
  idproduit int NOT NULL,
  idClient int NOT NULL,
  quantité int NOT NULL,
  PRIMARY KEY(idproduit, idClient),
  CONSTRAINT check_payer CHECK (quantité >0),
  CONSTRAINT fk_payer FOREIGN KEY (idproduit) REFERENCES produit(idproduit),
  CONSTRAINT fk_payer FOREIGN KEY (idClient) REFERENCES Client(idClient)
)

CREATE TABLE donne(
  idAbonnement int NOT NULL,
  idVendeur int NOT NULL,
  PRIMARY KEY(idAbonnement,idVendeur),
  CONSTRAINT fk_donne FOREIGN KEY (idAbonnement) REFERENCES Abonnement(idAbonnement),
  CONSTRAINT fk_donne FOREIGN KEY (idVendeur) REFERENCES Vendeur(idVendeur)
)

---------------------------------------------------------------------------------------------

CREATE TABLE Noter(
  idClient int NOT NULL,
  codeFilm int NOT NULL,
  value int,
  PRIMARY KEY(idClient, codeFilm),
  CONSTRAINT check_value CHECK (value >=0 AND value <=5),
  CONSTRAINT fk_Noter FOREIGN KEY (idClient) REFERENCES Client(idClient),
  CONSTRAINT fk_Noter FOREIGN KEY (codeFilm) REFERENCES Film(codeFilm)
)

--INSERT ----------------------------------------------------------------------------------

--Film--

INSERT INTO Film (code, titre, dateSortie, ageLimit) VALUES (12341, 'Iron Man', '2008-05-02', 5);
INSERT INTO Film (code, titre, dateSortie, ageLimit) VALUES (12342, 'The Incredible Hulk', '2008-06-13', 5);
INSERT INTO Film (code, titre, dateSortie, ageLimit) VALUES (12343, 'Iron Man 2', '2010-05-07', 5);
INSERT INTO Film (code, titre, dateSortie, ageLimit) VALUES (12344, 'The Conjuring', '2013-08-21', 13);
INSERT INTO Film (code, titre, dateSortie, ageLimit) VALUES (12345, 'The Conjuring 2', '2016-06-29', 13);
INSERT INTO Film (code, titre, dateSortie, ageLimit) VALUES (12346, 'Annabelle', '2014-10-08', 13);
INSERT INTO Film (code, titre, dateSortie, ageLimit) VALUES (12347, 'Fifty Shades of Grey', '2015-02-11', 15);
INSERT INTO Film (code, titre, dateSortie, ageLimit) VALUES (12348, 'Toy Story 4', '2019-06-26', 5);
INSERT INTO Film (code, titre, dateSortie, ageLimit) VALUES (12349, 'Doraemon: Nobitas New Dinosaur', '2020-08-07', 5);
INSERT INTO Film (code, titre, dateSortie, ageLimit) VALUES (12340, 'Avengers: Endgame', '2019-04-24', 5);


--Eléments liés au film part 1--

INSERT INTO Distributeur (idDistributeur, nom) VALUES (22341, 'Paramount Pictures');
INSERT INTO Distributeur (idDistributeur, nom) VALUES (22343, 'Warner Bros. Pictures');
INSERT INTO Distributeur (idDistributeur, nom) VALUES (22344, 'Universal Pictures');
INSERT INTO Distributeur (idDistributeur, nom) VALUES (22345, 'Walt Disney Studios Motion Pictures');
INSERT INTO Distributeur (idDistributeur, nom) VALUES (22346, 'Toho Co. Ltd');

INSERT INTO Realisateur (idRealisateur, nom, prenom) VALUES(42341,'Favreau','Jon');
INSERT INTO Realisateur (idRealisateur, nom, prenom) VALUES(42342,'Leterrier','Louis');
INSERT INTO Realisateur (idRealisateur, nom, prenom) VALUES(42343,'Wan','James');
INSERT INTO Realisateur (idRealisateur, nom, prenom) VALUES(42344,'Chaves','Michael');
INSERT INTO Realisateur (idRealisateur, nom, prenom) VALUES(42345,'Leonetti','John Robert');
INSERT INTO Realisateur (idRealisateur, nom, prenom) VALUES(42346,'Taylor-Johnson','Sam');
INSERT INTO Realisateur (idRealisateur, nom, prenom) VALUES(42347,'Foley','James');
INSERT INTO Realisateur (idRealisateur, nom, prenom) VALUES(42348,'Cooley','Josh');
INSERT INTO Realisateur (idRealisateur, nom, prenom) VALUES(42349,'Kazuaki','Imai');
INSERT INTO Realisateur (idRealisateur, nom, prenom) VALUES(42340,'Russo','Joe');
INSERT INTO Realisateur (idRealisateur, nom, prenom) VALUES(42350,'Russo','Anthony');

INSERT INTO Producteur (idProducteur, nom, prenom) VALUES (32341, 'Feige' 'Kevin');
INSERT INTO Producteur (idProducteur, nom, prenom) VALUES (32342, 'Arad' 'Avi');
INSERT INTO Producteur (idProducteur, nom, prenom) VALUES (32343, 'Lee' 'Stan');
INSERT INTO Producteur (idProducteur, nom, prenom) VALUES (32344, 'Tyler' 'Liv');
INSERT INTO Producteur (idProducteur, nom, prenom) VALUES (32345, 'Safran' 'Peter');
INSERT INTO Producteur (idProducteur, nom, prenom) VALUES (32346, 'Cowan' 'Rob');
INSERT INTO Producteur (idProducteur, nom, prenom) VALUES (32347, 'James' 'E.L');
INSERT INTO Producteur (idProducteur, nom, prenom) VALUES (32348, 'Lasseter' 'John');
INSERT INTO Producteur (idProducteur, nom, prenom) VALUES (32349, 'Rivera' 'Jonas');
INSERT INTO Producteur (idProducteur, nom, prenom) VALUES (32340, 'Genki' 'Kawamura');



INSERT INTO Genre (idGenre, type) VALUES (1, 'acte');
INSERT INTO Genre (idGenre, type) VALUES (2, 'fiction');
INSERT INTO Genre (idGenre, type) VALUES (3, 'horreur');
INSERT INTO Genre (idGenre, type) VALUES (4, 'dessin animé');
INSERT INTO Genre (idGenre, type) VALUES (5, 'affection');
INSERT INTO Genre (idGenre, type) VALUES (6, 'Super héros');
INSERT INTO Genre (idGenre, type) VALUES (7, 'amusement');

--Eléments liés au film part 2--

INSERT INTO gérant (idDistributeur,codeFilm) VALUES (22341,12341);
INSERT INTO gérant (idDistributeur,codeFilm) VALUES (22341,12342);
INSERT INTO gérant (idDistributeur,codeFilm) VALUES (22341,12343);
INSERT INTO gérant (idDistributeur,codeFilm) VALUES (22341,12340);
INSERT INTO gérant (idDistributeur,codeFilm) VALUES (22343,12344);
INSERT INTO gérant (idDistributeur,codeFilm) VALUES (22343,12345);
INSERT INTO gérant (idDistributeur,codeFilm) VALUES (22343,12346);
INSERT INTO gérant (idDistributeur,codeFilm) VALUES (22344,12347);
INSERT INTO gérant (idDistributeur,codeFilm) VALUES (22345,12348);
INSERT INTO gérant (idDistributeur,codeFilm) VALUES (22346,12349);

INSERT INTO participé(idRealisateur, codeFilm) VALUES(42341,12341);
INSERT INTO participé(idRealisateur, codeFilm) VALUES(42342,12342);
INSERT INTO participé(idRealisateur, codeFilm) VALUES(42341,12343);
INSERT INTO participé(idRealisateur, codeFilm) VALUES(42343,12344);
INSERT INTO participé(idRealisateur, codeFilm) VALUES(42343,12345);
INSERT INTO participé(idRealisateur, codeFilm) VALUES(42344,12344);
INSERT INTO participé(idRealisateur, codeFilm) VALUES(42345,12346);
INSERT INTO participé(idRealisateur, codeFilm) VALUES(42346,12347);
INSERT INTO participé(idRealisateur, codeFilm) VALUES(42347,12347);
INSERT INTO participé(idRealisateur, codeFilm) VALUES(42348,12348);
INSERT INTO participé(idRealisateur, codeFilm) VALUES(42349,12349);
INSERT INTO participé(idRealisateur, codeFilm) VALUES(42340,12340);
INSERT INTO participé(idRealisateur, codeFilm) VALUES(42350,12340);

INSERT INTO crée(idProducteur, codeFilm) VALUES (32341,12341);
INSERT INTO crée(idProducteur, codeFilm) VALUES (32342,12342);
INSERT INTO crée(idProducteur, codeFilm) VALUES (32343,12341);
INSERT INTO crée(idProducteur, codeFilm) VALUES (32343,12342);
INSERT INTO crée(idProducteur, codeFilm) VALUES (32343,12343);
INSERT INTO crée(idProducteur, codeFilm) VALUES (32344,12340);
INSERT INTO crée(idProducteur, codeFilm) VALUES (32345,12344);
INSERT INTO crée(idProducteur, codeFilm) VALUES (32346,12345);
INSERT INTO crée(idProducteur, codeFilm) VALUES (32346,12346);
INSERT INTO crée(idProducteur, codeFilm) VALUES (32347,12347);
INSERT INTO crée(idProducteur, codeFilm) VALUES (32348,12348);
INSERT INTO crée(idProducteur, codeFilm) VALUES (32349,12348);
INSERT INTO crée(idProducteur, codeFilm) VALUES (32340,12349);

INSERT INTO comprises(idGenre, codeFilm) VALUES (1,12341);
INSERT INTO comprises(idGenre, codeFilm) VALUES (2,12341);
INSERT INTO comprises(idGenre, codeFilm) VALUES (6,12341);
INSERT INTO comprises(idGenre, codeFilm) VALUES (1,12342);
INSERT INTO comprises(idGenre, codeFilm) VALUES (2,12342);
INSERT INTO comprises(idGenre, codeFilm) VALUES (6,12342);
INSERT INTO comprises(idGenre, codeFilm) VALUES (1,12343);
INSERT INTO comprises(idGenre, codeFilm) VALUES (2,12343);
INSERT INTO comprises(idGenre, codeFilm) VALUES (6,12343);
INSERT INTO comprises(idGenre, codeFilm) VALUES (2,12344);
INSERT INTO comprises(idGenre, codeFilm) VALUES (3,12344);
INSERT INTO comprises(idGenre, codeFilm) VALUES (2,12345);
INSERT INTO comprises(idGenre, codeFilm) VALUES (3,12345);
INSERT INTO comprises(idGenre, codeFilm) VALUES (2,12346);
INSERT INTO comprises(idGenre, codeFilm) VALUES (3,12346);
INSERT INTO comprises(idGenre, codeFilm) VALUES (5,12347);
INSERT INTO comprises(idGenre, codeFilm) VALUES (4,12348);
INSERT INTO comprises(idGenre, codeFilm) VALUES (4,12349);
INSERT INTO comprises(idGenre, codeFilm) VALUES (1,12340);
INSERT INTO comprises(idGenre, codeFilm) VALUES (2,12340);
INSERT INTO comprises(idGenre, codeFilm) VALUES (6,12340);


----Client--
INSERT INTO Client(idClient, nom, prenom, dateNaissance) VALUES (11111,'Ho','XuanVinh','2000-01-01');
INSERT INTO Client(idClient, nom, prenom, dateNaissance) VALUES (22222,'Kevin','Gousse','2001-02-03');
INSERT INTO Client(idClient, nom, prenom, dateNaissance) VALUES (33333,'Alain','Anne','1999-10-30');
INSERT INTO Client(idClient, nom, prenom, dateNaissance) VALUES (44444,'Masson','Sam','2004-12-27');
INSERT INTO Client(idClient, nom, prenom, dateNaissance) VALUES (55555,'David','Melodie','1980-04-15');
INSERT INTO Client(idClient, nom, prenom, dateNaissance) VALUES (66666,'Descoteaux','Pro','2006-05-22');
INSERT INTO Client(idClient, nom, prenom, dateNaissance) VALUES (77777,'Devoe','Jack','1999-09-07');
INSERT INTO Client(idClient, nom, prenom, dateNaissance) VALUES (88888,'Hubert','Hubert','2000-08-18');
INSERT INTO Client(idClient, nom, prenom, dateNaissance) VALUES (99999,'Nguyen','LeLyBang','2013-03-06');
INSERT INTO Client(idClient, nom, prenom, dateNaissance) VALUES (11011,'Nguyen','GiaHoa','2010-07-21');
INSERT INTO Client(idClient, nom, prenom, dateNaissance) VALUES (22022,'Le','TuHoNguyen','2010-06-22');
INSERT INTO Client(idClient, nom, prenom, dateNaissance) VALUES (33033,'Hirasawa','Yui','1991-11-27');


---Seance--

INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (10000,'2020-06-01',0800,85,10,2);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (20000,'2020-05-30',1000,95,10,1);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (30000,'2020-01-01',0800,115,10,2);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (40000,'2020-02-21',0800,120,10,3);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (50000,'2020-03-01',1600,180,10,4);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (60000,'2020-04-01',1000,120,10,10);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (70000,'2019-06-01',2300,120,10,6);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (80000,'2019-06-07',1400,95,10,2);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (90000,'2019-12-25',1600,115,10,5);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (11000,'2019-02-14',1700,115,10,5);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (12000,'2019-11-20',1400,115,10,3);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (13000,'2019-10-20',2300,95,10,7);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (14000,'2019-08-03',2100,85,10,3);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (15000,'2019-09-27',1700,85,10,9);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (16000,'2019-12-25',2100,120,10,5);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (17000,'2019-01-31',2300,115,10,8);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (18000,'2019-02-19',1400,120,10,9);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (19000,'2019-06-23',1400,95,10,1);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues) VALUES (21000,'2019-03-08',1200,180,10,4);


--Salle--

INSERT INTO Salle(idSalle, nombre, capacite) VALUES (100,'A100',100,);
INSERT INTO Salle(idSalle, nombre, capacite) VALUES (200,'A200',100,);
INSERT INTO Salle(idSalle, nombre, capacite) VALUES (300,'A300',50,);
INSERT INTO Salle(idSalle, nombre, capacite) VALUES (400,'B400',150,);
INSERT INTO Salle(idSalle, nombre, capacite) VALUES (500,'B500',200,);

--Projection

INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (1,12341,'VF');
INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (2,12341,'VOST');
INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (3,12342,'VF');
INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (4,12343,'VF');
INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (5,12343,'VOST');
INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (6,12344,'VOST');
INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (7,12345,'VF');
INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (8,12346,'VF');
INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (9,12346,'VOST');
INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (10,12347,'VF');
INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (11,12347,'VOST');
INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (12,12348,'VF');
INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (13,12349,'VF');
INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (14,12340,'VF');
INSERT INTO Projection(idProjection, codeFilm, doublage) VALUES (15,12340,'VOST');


INSERT INTO projetedans(idSalle, codeSeance) VALUES (100,10000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (100,20000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (200,30000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (200,40000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (300,50000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (400,60000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (400,70000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (400,80000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (500,90000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (100,11000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (400,12000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (200,13000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (500,14000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (100,15000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (300,16000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (500,17000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (400,18000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (200,19000);
INSERT INTO projetedans(idSalle, codeSeance) VALUES (500,21000);

INSERT INTO projecter(codeSeance, idProjection) VALUES (10000,1);
INSERT INTO projecter(codeSeance, idProjection) VALUES (20000,1);
INSERT INTO projecter(codeSeance, idProjection) VALUES (30000,2);
INSERT INTO projecter(codeSeance, idProjection) VALUES (40000,3);
INSERT INTO projecter(codeSeance, idProjection) VALUES (50000,4);
INSERT INTO projecter(codeSeance, idProjection) VALUES (60000,5);
INSERT INTO projecter(codeSeance, idProjection) VALUES (70000,6);
INSERT INTO projecter(codeSeance, idProjection) VALUES (80000,7);
INSERT INTO projecter(codeSeance, idProjection) VALUES (90000,8);
INSERT INTO projecter(codeSeance, idProjection) VALUES (11000,9);
INSERT INTO projecter(codeSeance, idProjection) VALUES (12000,10);
INSERT INTO projecter(codeSeance, idProjection) VALUES (13000,11);
INSERT INTO projecter(codeSeance, idProjection) VALUES (14000,12);
INSERT INTO projecter(codeSeance, idProjection) VALUES (15000,12);
INSERT INTO projecter(codeSeance, idProjection) VALUES (16000,13);
INSERT INTO projecter(codeSeance, idProjection) VALUES (17000,14);
INSERT INTO projecter(codeSeance, idProjection) VALUES (18000,15);
INSERT INTO projecter(codeSeance, idProjection) VALUES (19000,15);
INSERT INTO projecter(codeSeance, idProjection) VALUES (21000,15);


--Vendeur--


INSERT INTO Vendeur(idVendeur, nom, prenom) VALUES (51,'Jamal','Forster');
INSERT INTO Vendeur(idVendeur, nom, prenom) VALUES (52,'Rianne','Duggan');
INSERT INTO Vendeur(idVendeur, nom, prenom) VALUES (53,'Yukinoshita','Yukino');
INSERT INTO Vendeur(idVendeur, nom, prenom) VALUES (54,'Dan','Flynn');
INSERT INTO Vendeur(idVendeur, nom, prenom) VALUES (55,'Ahmad','Callum');

--Abonnement et donne--

INSERT INTO Abonnement(idAbonnement, idClient, idVendeur, placeEncore) VALUES (10801091, 11111, 51, 20);
INSERT INTO Abonnement(idAbonnement, idClient, idVendeur, placeEncore) VALUES (10801092, 33033, 52, 30);
INSERT INTO Abonnement(idAbonnement, idClient, idVendeur, placeEncore) VALUES (10801093, 22222, 55, 1);

INSERT INTO donne(idAbonnement, idVendeur) VALUES (18001091,51);
INSERT INTO donne(idAbonnement, idVendeur) VALUES (18001092,51);
INSERT INTO donne(idAbonnement, idVendeur) VALUES (18001093,53);

--Entree--

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100001,51,11111,10000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100002,51,22222,10000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100003,52,33333,20000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100004,53,77777,30000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100005,53,88888,30000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100006,54,11011,40000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100007,54,22022,40000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100008,54,11111,40000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100009,55,44444,50000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100010,55,55555,50000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100011,55,66666,50000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100012,55,99999,50000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100013,51,11111,60000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100014,51,22222,60000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100015,51,33333,60000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100016,51,77777,60000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100017,51,88888,60000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100018,51,99999,60000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100019,51,11011,60000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100020,51,22022,60000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100021,51,44444,60000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100022,51,55555,60000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100023,52,11111,70000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100024,52,22222,70000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100025,52,33333,70000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100026,52,44444,70000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100027,52,55555,70000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100028,52,77777,70000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100128,53,88888,80000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100029,53,22222,80000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100030,54,11111,90000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100031,54,22222,90000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100032,54,33333,90000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100033,54,44444,90000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100034,54,55555,90000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100035,55,77777,11000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100036,55,88888,11000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100037,55,99999,11000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100038,55,44444,11000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100039,55,55555,11000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100040,51,11111,12000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100041,51,22222,12000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100042,51,33033,12000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100043,52,33333,13000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100044,52,55555,13000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100045,52,77777,13000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100046,52,88888,13000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100047,52,11111,13000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100048,52,22222,13000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100049,52,33033,13000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100050,53,11111,14000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100051,53,22222,14000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100052,53,33333,14000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100053,53,11111,15000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100054,53,22222,15000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100055,53,33333,15000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100056,53,44444,15000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100057,53,55555,15000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100058,53,66666,15000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100059,53,77777,15000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100060,53,88888,15000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100061,53,33033,15000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100062,54,33033,16000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100063,54,11011,16000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100064,54,22022,16000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100065,54,99999,16000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100066,54,88888,16000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100067,55,11111,17000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100068,55,22222,17000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100069,55,33333,17000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100070,55,33033,17000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100071,55,44444,17000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100072,55,55555,17000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100073,55,66666,17000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100074,55,77777,17000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100075,51,11111,18000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100076,51,22222,18000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100077,51,33333,18000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100078,51,66666,18000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100079,51,77777,18000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100080,51,99999,18000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100081,51,11011,18000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100082,51,22022,18000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100083,51,33033,18000);


INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100084,52,33033,19000);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100085,53,44444,21000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100086,53,55555,21000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100087,53,88888,21000);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance) VALUES (100088,53,33033,21000);



--typeEntree--

INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100002,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100003,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100004,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100005,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100006,'Enfant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100007,'Enfant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100009,'Etudiant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100010,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100011,'Etudiant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100012,'Enfant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100014,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100015,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100016,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100017,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100018,'Enfant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100019,'Enfant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100020,'Enfant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100021,'Etudiant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100022,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100024,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100025,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100026,'Etudiant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100027,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100028,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100128,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100029,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100031,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100032,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100033,'Etudiant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100034,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100035,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100036,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100037,'Enfant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100038,'Etudiant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100039,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100041,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100044,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100045,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100046,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100048,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100051,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100052,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100054,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100055,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100056,'Etudiant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100057,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100058,'Etudiant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100059,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100060,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100063,'Enfant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100064,'Enfant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100065,'Enfant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100066,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100068,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100069,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100071,'Etudiant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100072,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100073,'Etudiant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100074,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100076,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100077,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100078,'Etudiant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100079,'Adulte');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100080,'Enfant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100081,'Enfant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100082,'Enfant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100085,'Etudiant');
INSERT INTO ticketUnitaire(codeticket, typeTarif) VALUES(100087,'Adulte');

INSERT INTO ticketCatre(codeticket) VALUES (100001);
INSERT INTO ticketCatre(codeticket) VALUES (100008);
INSERT INTO ticketCatre(codeticket) VALUES (100013);
INSERT INTO ticketCatre(codeticket) VALUES (100023);
INSERT INTO ticketCatre(codeticket) VALUES (100030);
INSERT INTO ticketCatre(codeticket) VALUES (100040);
INSERT INTO ticketCatre(codeticket) VALUES (100042);
INSERT INTO ticketCatre(codeticket) VALUES (100049);
INSERT INTO ticketCatre(codeticket) VALUES (100047);
INSERT INTO ticketCatre(codeticket) VALUES (100050);
INSERT INTO ticketCatre(codeticket) VALUES (100053);
INSERT INTO ticketCatre(codeticket) VALUES (100061);
INSERT INTO ticketCatre(codeticket) VALUES (100062);
INSERT INTO ticketCatre(codeticket) VALUES (100067);
INSERT INTO ticketCatre(codeticket) VALUES (100070);
INSERT INTO ticketCatre(codeticket) VALUES (100075);
INSERT INTO ticketCatre(codeticket) VALUES (100083);
INSERT INTO ticketCatre(codeticket) VALUES (100084);
INSERT INTO ticketCatre(codeticket) VALUES (100088);

--Noter--

INSERT INTO Noter(idClient,codeFilm, value) VALUES (11111,12341,4);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (11111,12342,4);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (11111,12343,4);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (11111,12344,3);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (11111,12346,3);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (11111,12347,3);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (11111,12348,4);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (11111,12340,5);

INSERT INTO Noter(idClient,codeFilm, value) VALUES (22222,12341,4);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (22222,12343,2);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (22222,12344,1);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (22222,12345,3);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (22222,12346,1);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (22222,12347,3);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (22222,12348,4);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (22222,12340,4);

INSERT INTO Noter(idClient,codeFilm, value) VALUES (33333,12341,4);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (33333,12343,1);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (33333,12344,1);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (33333,12346,4);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (33333,12347,2);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (33333,12348,3);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (33333,12340,4);

INSERT INTO Noter(idClient,codeFilm, value) VALUES (44444,12343,5);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (44444,12344,4);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (44444,12346,3);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (44444,12347,2);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (44444,12348,3);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (44444,12340,4);

INSERT INTO Noter(idClient,codeFilm, value) VALUES (55555,12343,2);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (55555,12344,2);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (55555,12346,2);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (55555,12347,2);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (55555,12340,3);

INSERT INTO Noter(idClient,codeFilm, value) VALUES (66666,12343,4);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (66666,12343,2);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (66666,12343,4);

INSERT INTO Noter(idClient,codeFilm, value) VALUES (77777,12342,3);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (77777,12343,5);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (77777,12344,2);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (77777,12346,4);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (77777,12347,5);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (77777,12340,3);

INSERT INTO Noter(idClient,codeFilm, value) VALUES (88888,12342,3);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (88888,12343,5);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (88888,12345,2);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (88888,12346,1);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (88888,12347,4);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (88888,12349,3);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (88888,12340,5);

INSERT INTO Noter(idClient,codeFilm, value) VALUES (99999,12343,3);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (99999,12346,1);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (99999,12349,3);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (99999,12340,5);

INSERT INTO Noter(idClient,codeFilm, value) VALUES (11011,12343,4);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (11011,12340,4);

INSERT INTO Noter(idClient,codeFilm, value) VALUES (22022,12343,3);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (22022,12340,5);

INSERT INTO Noter(idClient,codeFilm, value) VALUES (33033,12347,5);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (33033,12348,5);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (33033,12349,5);
INSERT INTO Noter(idClient,codeFilm, value) VALUES (33033,12340,5);

--produit--

INSERT INTO produit(idproduit) VALUES (913001);
INSERT INTO produit(idproduit) VALUES (913002);
INSERT INTO produit(idproduit) VALUES (913003);
INSERT INTO produit(idproduit) VALUES (913004);
INSERT INTO produit(idproduit) VALUES (913005);
INSERT INTO produit(idproduit) VALUES (913006);

INSERT INTO boisson(idproduit, nomboisson, tarifboisson) VALUES (913001,Eau,4);
INSERT INTO boisson(idproduit, nomboisson, tarifboisson) VALUES (913002,Soda,8);
INSERT INTO boisson(idproduit, nomboisson, tarifboisson) VALUES (913003,Coca,8);

INSERT INTO alimentaire(idproduit, nomalimentaire, tarifalimentaire) VALUES (913004,Pop-corn,10);
INSERT INTO alimentaire(idproduit, nomalimentaire, tarifalimentaire) VALUES (913005,Biscuits,5);
INSERT INTO alimentaire(idproduit, nomalimentaire, tarifalimentaire) VALUES (913006,Crêpe,8);

--payer et vendre--

INSERT INTO vendre(idproduit, idVendeur) VALUES (913001,51);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913002,51);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913004,51);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913001,52);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913002,52);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913005,52);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913006,52);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913001,55);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913003,55);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913004,55);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913006,55);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913001,54);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913002,54);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913006,54);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913001,53);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913002,53);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913003,53);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913004,53);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913005,53);
INSERT INTO vendre(idproduit, idVendeur) VALUES (913006,53);

INSERT INTO payer(idproduit, idClient, quantité) VALUES(913001,11111,6);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913001,22222,8);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913001,33333,4);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913001,44444,7);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913001,55555,2);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913002,66666,1);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913002,77777,2);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913002,11011,2);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913002,22022,2);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913003,33033,5);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913003,88888,6);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913003,99999,4);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913003,11011,4);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913004,11111,1);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913004,22222,5);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913004,33333,8);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913004,88888,3);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913004,33033,2);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913005,55555,6);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913005,11011,2);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913005,22022,4);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913005,66666,2);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913006,11111,1);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913006,22222,1);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913006,33333,1);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913006,77777,1);
INSERT INTO payer(idproduit, idClient, quantité) VALUES(913006,33033,1);

-----------------------------------------------------------------------------------
