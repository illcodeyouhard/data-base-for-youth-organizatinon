/*
   ______                    _              __               __                                                    
 .' ___  |                  / |_           |  ]             [  |                                                   
/ .'   \_|_ .--. .---. ,--.`| |-.---.  .--.| |               | |.--.  _   __                                       
| |      [ `/'`\/ /__\`'_\ :| |/ /__\/ /'`\' |               | '/'`\ [ \ [  ]                                      
\ `.___.'\| |   | \__.// | || || \__.| \__/  |               |  \__/ |\ '/ /                                       
 `.____ .[___]   '.__.\'-;__\__/'.__.''.__.;__]             [__;.__.[\_:  /                                        
 ____    ____       __                                  ______       \__.'           _              __             
|_   \  /   _|     [  |  _                             |_   _ `.                    / |_           [  |  _         
  |   \/   |  ,--.  | | / ] .--.   _   __ _ .--..--.     | | `. \_ .--..--.   _   _`| |-.---. _ .--.| | / ] .--.   
  | |\  /| | `'_\ : | '' < ( (`\] [ \ [  [ `.-. .-. |    | |  | [ `.-. .-. | [ \ [  | |/ /__\[ `/'`\| '' </ .'`\ \ 
 _| |_\/_| |_// | |,| |`\ \ `'.'.  \ '/ / | | | | | |   _| |_.' /| | | | | |  \ '/ /| || \__.,| |   | |`\ | \__. | 
|_____||_____\'-;__[__|  \_[\__) [\_:  / [___||__||__] |______.'[___||__||__[\_:  / \__/'.__.[___] [__|  \_'.__.'  
                                  \__.'                                      \__.'                                 
*/

--Tables existence check

IF OBJECT_ID('Organization','U') IS NOT NULL
DROP TABLE Organization

IF OBJECT_ID('OrgContacs','U') IS NOT NULL
DROP TABLE OrgContacs

IF OBJECT_ID('Country','U') IS NOT NULL
DROP TABLE Country

IF OBJECT_ID('NameContacs','U') IS NOT NULL
DROP TABLE NameContacs

IF OBJECT_ID('Name','U') IS NOT NULL
DROP TABLE Name

IF OBJECT_ID('Status','U') IS NOT NULL
DROP TABLE Status


IF OBJECT_ID('FBgroups','U') IS NOT NULL
DROP TABLE FBgroups

GO

--views existence check

if OBJECT_ID('FullTableOrganization','V') IS NOT NULL
DROP VIEW FullTableOrganization

if OBJECT_ID('FullOrgContacs ','V') IS NOT NULL
DROP VIEW FullOrgContacs 

if OBJECT_ID('[FullOrgContacs+Status]','V') IS NOT NULL
DROP VIEW [FullOrgContacs+Status]

if OBJECT_ID('OrgAndStatus','V') IS NOT NULL
DROP VIEW OrgAndStatus

GO

--checking the existence of the procedure
IF OBJECT_ID('spStatusCheck','P') IS NOT NULL
DROP PROC spStatusCheck
GO

--Creating tables
IF OBJECT_ID('Name','U') IS NULL
CREATE TABLE Name(
	[ID] [INT] PRIMARY KEY ,
	[Names] [NVARCHAR](50) NOT NULL,
	[Languages] [NVARCHAR](100) NOT NULL,
	[Break] [NVARCHAR](50) NOT NULL,
	[Employed Date] NVARCHAR (50) NOT NULL,

	--use the specific PK name:
)

IF OBJECT_ID('NameContacs','U') IS NULL
CREATE TABLE [NameContacs](
	[ContactID] [INT]  PRIMARY KEY ,
	[NameID] [INT] NOT NULL,
	[Email] [NVARCHAR](50) NOT NULL,
	[TG nickname] [NVARCHAR](30) NOT NULL,
	[EmailAccess] [NVARCHAR](3) NOT NULL,
	[City] [NVARCHAR](30) NOT NULL,
	[Phone Number] [bigINT] NOT NULL,
	[Date Of Birth] NVARCHAR (50) NOT NULL,
)


IF OBJECT_ID('Country','U') IS NULL
CREATE TABLE [Country](
	[CountryID] [INT] PRIMARY KEY ,
	[CountryName] [NVARCHAR](30) NOT NULL,
)

IF OBJECT_ID('Status','U') IS NULL
CREATE TABLE [Status](
	[StatusID] [INT]  PRIMARY KEY ,
	[Status] [NVARCHAR](60) NOT NULL,
)

IF OBJECT_ID('FBgroups','U') IS NULL
CREATE TABLE FBgroups(
	[FBgroupID] [INT]  PRIMARY KEY ,
	[permalink (revealed ON October)] [NVARCHAR](200) NOT NULL,
	[group id] [NVARCHAR] (50) NOT NULL,
	[total partnerships found in this group] [INT] NOT NULL,
	[group position in the list] [INT]
)


IF OBJECT_ID('OrgContacs','U') IS NULL
CREATE TABLE OrgContacs(
	[OrgContacsID] [INT] PRIMARY KEY ,
	[Country] [INT] ,	--FOREIGN KEY REFERENCES Country (CountryID)
	[Website] [NVARCHAR] (100) NOT NULL,
	[Email] [NVARCHAR] (50) NOT NULL,
	[Other contacs(FB,IG)][NVARCHAR] (100) NOT NULL,
	
)
--inserting a fk ;fail
/*ALTER TABLE OrgContacs
ADD CONSTRAINT FK_1
FOREIGN KEY (Country) REFERENCES dbo.Country(CountryID)
*/

/* test
IF OBJECT_ID('Organization','U') IS NOT NULL
DROP TABLE Organization
GO
*/
IF OBJECT_ID('Organization', 'U') IS NULL
CREATE TABLE Organization(
	[OrganizationID] [INT] PRIMARY KEY ,
	[Name] [NVARCHAR] (200) NOT NULL,
	[OrgContacsID] [INT]  NOT NULL,
	[Status] [INT] ,-- FOREIGN KEY REFERENCES Status(StatusID),
	[Date of communication] Date NOT NULL,
	[Responsible person] [INT] NOT NULL,
	[FBgroupID] int NOT NULL

)
GO



INSERT INTO Organization ([OrganizationID], [Name], OrgContacsID, [Status],[Date of communication],[Responsible person],FBgroupID)
VALUES
	(1, 'CaYNex',1,1, '2019-03-13',4,2),
	(2, 'Konya Metropolitan Municipality',2,2, '2019-01-01',5,4),
	(3, '"INTernational Center for INTercultural Research, Learning and Dialogue"',3,5,'2019-03-13', 4,7),
	(4, 'Kasif Genclik ve Spor Kulubu Dernegi',4,3,'2019-09-01',5,9),
	(5, 'Association NIE',5,4,'2019-10-01',5,1),
	(6, 'ProQvi',6,2,'2019-10-01',5,7),
	(7, 'BITISI',7,4,'2020-01-01',4,9),
	(8, 'Stowarzyszenie na Rzecz Rozwoju Gminy Zychlin',8,3,'2020-02-01', 5,1),
	(9, 'Crossroad of Ideas-Youth NGO - COI',9,3,'2019-02-01',2,3),
	(10, 'Karaman INTernational Group',10,2,'2020-01-01',5,4);
	
--adding fk
ALTER TABLE dbo.Organization WITH NOCHECK
ADD CONSTRAINT FK_1
FOREIGN KEY (Status) REFERENCES dbo.Status(StatusID)

ALTER TABLE dbo.Organization WITH NOCHECK
ADD CONSTRAINT FK_Organization_OrgContacs
FOREIGN KEY (OrgContacsID) REFERENCES dbo.OrgContacs(OrgContacsID)

ALTER TABLE dbo.Organization WITH NOCHECK
ADD CONSTRAINT FK_Organization_NameContacs
FOREIGN KEY (OrgContacsID) REFERENCES dbo.nameContacs(ContactID)

ALTER TABLE dbo.Organization WITH NOCHECK
ADD CONSTRAINT FK_Organization_FBgroups
FOREIGN KEY (FBgroupID) REFERENCES dbo.FBgroups(FBgroupID)

INSERT INTO OrgContacs([OrgContacsID],Country, [Website], [Email], [Other contacs(FB,IG)])
VALUES 
	(1,46,'http://caynex.ge/', 'caucasusyouthnexus@gmail.com','"tamar.tsatskrialashvili@gmail.com, anizalova1@gmail.com'),
	(2,38,'http://www.konya.bel.tr/', 'kilicarslan.eu@konya.bel.tr','facebook.com/ozcanserife014'),
	(3, 37, 'www.INTercultural.center','info@INTercultural.center','https://www.facebook.com/icirld'),
	(4, 38, 'http://www.kasifiz.biz/', 'ali.ak25@hotmail.com','https://www.facebook.com/ali.akcelik'),
	(5, 21,'http://nie.org/','nie.org@abv.bg','https://www.facebook.com/AssociationNIE'),
	(6, 13,'https://www.proqvi.se/','tusenmila@gmail.com, tania.bauder@gmail.com','https://www.facebook.com/ProQvi/'),
	(7, 46,'https://bitisingo.wordpress.com/','niparishvililevan@gmail.com','https://www.facebook.com/profile.php?id=100001105600833'),
	(8, 6, 'http://www.zychlin.org/','Agata.pawlowska@aol.com','https://www.facebook.com/profile.php?id=1788709776'),
	(9, 4, 'N/A','crossroadofideas@gmail.com','https://www.facebook.com/CrossroadofIdeas/?_rdc=1&_rdr'),
	(10, 38,'N/A','ozgenurturegun@hotmail.com','https://www.facebook.com/karamanINTernational');
	
--adding fk
ALTER TABLE dbo.OrgContacs WITH NOCHECK
ADD CONSTRAINT FK_OrgContacs
FOREIGN KEY (Country) REFERENCES dbo.Country(CountryID)


	INSERT INTO Country([CountryID] ,CountryName)VALUES 
	(1,'Germany'), (2,'United Kingdom'),(3,'France'),(4,'Italy'),(5,'Spain'),(6,'Poland'),(7,'Romania'),(8,'Netherlands'),(9,'Belgium'),(10,'Czechia'),
	(11,'Greece'),(12,'Portugal'),(13,'Sweden'),(14,'Hungary'),	(15,'Austria'),(16,'Serbia'),(17,'Belarus'),(18,'Serbia'),(19,'Austria'),(20,'Switzerland'),
	(21,'Bulgaria'),(22,'Denmark'),(23,'Finland'),(24,'Slovakia'),(25,'Croatia'),(26,'Moldova'),(27,'Bosnia and Herzegovina'), (28,'Norway'),(29,'Albania'),(30,'Lithuania'),
	(31,'North Macedonia'),(32,'Slovenia'),(33,'Latvia'),(34,'Estonia'),(35,'Montenegro'),(36,'Luxembourg'),(37,'Iceland'),(38,'Turkey'),(39,'Israel'),(40,'China'), 
	(41,'Liechtenstein'),(42,'Malta'),(43,'North Macedonia'), (44,'Cyprus'), (45,'Egypt'), (46,'Georgia');
INSERT INTO Name ([ID], Names, Languages, [Break], [Employed Date])
VALUES
  (1, 'Voronina O', 'German (B2), Polish (A2)', '',''),
  (2, 'Arnold S', '', '','21.05.1998'),
  (3, 'Haiduk R', '', '','2018-10-03'),
  (4, 'Dobrova O', 'Spanish (A2), Italian (A1)', '',''),
  (5, 'Klishch M', 'German (A1), Latvian (A1)', '',''),
  (6, 'Moroz Y', '', 'April 20th untill May 1st','2019-03-01'),
  (7, 'Sidletskiy A', 'Polish (C1)', '','2016'),
  (8, 'Tertycha A', 'German(A2)','', ''),
  (9, 'Cherniak V', '', '',''),
  (10, 'Hladkyi A', '','', '2019-09-14'),
  (11,'Morska V', 'French (A2), Polish (A1)', 'till 1.05','2019-09-15');
  
  INSERT INTO NameContacs ([ContactID], [NameID], [Email], [TG nickname], [EmailAccess] , [City], [Phone Number],  [Date Of Birth])
  VALUES
  (1, 1, 'sacuki06@gmail.com sacukiprglobe@yahoo.com', 'olhavoSac21', 'yes', 'Smila', 380636999383,'21.05.1998'),
  (2, 3, 'haidukruslam@gmail.com', '@rusla', 'yes', 'Ivano-frankivsk', 380952217144, '10.03.2000'),
  (3, 4, 'olyadobrova28@gmail.com', '@dobro', 'yes', 'Kyiv', 380503962663, '27.12.1998'),
  (4, 5, 'mykola.klishch1708@gmail.com', '@mykol', 'yes', 'Lviv', 380983272680, '24.09.1996'),
  (5, 6, 'slavko.morox@gmail.com', '@Slavk', 'yes', 'Kyiv', 380968158351, '02.08.1999'),
  (6, 7,'a5785556@gmail.com', '@adam', 'yes','Warsaw', 380992225453, '23.10.1997'),
  (7, 8, 'nikanegjcnn@gmail.com', '@Black', 'yes', 'Kharkiv', 380660655975,'16.10.1997'),
  (8, 9, 'valeri03sun00@gmail.com', '@vale', 'yes', 'Kyiv', 380662150983,'09.03.1999'),
  (9, 10, 'dungmajor234@gmail.com', '@capg','no','Uzhhorod',380913826433,'15.12.2001'),
  (10, 11, 'vitaliam05@gmail.com', '@livin', 'no', 'Ivano-frankivsk', 380506387937, '05.07.2004'),
  (11, 12, 'q0968463607@gmail.com', '@ivan', 'yes', 'Ivano-frankivsk', 380968463607, '04.08.2001'),
  (12, 13, 'kravets.stasis@gmail.com','@ta_', 'yes', 'Kyiv', 380954561658, '06.07.2001');

  --adding fk
ALTER TABLE dbo.NameContacs WITH NOCHECK
ADD CONSTRAINT FK_NameContacs
FOREIGN KEY (NameID) REFERENCES dbo.Name(ID)

	INSERT INTO Status ([StatusID] ,Status) VALUES
	(1,'They don''t answer'),
	(2,'Not interested'),
	(3,'Interesting in the future'),
	(4,'Agreed upon partnership'),
	(5,'We had experience with them');
 

INSERT INTO FBgroups ([FBgroupID] ,[permalink (revealed ON October)], [group id], [total partnerships found in this group],[group position in the list]) 
VALUES
(1,'https://www.facebook.com/groups/eramus.plus/search/?query=call%20for%20partners&epa=FILTERS&filters=eyJycF9jaHJvbm9fc29ydCI6INTcIm5hbWVcIjpcImNocm9ub3NvcnRcIixcImFyZ3NcIjpcIlwifSJ9', 'eramus.plus', 23,1),
(2,'https://www.facebook.com/groups/eramus.plus/permalink/2689365451146344/','eramus.plus',23,1),
(3,'https://www.facebook.com/groups/211479949023086/permalink/1521259328045135/', '211479949023086', 8, 2),
(4,'https://www.facebook.com/groups/1396451860652137/permalink/2296892123941435/', '1396451860652137', 5, 3),
(5,'https://www.facebook.com/groups/1396451860652137/permalink/2292016004429047/', '1396451860652137', 5, 3),
(6,'https://www.facebook.com/groups/erasmusplus.partners/permalink/1330958487113574/', 'erasmusplus.partners', 6, 4),
(7,'https://www.facebook.com/groups/erasmusplus.partners/permalink/1312441418965281/', 'erasmusplus.partners', 6, 4),
(8,'https://www.facebook.com/groups/erasmusplusprojects/permalink/1275128032658078/', 'erasmusplusprojects', 6, 5),
(9,'https://www.facebook.com/groups/erasmusplusprojects/permalink/1274516832719198/', 'erasmusplusprojects', 6, 5),
(10,'https://www.facebook.com/groups/erasmus.youthinaction/permalink/2765961306854976/', 'erasmus.youthinaction', 2, 6),
(11,'https://www.facebook.com/groups/erasmus.youthinaction/permalink/2748265141957926/', 'erasmus.youthinaction', 2, 6),
(12,'https://www.facebook.com/groups/1584904988430053/permalink/2503167276603815/', '1584904988430053', 6, 7),
(13,'https://www.facebook.com/groups/1584904988430053/permalink/2482713695315840/', '1584904988430053', 6, 7),
(14,'https://www.facebook.com/groups/285680781582663/permalink/1553902344760494/', '285680781582663', 5, 8),
(15,'https://www.facebook.com/groups/285680781582663/permalink/1525779657572763/', '285680781582663', 5, 8);

  GO


  --creating views

  --Org + status view
  create view OrgAndStatus AS
  SELECT a.OrganizationID, a.Name, a.OrgContacsID,Status.Status, a.[Date of communication], a.[Responsible person]
  FROM Organization a left join [Status] ON a.Status=Status.StatusID

  GO 
  
  --combining country table with OrgContacs table
  CREATE VIEW FullOrgContacs AS
  SELECT a.OrgContacsID, Country.CountryName, a.Website, a.Email, a.[Other contacs(FB,IG)]
  FROM OrgContacs a LEFT JOIN Country ON a.Country=Country.CountryID
  
  GO
  --combining OrgAndStatus and FullOrgContacs
  create view [FullOrgContacs+Status] AS
  SELECT a.Name, b.CountryName, b.Website, b.Email, b.[Other contacs(FB,IG)], a.Status, a.[Date of communication], 
  a.[Responsible person]
FROM OrgAndStatus a full join FullOrgContacs b ON a.OrgContacsID=b.OrgContacsID
  
  GO

  --combining [FullOrgContacs+Status] + Name table
  create view FullTableOrganization AS
  SELECT a.Name, a.CountryName, a.Website, a.Email, a.[Other contacs(FB,IG)], a.Status, a.[Date of communication], 
  Name.Names
FROM [FullOrgContacs+Status] a left join [Name] ON a.[Responsible person]=[Name].ID

  GO
  
-- CREATING A PROCEDURE
CREATE PROC spStatusCheck --@Status NVARCHAR(40) AS
@Status NVARCHAR (40)
WITH ENCRYPTION
AS
BEGIN -- begin body of PROC
	SELECT Name,Status  FROM FullTableOrganization
	WHERE Status = @Status
	ORDER BY [Name]
END
GO


	--REPORTS
--1 

PRINT 'What are First and Last names of the person who took the most responsibilities?'
SELECT  TOP 1 COUNT(Names) AS theMost, Names FROM FullTableOrganization 
GROUP BY Names 
ORDER BY theMost DESC

--2
PRINT 'Which 2 hosting Erasmus+ countries offer the most partnerships?'
SELECT  TOP 2 COUNT(CountryName) AS [Offer the most partnerships], CountryName FROM FullTableOrganization 
GROUP BY CountryName 
ORDER BY [Offer the most partnerships] DESC

--3
PRINT 'What are the most recent Erasmus+ organizations that we communicated to?'
SELECT TOP 2 'The most recent communication date'=YEAR([Date of communication]),Name OrgName  FROM Organization
WHERE YEAR([Date of communication]) >= 2020


--4 organizations that do not have a website
SELECT Name, Website FROM FullTableOrganization
WHERE Website = 'N/A'

GO

--5 Checking what status
EXEC spStatusCheck 'Not interested'

/* AVAIBLE PARAMETERES
	'They don''t answer'
	'Not interested'
	'Interesting in the future'
	'Agreed upon partnership'
	'We had experience with them'
*/


/* SOME COMMENTS
sp_helptext spFinally

allows to view text of a specific PROCEDURE
BUT I added ENCRYPTION, therefore, you cannot use sp_helptext 
*/



  /* testing (do not pay attention)

  SELECT Name.Names, NameContacs.Email, NameContacs.[TG nickname], NameContacs.City FROM NameContacs INNER JOIN Name ON NameContacs.NameID=Name.ID

  SELECT * FROM OrgAndStatus
  SELECT * FROM FullOrgContacs 

  SELECT * FROM [FullOrgContacs+Status]
  SELECT * FROM Name
  
  SELECT * FROM Country
  SELECT * FROM OrgContacs
  
  SELECT * FROM OrgContacs
  SELECT *FROM  [FullOrgContacs+Status]

  SELECT Organization.Name, OrgContacs.Website, OrgContacs.Email, OrgContacs.[Other contacs(FB,IG)], Organization.Status,
  Organization.[Date of communication],Organization.[Responsible person]
  FROM Organization LEFT JOIN OrgContacs ON Organization.OrgContacsID=OrgContacs.OrgContacsID 

  */

--https://stackoverflow.com/questions/6912336/mysql-join-multiple-joins-ON-the-same-table
/*
  A batch of SQL statements is a group of two or more SQL statements or a single SQL statement that has 
  the same effect AS a group of two or more SQL statements. In some implementations, the entire batch 
  statement is executed before any results are available.
  -- GO is necessary for the batch statements in microsoft sql
  */

 

