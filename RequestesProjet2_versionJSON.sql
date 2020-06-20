--CREATE TABLE---------------------------------------------------------


CREATE TABLE Client(
  idClient int PRIMARY KEY,
  nom varchar NOT NULL,
  prenom varchar NOT NULL,
  dateNaissance DATE NOT NULL,
  Abonnement JSON NOT NULL,
  CONSTRAINT check_dateNaissance CHECK (dateNaissance <= current_date)
);

CREATE TABLE Film(
  codeFilm int PRIMARY KEY,
  titre varchar NOT NULL,
  dateSortie DATE NOT NULL,
  ageLimit int NOT NULL,
  Distributeur JSON NOT NULL,
  Realisateur JSON NOT NULL,
  Producteur JSON NOT NULL,
  Genre JSON NOT NULL,
  CONSTRAINT check_ageLimit CHECK (ageLimit > 0)
);


--------------------------------------------------------------------------------------------------

CREATE TABLE Seance (
  codeSeance int UNIQUE NOT NULL,
  jour DATE NOT NULL,
  heureDebut int NOT NULL,
  duree int NOT NULL,
  placeOccupees int NOT NULL,
  placeVendues int NOT NULL,
  détail JSON NOT NULL,
  salle JSON NOT NULL
  CONSTRAINT check_heureDebut CHECK (heureDebut <= 2359 AND heureDebut>= 0),
  CONSTRAINT check_duree CHECK (duree > 0),
  CONSTRAINT check_placeOccupees CHECK (placeOccupees > 0),
  CONSTRAINT check_Vendeur CHECK (placeVendues > 0)
);

------------------------------------------------------------------------------------------------
CREATE TABLE Vendeur(
  idVendeur int PRIMARY KEY,
  nom varchar NOT NULL,
  prenom varchar NOT NULL
);

--------------------------------------------------------------------------------------------
CREATE TABLE Entree(
  codeticket int PRIMARY KEY,
  idVendeur int NOT NULL,
  idClient int NOT NULL,
  codeSeance int NOT NULL,
  inforTicket JSON NOT NULL,
  CONSTRAINT fk_Entree_Vendeur FOREIGN KEY (idVendeur) REFERENCES Vendeur(idVendeur),
  CONSTRAINT fk_Entree_Client FOREIGN KEY (idClient) REFERENCES Client(idClient),
  CONSTRAINT fk_Entree_Seance FOREIGN KEY (codeSeance) REFERENCES Seance(codeSeance)
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE produit(
  idproduit int PRIMARY KEY
);

CREATE TABLE boisson(
  idproduit int NOT NULL,
  nomboisson varchar NOT NULL,
  tarifboisson int NOT NULL,
  PRIMARY KEY(idproduit),
  CONSTRAINT check_tarifboisson CHECK (tarifboisson >0),
  CONSTRAINT fk_boisson FOREIGN KEY (idproduit) REFERENCES produit(idproduit)
);

CREATE TABLE alimentaire(
  idproduit int NOT NULL,
  nomalimentaire varchar NOT NULL,
  tarifalimentaire int NOT NULL,
  PRIMARY KEY(idproduit),
  CONSTRAINT check_tarifalimentaire CHECK (tarifalimentaire > 0),
  CONSTRAINT fk_alimentaire FOREIGN KEY (idproduit) REFERENCES produit(idproduit)
);

--------------------------------------------------------------------------------------------------
CREATE TABLE vendre(
  idVendeur int NOT NULL,
  idproduit int NOT NULL,
  PRIMARY KEY(idVendeur, idproduit),
  CONSTRAINT fk_vendre_Vendeur FOREIGN KEY (idVendeur) REFERENCES Vendeur(idVendeur),
  CONSTRAINT fk_vendre_produit FOREIGN KEY (idproduit) REFERENCES produit(idproduit)
);

CREATE TABLE payer(
  idproduit int NOT NULL,
  idClient int NOT NULL,
  quantité int NOT NULL,
  PRIMARY KEY(idproduit, idClient),
  CONSTRAINT check_payer CHECK (quantité >0),
  CONSTRAINT fk_payer_produit FOREIGN KEY (idproduit) REFERENCES produit(idproduit),
  CONSTRAINT fk_payer_Client FOREIGN KEY (idClient) REFERENCES Client(idClient)
);


---------------------------------------------------------------------------------------------

CREATE TABLE Noter(
  idClient int NOT NULL,
  codeFilm int NOT NULL,
  value int,
  PRIMARY KEY(idClient, codeFilm),
  CONSTRAINT check_value CHECK (value >=0 AND value <=5),
  CONSTRAINT fk_Noter_Client FOREIGN KEY (idClient) REFERENCES Client(idClient),
  CONSTRAINT fk_Noter_Film FOREIGN KEY (codeFilm) REFERENCES Film(codeFilm)
);


----Gestion de droits-----------------------------------------------------------------------

-- CREATE USER 'manager'@'Your IP' IDENTIFIED BY 'admin123';
-- CREATE USER 'client'@'Your IP' IDENTIFIED BY 'abcdef123';
-- CREATE USER 'employee'@'Your IP' IDENTIFIED BY 'qwerty123';
--
-- GRANT ALL PRIVILEGES ON * . * TO 'manager'@'Your IP';
--
-- GRANT SELECT ON Film TO 'client'@'Your IP';
-- GRANT SELECT ON Distributeur TO 'client'@'Your IP';
-- GRANT SELECT ON Realisateur TO 'client'@'Your IP';
-- GRANT SELECT ON Producteur TO 'client'@'Your IP';
-- GRANT SELECT ON Genre TO 'client'@'Your IP';
-- GRANT SELECT ON Projection TO 'client'@'Your IP';
-- GRANT SELECT ON Seance TO 'client'@'Your IP';
-- GRANT SELECT ON Noter TO 'client'@'Your IP';
-- GRANT SELECT ON vInformationsdefilm TO 'client'@'Your IP';
-- GRANT SELECT ON vCatalogue 'client'@'Your IP';
-- GRANT SELECT ON vNombreClientRegardantFilm TO 'client'@'Your IP';
-- GRANT SELECT ON vHoraireDuFilmAvenue TO 'client'@'Your IP';
-- GRANT SELECT ON vHoraireDuFilmAffiché TO 'client'@'Your IP';
-- GRANT SELECT ON vTauxdeplace TO 'client'@'Your IP';
-- GRANT SELECT ON vMoyenneduFilm TO 'client'@'Your IP';
--
--
-- GRANT SELECT ON Vendeur TO 'employee'@'Your IP';
-- GRANT SELECT ON Entree TO 'employee'@'Your IP';
-- GRANT SELECT, INSERT, UPDATE ON Abonnement TO 'employee'@'Your IP';
-- GRANT SELECT, INSERT, UPDATE ON vendre TO 'employee'@'Your IP';
-- GRANT SELECT, INSERT, UPDATE ON payer TO 'employee'@'Your IP';
-- GRANT SELECT ON vListedeClients TO 'employee'@'Your IP';
-- GRANT SELECT ON vClientsMembres TO 'employee'@'Your IP';
-- GRANT SELECT ON vRevenu TO 'employee'@'Your IP';
-- GRANT SELECT ON vDistributionTicket TO 'employee'@'Your IP';
-- GRANT SELECT ON vTauxinscriptionmembres TO 'employee'@'Your IP';
-- GRANT SELECT ON vRevenuDeFilm TO 'employee'@'Your IP';
-- GRANT SELECT ON vRevenusdesproduits TO 'employee'@'Your IP';


--INSERT ----------------------------------------------------------------------------------

--Film--

INSERT INTO Film (codeFilm, titre, dateSortie, ageLimit, Distributeur, Realisateur, Producteur,Genre)
VALUES (
  12341,
  'Iron Man',
  '2008-05-02',
  5,
  '{"nom":"Paramount Pictures"}',
  '{"nom":"Favreau","prenom":"Jon"}',
  '{"nom":"Lee","prenom":"Stan"}',
  '{"type1":"ficton","type2":"Super héros"}'
);
INSERT INTO Film (codeFilm, titre, dateSortie, ageLimit, Distributeur, Realisateur, Producteur,Genre)
VALUES (
  12342,
  'The Incredible Hulk',
  '2008-06-13',
  5,
  '{"nom":"Paramount Pictures"}',
  '{"nom":"Leterrier","prenom":"Louis"}',
  '{"nom":"Arad","prenom":"Avi"}',
  '{"type1":"ficton","type2":"Super héros"}'
);
INSERT INTO Film (codeFilm, titre, dateSortie, ageLimit, Distributeur, Realisateur, Producteur,Genre)
VALUES (
  12343,
  'Iron Man 2',
  '2010-05-07',
  5,
  '{"nom":"Paramount Pictures"}',
  '{"nom":"Favreau","prenom":"Jon"}',
  '{"nom":"Lee","prenom":"Stan"}',
  '{"type1":"ficton","type2":"Super héros"}'
);
INSERT INTO Film (codeFilm, titre, dateSortie, ageLimit, Distributeur, Realisateur, Producteur,Genre)
VALUES (12344,
  'The Conjuring',
  '2013-08-21',
  13,
  '{"nom":"Warner Bros. Pictures"}',
  '{"nom":"Wan","prenom":"James"}',
  '{"nom":"Safran","prenom":"Peter"}',
  '{"type1":"ficton","type2":"horreur"}'
);
INSERT INTO Film (codeFilm, titre, dateSortie, ageLimit, Distributeur, Realisateur, Producteur,Genre)
VALUES (
  12345,
  'The Conjuring 2',
  '2016-06-29',
  13,
  '{"nom":"Warner Bros. Pictures"}',
  '{"nom":"Wan","prenom":"James"}',
  '{"nom":"Cowan","prenom":"Rob"}',
  '{"type1":"ficton","type2":"horreur"}'
);
INSERT INTO Film (codeFilm, titre, dateSortie, ageLimit, Distributeur, Realisateur, Producteur,Genre)
VALUES (
  12346,
  'Annabelle',
  '2014-10-08',
  13,
  '{"nom":"Warner Bros. Pictures"}',
  '{"nom":"Leonetti","prenom":"John Robert"}',
  '{"nom":"Cowan","prenom":"Rob"}',
  '{"type1":"ficton","type2":"horreur"}'
);
INSERT INTO Film (codeFilm, titre, dateSortie, ageLimit, Distributeur, Realisateur, Producteur,Genre)
VALUES (
  12347,
  'Fifty Shades of Grey',
  '2015-02-11',
  15,
  '{"nom":"Universal Pictures"}',
  '{"nom":"Foley","prenom":"James"}',
  '{"nom":"James","prenom":"E.L"}',
  '{"type1":"affection","type2":"dramatique"}'
);
INSERT INTO Film (codeFilm, titre, dateSortie, ageLimit, Distributeur, Realisateur, Producteur,Genre)
VALUES (
  12348,
  'Toy Story 4',
  '2019-06-26',
  5,
  '{"nom":"Walt Disney Studios Motion Pictures"}',
  '{"nom":"Cooley","prenom":"Josh"}',
  '{"nom":"Rivera","prenom":"Jonas"}',
  '{"type1":"dessin animé","type2":"amusement"}'
);
INSERT INTO Film (codeFilm, titre, dateSortie, ageLimit, Distributeur, Realisateur, Producteur,Genre)
VALUES (
  12349,
  'Doraemon: Nobitas New Dinosaur',
  '2020-08-07',
  5,
  '{"nom":"Toho Co. Ltd"}',
  '{"nom":"Kazuaki","prenom":"Imai"}',
  '{"nom":"Genki","prenom":"Kawamura"}',
  '{"type1":"dessin animé","type2":"amusement"}'
);
INSERT INTO Film (codeFilm, titre, dateSortie, ageLimit, Distributeur, Realisateur, Producteur,Genre)
VALUES (
  12340,
  'Avengers: Endgame',
  '2019-04-24',
  5,
  '{"nom":"Paramount Pictures"}',
  '{"nom":"Russo","prenom":"Joe"}',
  '{"nom":"Tyler","prenom":"Liv"}',
  '{"type1":"ficton","type2":"Super héros"}'
);

----Client--
INSERT INTO Client(idClient, nom, prenom, dateNaissance, Abonnement)
VALUES (
  11111,
  'Ho','XuanVinh',
  '2000-01-01',
  '{"Status":"Oui","placeEncore":"20"}'
);
INSERT INTO Client(idClient, nom, prenom, dateNaissance, Abonnement)
VALUES (
  22222,
  'Kevin','Gousse',
  '2001-02-03',
  '{"Status":"Oui","placeEncore":"1"}'
);
INSERT INTO Client(idClient, nom, prenom, dateNaissance, Abonnement)
 VALUES (
   33333,
   'Alain','Anne',
   '1999-10-30',
   '{"Status":"Non","placeEncore":"0"}'
 );
INSERT INTO Client(idClient, nom, prenom, dateNaissance, Abonnement)
VALUES (
  44444,
  'Masson','Sam',
  '2004-12-27',
  '{"Status":"Non","placeEncore":"0"}'
);
INSERT INTO Client(idClient, nom, prenom, dateNaissance, Abonnement) VALUES (
  55555,
  'David','Melodie',
  '1980-04-15',
  '{"Status":"Non","placeEncore":"0"}'
);
INSERT INTO Client(idClient, nom, prenom, dateNaissance, Abonnement)
VALUES (
  66666,
  'Descoteaux','Propi',
  '2006-05-22',
  '{"Status":"Non","placeEncore":"0"}'
);
INSERT INTO Client(idClient, nom, prenom, dateNaissance, Abonnement)
VALUES (
  77777,
  'Devoe','Jack',
  '1999-09-07',
  '{"Status":"Non","placeEncore":"0"}'
);
INSERT INTO Client(idClient, nom, prenom, dateNaissance, Abonnement)
VALUES (
  88888,
  'Hubert','Hubert',
  '2000-08-18',
  '{"Status":"Non","placeEncore":"0"}'
);
INSERT INTO Client(idClient, nom, prenom, dateNaissance, Abonnement)
VALUES (
  99999,
  'Nguyen','LeLyBang',
  '2013-03-06',
  '{"Status":"Non","placeEncore":"0"}'
);
INSERT INTO Client(idClient, nom, prenom, dateNaissance, Abonnement)
VALUES (
  11011,
  'Nguyen','GiaHoa',
  '2010-07-21',
  '{"Status":"Non","placeEncore":"0"}'
);
INSERT INTO Client(idClient, nom, prenom, dateNaissance, Abonnement)
VALUES (
  22022,
  'Le','TuHoNguyen',
  '2010-06-22',
  '{"Status":"Non","placeEncore":"0"}'
);
INSERT INTO Client(idClient, nom, prenom, dateNaissance, Abonnement)
VALUES (
  33033,
  'Hirasawa','Yui',
  '1991-11-27',
  '{"Status":"Oui","placeEncore":"30"}'
);


---Seance--

INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  10000,
  '2020-06-01',
  0800,
  85,
  10,
  2,
  '{"titre_du_film":"Iron Man","doublage":"VF"}',
  '{"nom_du_salle":"A100","capacite":"100"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  20000,
  '2020-05-30',
  1000,
  95,
  10,
  1,
  '{"titre_du_film":"Iron Man","doublage":"VF"}',
  '{"nom_du_salle":"A100","capacite":"100"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  30000,
  '2020-01-01',
  0800,
  115,
  10,
  2,
  '{"titre_du_film":"Iron Man","doublage":"VOST"}',
  '{"nom_du_salle":"A200","capacite":"100"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  40000,
  '2020-02-21',
  0800,
  120,
  10,
  3,
  '{"titre_du_film":"The Incredible Hulk","doublage":"VF"}',
  '{"nom_du_salle":"A200","capacite":"100"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  50000,
  '2020-03-01',
  1600,
  180,
  10,
  4,
  '{"titre_du_film":"Iron Man 2","doublage":"VF"}',
  '{"nom_du_salle":"A300","capacite":"50"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  60000,
  '2020-04-01',
  1000,
  120,
  10,
  10,
  '{"titre_du_film":"Iron Man 2","doublage":"VOST"}',
  '{"nom_du_salle":"B400","capacite":"150"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  70000,
  '2019-06-01',
  2300,
  120,
  10,
  6,
  '{"titre_du_film":"The Conjuring","doublage":"VOST"}',
  '{"nom_du_salle":"B400","capacite":"150"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  80000,
  '2019-06-07'
  ,1400,
  95,
  10,
  2,
  '{"titre_du_film":"The Conjuring 2","doublage":"VF"}',
  '{"nom_du_salle":"B400","capacite":"150"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (90000,
  '2019-12-25',
  1600,
  115,
  10,
  5,
  '{"titre_du_film":"Annabelle","doublage":"VF"}',
  '{"nom_du_salle":"B500","capacite":"200"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  11000,
  '2019-02-14',
  1700,
  115,
  10,
  5,
  '{"titre_du_film":"Annabelle","doublage":"VOST"}',
  '{"nom_du_salle":"A100","capacite":"100"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  12000,
  '2019-11-20',
  1400,
  115,
  10,
  3,
  '{"titre_du_film":"Fifty Shades of Grey","doublage":"VF"}',
  '{"nom_du_salle":"B400","capacite":"150"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  13000,
  '2019-10-20',
  2300,
  95,
  10,
  7,
  '{"titre_du_film":"Fifty Shades of Grey","doublage":"VOST"}',
  '{"nom_du_salle":"A200","capacite":"100"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  14000,
  '2019-08-03',
  2100,
  85,
  10,
  3,
  '{"titre_du_film":"Toy Story 4","doublage":"VF"}',
  '{"nom_du_salle":"B500","capacite":"200"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  15000,
  '2019-09-27',
  1700,
  85,
  10,
  9,
  '{"titre_du_film":"Toy Story 4","doublage":"VF"}',
  '{"nom_du_salle":"A100","capacite":"100"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  16000,
  '2019-12-25',
  2100,
  120,
  10,
  5,
  '{"titre_du_film":"Doraemon: Nobitas New Dinosaur","doublage":"VF"}',
  '{"nom_du_salle":"A300","capacite":"50"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  17000,
  '2019-01-31',
  2300,
  115,
  10,
  8,
  '{"titre_du_film":"Avengers: Endgame","doublage":"VF"}',
  '{"nom_du_salle":"B500","capacite":"200"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  18000,
  '2019-02-19',
  1400,
  120,
  10,
  9,
  '{"titre_du_film":"Avengers: Endgame","doublage":"VOST"}',
  '{"nom_du_salle":"B400","capacite":"150"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  19000,
  '2019-06-23',
  1400,
  95,
  10,
  1,
  '{"titre_du_film":"Avengers: Endgame","doublage":"VOST"}',
  '{"nom_du_salle":"A200","capacite":"100"}'
);
INSERT INTO Seance(codeSeance, jour, heureDebut, duree, placeOccupees, placeVendues, détail, salle)
VALUES (
  21000,
  '2019-03-08',
  1200,
  180,
  10,
  4,
  '{"titre_du_film":"Avengers: Endgame","doublage":"VOST"}',
  '{"nom_du_salle":"B500","capacite":"200"}'
);


--Vendeur--

INSERT INTO Vendeur(idVendeur, nom, prenom) VALUES (51,'Jamal','Forster');
INSERT INTO Vendeur(idVendeur, nom, prenom) VALUES (52,'Rianne','Duggan');
INSERT INTO Vendeur(idVendeur, nom, prenom) VALUES (53,'Yukinoshita','Yukino');
INSERT INTO Vendeur(idVendeur, nom, prenom) VALUES (54,'Dan','Flynn');
INSERT INTO Vendeur(idVendeur, nom, prenom) VALUES (55,'Ahmad','Callum');

--Entree--

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100001,
  51,
  11111,
  10000,
  '{"type":"Carte","tarif":"10"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100002,
  51,
  22222,
  10000,
  '{"type":"Carte","tarif":"10"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100003,
  52,
  33333,
  20000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100004,
  53,
  77777,
  30000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100005,
  53,
  88888,
  30000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100006,
  54,
  11011,
  40000,
  '{"type":"Unitaire Enfant","tarif":"5"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100007,
  54,
  22022,
  40000,
  '{"type":"Unitaire Enfant","tarif":"5"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100008,
  54,
  11111,
  40000,
  '{"type":"Carte","tarif":"10"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
 VALUES (
   100009,
   55,
   44444,
   50000,
   '{"type":"Unitaire Etudiant","tarif":"8"}'
 );
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100010,
  55,
  55555,
  50000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100011,
  55,
  66666,
  50000,
  '{"type":"Unitaire Etudiant","tarif":"8"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (100012,
  55,
  99999,
  50000,
  '{"type":"Unitaire Enfant","tarif":"5"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
 VALUES (
   100013,
   51,
   11111,
   60000,
   '{"type":"Carte","tarif":"10"}'
 );
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100014,
  51,
  22222,
  60000,
  '{"type":"Carte","tarif":"10"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100015,
  51,
  33333,
  60000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100016,
  51,
  77777,
  60000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100017,
  51,
  88888,
  60000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100018,
  51,
  99999,
  60000,
  '{"type":"Unitaire Enfant","tarif":"5"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100019,
  51,
  11011,
  60000,
  '{"type":"Unitaire Enfant","tarif":"5"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100020,
  51,
  22022,
  60000,
  '{"type":"Unitaire Enfant","tarif":"5"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100021,
  51,
  44444,
  60000,
  '{"type":"Unitaire Etudiant","tarif":"8"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100022,
  51,
  55555,
  60000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100023,
  52,
  11111,
  70000,
  '{"type":"Carte","tarif":"10"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100024,
  52,
  22222,
  70000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100025,
  52,
  33333,
  70000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100026,
  52,
  44444,
  70000,
  '{"type":"Unitaire Etudiant","tarif":"8"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100027,
  52,
  55555,
  70000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100028,
  52,
  77777,
  70000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (100128,
  53,
  88888,
  80000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100029,
  53,
  22222,
  80000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100030,
  54,
  11111,
  90000,
  '{"type":"Carte","tarif":"10"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100031,
  54,
  22222,
  90000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100032,
  54,
  33333,
  90000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100033,
  54,
  44444,
  90000,
  '{"type":"Unitaire Etudiant","tarif":"8"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (100034,
  54,
  55555,
  90000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100035,
  55,
  77777,
  11000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100036,
  55,
  88888,
  11000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100037,
  55,
  99999,
  11000,
  '{"type":"Unitaire Enfant","tarif":"5"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100038,
  55,
  44444,
  11000,
  '{"type":"Unitaire Etudiant","tarif":"8"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100039,
  55,
  55555,
  11000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100040,
  51,
  11111,
  12000,
  '{"type":"Carte","tarif":"10"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100041,
  51,
  22222,
  12000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100042,
  51,
  33033,
  12000,
  '{"type":"Carte","tarif":"10"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (100043,
  52,
  33333,
  13000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (100044,
  52,
  55555,
  13000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100045,
  52,
  77777,
  13000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100046,
  52,
  88888,
  13000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (100047,
  52,
  11111,
  13000,
  '{"type":"Carte","tarif":"10"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100048,
  52,
  22222,
  13000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100049,
  52,
  33033,
  13000,
  '{"type":"Carte","tarif":"10"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100050,
  53,
  11111,
  14000,
  '{"type":"Carte","tarif":"10"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100051,
  53,
  22222,
  14000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100052,
  53,
  33333,
  14000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100053,
  53,
  11111,
  15000,
  '{"type":"Carte","tarif":"10"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100054,
  53,
  22222,
  15000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100055,
  53,
  33333,
  15000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
 VALUES (
   100056,
   53,
   44444,
   15000,
   '{"type":"Unitaire Etudiant","tarif":"8"}'
 );
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100057,
  53,
  55555,
  15000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100058,
  53,
  66666,
  15000,
  '{"type":"Unitaire Etudiant","tarif":"8"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100059,
  53,
  77777,
  15000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100060,
  53,
  88888,
  15000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100061,
  53,
  33033,
  15000,
  '{"type":"Carte","tarif":"10"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100062,
  54,
  33033,
  16000,
  '{"type":"Carte","tarif":"10"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100063,
  54,
  11011,
  16000,
  '{"type":"Unitaire Enfant","tarif":"5"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100064,
  54,
  22022,
  16000,
  '{"type":"Unitaire Enfant","tarif":"5"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100065,
  54,
  99999,
  16000,
  '{"type":"Unitaire Enfant","tarif":"5"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100066,
  54,
  88888,
  16000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100067,
  55,
  11111,
  17000,
  '{"type":"Carte","tarif":"10"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100068,
  55,
  22222,
  17000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100069,
  55,
  33333,
  17000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100070,
  55,
  33033,
  17000,
  '{"type":"Carte","tarif":"10"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100071,
  55,
  44444,
  17000,
  '{"type":"Unitaire Etudiant","tarif":"8"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100072,
  55,
  55555,
  17000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100073,
  55,
  66666,
  17000,
  '{"type":"Unitaire Etudiant","tarif":"8"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100074,
  55,
  77777,
  17000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100075,
  51,
  11111,
  18000,
  '{"type":"Carte","tarif":"10"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100076,
  51,
  22222,
  18000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100077,
  51,
  33333,
  18000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (100078,
  51,
  66666,
  18000,
  '{"type":"Unitaire Etudiant","tarif":"8"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100079,
  51,
  77777,
  18000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100080,
  51,
  99999,
  18000,
  '{"type":"Unitaire Enfant","tarif":"5"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100081,
  51,
  11011,
  18000,
  '{"type":"Unitaire Enfant","tarif":"5"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100082,
  51,
  22022,
  18000,
  '{"type":"Unitaire Enfant","tarif":"5"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100083,
  51,
  33033,
  18000,
  '{"type":"Carte","tarif":"10"}'
);


INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100084,
  52,
  33033,
  19000,
  '{"type":"Carte","tarif":"10"}'
);

INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100085,
  53,
  44444,
  21000,
  '{"type":"Unitaire Etudiant","tarif":"8"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
 VALUES (
   100086,
   53,
   55555,
   21000,
   '{"type":"Unitaire Adulte","tarif":"15"}'
 );
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100087,
  53,
  88888,
  21000,
  '{"type":"Unitaire Adulte","tarif":"15"}'
);
INSERT INTO Entree(codeticket, idVendeur, idClient, codeSeance, inforTicket)
VALUES (
  100088,
  53,
  33033,
  21000,
  '{"type":"Carte","tarif":"10"}'
);


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

INSERT INTO boisson(idproduit, nomboisson, tarifboisson) VALUES (913001,'Eau',4);
INSERT INTO boisson(idproduit, nomboisson, tarifboisson) VALUES (913002,'Soda',8);
INSERT INTO boisson(idproduit, nomboisson, tarifboisson) VALUES (913003,'Coca',8);

INSERT INTO alimentaire(idproduit, nomalimentaire, tarifalimentaire) VALUES (913004,'Pop-corn',10);
INSERT INTO alimentaire(idproduit, nomalimentaire, tarifalimentaire) VALUES (913005,'Biscuits',5);
INSERT INTO alimentaire(idproduit, nomalimentaire, tarifalimentaire) VALUES (913006,'Crêpe',8);

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

--VUES avec JSON------------------------------------------------------------------------------

----liste de clients--------------------------------------------------------------------

CREATE VIEW vListedeClients AS
SELECT
Client.nom,
Client.prenom,
Client.dateNaissance,
Film.titre,
Abonnement->>'Status' AS membre,
Abonnement->>'placeEncore' AS place_Encore
FROM Client, Film, Noter
WHERE (Client.idClient = Noter.idClient) AND (Film.codeFilm = Noter.codeFilm);


----Ventes et vente de billets-------------------------------------------------------------

CREATE VIEW vRevenu AS
SELECT
COUNT(codeticket),
SUM(CAST(inforTicket->>'tarif' AS INTEGER)) AS total
FROM Entree;


-----Informations sur le film--------------------------------------------------------------

CREATE VIEW vInformationsdefilm AS
SELECT
titre,
dateSortie,
ageLimit,
Distributeur->>'nom' AS distributeur_nom,
CONCAT(CAST(Realisateur->>'nom' AS VARCHAR) , ' ', CAST(Realisateur->>'prenom' AS VARCHAR)) AS Realisateur,
CONCAT(CAST(Producteur->>'nom' AS VARCHAR) , ' ', CAST(Producteur->>'prenom' AS VARCHAR)) AS Producteur,
CONCAT(CAST(Genre->>'type1' AS VARCHAR), ' | ', CAST(Genre->>'type2' AS VARCHAR)) AS Genre
FROM Film;


CREATE VIEW vRevenuDeFilm AS
SELECT
Film.titre,
SUM(CAST(Entree.inforTicket->>'tarif' AS INTEGER)) AS Revenu
FROM Film, Entree, Seance
WHERE
  (Film.titre = CAST(Seance.détail->>'titre_du_film' AS VARCHAR))
  AND (Entree.codeSeance = Seance.codeSeance)
GROUP BY Film.codeFilm;


CREATE VIEW vHoraireDuFilmAffiché AS
SELECT *
FROM Seance
WHERE (Seance.jour < current_date);

CREATE VIEW vHoraireDuFilmAvenue AS
SELECT *
FROM Seance
WHERE (current_date <= Seance.jour);

CREATE VIEW vMoyenneduFilm AS
  SELECT Film.titre, ROUND(SUM(Noter.Value)*1.0/COUNT(Noter.idClient), 2) AS NoteMoyenne
  FROM Film, Noter
  WHERE (Film.codeFilm = Noter.codeFilm)
  GROUP BY Film.codeFilm;

----vente de produits-------------------------------------------------------------------
CREATE VIEW vRevenusdesproduits AS
 (SELECT boisson.nomboisson AS nomproduits, SUM(payer.quantité) AS Quantite, SUM(payer.quantité*boisson.tarifboisson) AS Revenu
        FROM boisson, payer
        WHERE (boisson.idproduit=payer.idproduit)
        GROUP BY boisson.idproduit)
  UNION
 (SELECT alimentaire.nomalimentaire AS nomproduits, SUM(payer.quantité) AS Quantite, SUM(payer.quantité*alimentaire.tarifalimentaire) AS Revenu
        FROM alimentaire, payer
        WHERE (alimentaire.idproduit=payer.idproduit)
        GROUP BY alimentaire.idproduit);
