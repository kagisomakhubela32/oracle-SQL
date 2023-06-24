DROP TABLE F_orditem 	CASCADE CONSTRAINTS;
DROP TABLE F_order	CASCADE CONSTRAINTS;
DROP TABLE F_driverlicense 	CASCADE CONSTRAINTS;
DROP TABLE F_deliveryman 	CASCADE CONSTRAINTS;
DROP TABLE F_paytype	CASCADE CONSTRAINTS;
DROP TABLE F_customer 	CASCADE CONSTRAINTS;
DROP TABLE F_RMItem	CASCADE CONSTRAINTS;
DROP TABLE F_category	CASCADE CONSTRAINTS;
DROP TABLE F_restaurant 	CASCADE CONSTRAINTS;
DROP TABLE F_owner	CASCADE CONSTRAINTS;

/* -------------------------------1--------------------------------*/

CREATE TABLE F_owner (
OwnerID		NUMBER(1)	PRIMARY KEY,
Surname		VARCHAR2(13)	NOT NULL,
Initials		VARCHAR2(4),
CellNo		CHAR(10),
EMail		VARCHAR2(20));
/* -------------------------------2--------------------------------*/

CREATE TABLE F_restaurant (
RCode		CHAR(4)		PRIMARY KEY,
Name		VARCHAR2(15),
RType		CHAR(2),
MgrSurname	VARCHAR2(13)	NOT NULL,
MgrInitials	VARCHAR2(4),
MgrClass		CHAR(2),
Sex		CHAR,
PhoneNo		CHAR(10),
Location		VARCHAR2(15),
OwnerId		NUMBER(1) 	REFERENCES F_owner,
RecommendedBy	VARCHAR2(13));

/* -------------------------------3-------------------------------*/

CREATE TABLE F_category (
CatCode		CHAR(2)		PRIMARY KEY,
CatDesc		VARCHAR2(9));

/* -------------------------------4-------------------------------*/

CREATE TABLE F_RMItem (
RMItem#		NUMBER(4)	PRIMARY KEY,
ItemDesc		VARCHAR2(30),
ItemPrice		NUMBER(5,2),
RCode		CHAR(4)		REFERENCES F_restaurant,
CatCode		CHAR(2)		REFERENCES F_category);

/* -------------------------------5-------------------------------*/

CREATE TABLE F_customer (
Cno		NUMBER(5) 	PRIMARY KEY,
MemberOf	NUMBER(5),
surname		VARCHAR2(13) 	CHECK 	(surname=UPPER(surname)),
fname		VARCHAR2(12),
straddr		VARCHAR2(20),
suburb		VARCHAR2(12),
cellNo		CHAR(10),
cType		CHAR,
JoinDate		DATE);

/* -------------------------------6--------------------------------*/

CREATE TABLE F_PayType (
pTCode		CHAR(2)		PRIMARY KEY,
pTDesc		VARCHAR2(20));

/* -------------------------------7--------------------------------*/

CREATE TABLE F_DriverLicense (
DLCode		VARCHAR2(2)	PRIMARY KEY,
DLDesc		VARCHAR2(16));

/* -------------------------------8--------------------------------*/

CREATE TABLE f_deliveryman(
DMCellno		CHAR(10) 	PRIMARY KEY,
surname		VARCHAR2(7) 	CHECK 	(surname=UPPER(surname)),
fnames		VARCHAR2(14),
IdNo		VARCHAR2(13),
DLCode		VARCHAR2(2)	REFERENCES F_driverlicense);

/* -------------------------------9--------------------------------*/

CREATE TABLE F_order (
ONo		NUMBER(3)	PRIMARY KEY,
ODateTime	DATE		NOT NULL,
Cno		NUMBER(5)	REFERENCES F_customer,
pTCode		CHAR(2)		NOT NULL REFERENCES F_payType,
DMCellno		CHAR(10)		REFERENCES f_deliveryman,
Delivered		CHAR,
Collect		CHAR);

/* -------------------------------10-------------------------------*/

CREATE TABLE F_OrdItem (
ONo		NUMBER(3)	REFERENCES F_order,
OItem		NUMBER(1),
RMItem#		NUMBER(4)	REFERENCES F_rmitem,
quantity		NUMBER(2)	NOT NULL,
PRIMARY KEY (ono, oitem));


/*= 1 : F_OWNER =====================================================================================
OwnerID (N1)   Surname V2(13) NN    Initials V2(4)      CellNo C(10) EMail V2(20))
1, '1234567890123', '1234', '1234567890', '12345678901234567890'
===================================================================================================*/
INSERT INTO f_owner VALUES (
1, 'Van Der Merwe', 'KOOS', '0847893636', 'VDMK@Gmail.Com');

INSERT INTO f_owner VALUES (
2, 'MHLABA', 'MI', '0723645987', 'MHLABA@Gmail.com');

INSERT INTO f_owner VALUES (
3, 'Nkosi', 'YME', '0723655566', 'NKOSIYME@TUT.AC.ZA');

INSERT INTO f_owner VALUES (
4, 'GHAMA', 'PE', '0836773444', 'PEGHAMA@gmail.com');

/*= 2 : F_RESTAURANT ================================================================================
RCode C(3)   Name V2(15)   MgrSurname	V2(13) NN   MgrInitials V2(4)   MClass C(2)  PhoneNo C(10)   Location  V2(15)   OwnerId N(1)
'123', '123456789012345', '1234567890123', '1234', '12', '1234567890', '123456789012345', 1);
==================================================================================================*/
INSERT INTO f_restaurant VALUES (
'OBHM', 'Ocean Basket', 'SF', 'Van Dyk', 'BJZ', 'Ex', 'M', '0845763355', 'HIGHVELD MALL', 1, NULL);

INSERT INTO f_restaurant VALUES (
'CCHM', 'Cappuccinos', 'SG', 'Gama', 'MY', 'Ex', 'M', '0713657723', 'HIGHVELD MALL', 2, NULL);

INSERT INTO f_restaurant VALUES (
'BKMP', 'Burger King', 'BG', 'Nkosi', 'MM', 'In', 'F', '0846579923', 'Model Park', 4, NULL);

INSERT INTO f_restaurant VALUES (
'OBSW', 'Ocean Basket', 'SF', 'Nkosi', 'HJ', 'In', 'F', '0713428798', 'SAVEWAYS', 1, 'Van Dyk');

INSERT INTO f_restaurant VALUES (
'KFCT', 'KFC Techno Park', 'FC', 'Ndlovu', 'PMC', 'No', 'M', '0836573131', 'Techno Park', 3, NULL);

INSERT INTO f_restaurant VALUES (
'KFCK', 'KFC Klipfontein', 'FC', 'Mbonambi', 'B', 'In', 'M', '0766785621', 'Klipfontein', 3, 'Ndlovu');

INSERT INTO f_restaurant VALUES (
'NDHM', 'Nando''s', 'FC', 'Vilakazi', 'BZ', 'Ex', 'F', '0836673132', 'Highveld Mall', 3, NULL);

INSERT INTO f_restaurant VALUES (
'NDKF', 'Nando''s', 'FC', 'VILJOEN', 'HMB', 'No', 'M', '0843672335', 'Klipfontein', 3, NULL);

/*= 3 : F_CATEGORY =================================================================================
CatCode C(2)   CatDesc V2(20)
'12', '123456789'
==================================================================================================*/

INSERT INTO f_category VALUES (
'IC', 'Ice-Cream');

INSERT INTO f_category VALUES (
'ML', 'Meal');

INSERT INTO f_category VALUES (
'SS', 'Sushi');

INSERT INTO f_category VALUES (
'ST', 'Starter');

INSERT INTO f_category VALUES (
'FS', 'Fish');

INSERT INTO f_category VALUES (
'BG', 'Burger');

INSERT INTO f_category VALUES (
'SD', 'Side');

INSERT INTO f_category VALUES (
'DR', 'Drink');

INSERT INTO f_category VALUES (
'PZ', 'Pizza');

/*= 4 : F_RMItem ====================================================================================
RMItem N(4)    ItemDesc V2(30)   ItemPrice N(5,2)  RCode C(4)   CatCode C(2)
1234, '111111111122222222221234567890', 123.12 , '1234', '12'
==================================================================================================*/

INSERT INTO f_RMItem VALUES (
1, 'Platter for 2', 179.95, 'OBHM', 'SS');

INSERT INTO f_RMItem VALUES (
2, 'Shipmate''s Platter', 265.95, 'OBHM', 'SS');

INSERT INTO f_RMItem VALUES (
3, 'Fresh Oysters 6 piece', 89.95, 'OBHM', 'ST');

INSERT INTO f_RMItem VALUES (
4, 'Garlic Mussel Pot', 65.99, 'OBHM', 'ST');

INSERT INTO f_RMItem VALUES (
5, 'Garlic Snails', 69.95, 'OBHM', 'ST');

INSERT INTO f_RMItem VALUES (
6, 'California Rolls 4 piece', 49, 'OBHM', 'SS');

INSERT INTO f_RMItem VALUES (
7, 'California Rolls 8 piece', 83, 'OBHM', 'SS');

INSERT INTO f_RMItem VALUES (
8, 'Fried Prawn 2 piece', 48, 'OBHM', 'SS');

INSERT INTO f_RMItem VALUES (
9, 'Fried Prawn 4 piece', 85, 'OBHM', 'SS');

INSERT INTO f_RMItem VALUES (
10, 'Tempura Rock Shrimp 2 piece', 42, 'OBHM', 'SS');

INSERT INTO f_RMItem VALUES (
11, 'Tempura Rock Shrimp 4 piece', 76, 'OBHM', 'SS');

INSERT INTO f_RMItem VALUES (
12, '200ml Lique Fruit', 13.50, 'OBHM', 'DR');

INSERT INTO f_RMItem VALUES (
13, '300ml Soda Drink', 18.50, 'OBHM', 'DR');

INSERT INTO f_RMItem VALUES (
14, 'Cappuccino with Cream', 25.90, 'OBHM', 'DR');

INSERT INTO f_RMItem VALUES (
15, '300ml Black Label', 22.50, 'OBHM', 'DR');

INSERT INTO f_RMItem VALUES (
16, '440ml Windhoek Draught', 35.90, 'OBHM', 'DR');

INSERT INTO f_RMItem VALUES (
17, '330ml Miller Draught', 32.50, 'OBHM', 'ST');

INSERT INTO f_RMItem VALUES (
18, 'Famous Fish and Chips', 69.95, 'OBHM', 'ML');

INSERT INTO f_RMItem VALUES (
19, 'Grilled Tuna and Chips', 83.95, 'OBHM', 'ML');

INSERT INTO f_RMItem VALUES (
20, 'Famous Fish and Chips with Veg', 74.95, 'OBHM', 'ML');

INSERT INTO f_RMItem VALUES (
21, 'Catch of the Day with Chips', 89.95, 'OBHM', 'ML');

INSERT INTO f_RMItem VALUES (
22, '3 Piece Chicken Wings', 28.95, 'NDKF', 'SD');

INSERT INTO f_RMItem VALUES (
23, 'Chicken Livers', 44.90, 'NDKF', 'ST');

INSERT INTO f_RMItem VALUES (
24, 'Chicken Livers and Pap', 49.50, 'NDKF', 'ML');

INSERT INTO f_RMItem VALUES (
25, '1/4 Chicken without Peri-Peri', 38.95, 'NDKF', 'SD');

INSERT INTO f_RMItem VALUES (
26, '1/2 Chicken Fried', 55.95, 'NDKF', 'SD');

INSERT INTO f_RMItem VALUES (
27, '1/4 Chicken with Peri-Peri', 38.95, 'NDKF', 'SD');

INSERT INTO f_RMItem VALUES (
28, '6 Piece Chicken Wings', 52.95, 'NDKF', 'SD');

INSERT INTO f_RMItem VALUES (
29, 'Pulled Chicken Burger', 35, 'NDKF', 'BG');

INSERT INTO f_RMItem VALUES (
30, 'Chicken Burger', 52.00, 'NDKF', 'BG');

INSERT INTO f_RMItem VALUES (
31, 'Chicken Livers with Rice', 49.50, 'NDKF', 'ML');

INSERT INTO f_RMItem VALUES (
32, 'Double Crunch', 39.90, 'KFCT', 'BG');

INSERT INTO f_RMItem VALUES (
33, 'Snack Burger', 16.90, 'KFCT', 'BG');

INSERT INTO f_RMItem VALUES (
34, 'Chicken Burger', 36.90, 'KFCT', 'BG');

INSERT INTO f_RMItem VALUES (
35, 'Streetwise 3 with Chips', 39.90, 'KFCT', 'ML');

INSERT INTO f_RMItem VALUES (
36, 'Streetwise 5 with Chips', 56.90, 'KFCT', 'ML');

INSERT INTO f_RMItem VALUES (
37, 'Bucket 25 piece', 209.95, 'KFCT', 'ML');

INSERT INTO f_RMItem VALUES (
38, '1 Piece Chicken', 12.95, 'KFCT', 'SD');

INSERT INTO f_RMItem VALUES (
39, 'Zinger Wings 6 piece', 42.95, 'KFCT', 'SD');

INSERT INTO f_RMItem VALUES (
40, '3 Piece with Chips', 35.90, 'KFCT', 'BG');

INSERT INTO f_RMItem VALUES (
41, 'Oreo Crusher', 26.90, 'KFCT', 'IC');

INSERT INTO f_RMItem VALUES (
42, 'Soft Twist', 5.90, 'KFCT', 'IC');

INSERT INTO f_RMItem VALUES (
43, 'Mixed Berry Sundae', 17.90, 'KFCT', 'IC');

INSERT INTO f_RMItem VALUES (
44, 'Lique Fruit', 12.90, 'KFCT', 'DR');

INSERT INTO f_RMItem VALUES (
45, '2L Soda', 26.90, 'KFCT', 'DR');

INSERT INTO f_RMItem VALUES (
46, '300ml Soda', 18.50, 'KFCT', 'DR');

INSERT INTO f_RMItem VALUES (
47, 'Fiery Whopper', 36.90, 'BKMP', 'BG');

INSERT INTO f_RMItem VALUES (
48, 'Double Whopper with Cheese', 65.90, 'BKMP', 'BG');

INSERT INTO f_RMItem VALUES (
49, 'Whopper with Cheese', 45.90, 'BKMP', 'BG');

INSERT INTO f_RMItem VALUES (
50, 'Cheese Burger', 44.90, 'BKMP', 'BG');

INSERT INTO f_RMItem VALUES (
51, 'Chicken Burger', 42.90, 'BKMP', 'BG');

INSERT INTO f_RMItem VALUES (
52, 'Chilli Cheese Burger', 46.90, 'BKMP', 'BG');

INSERT INTO f_RMItem VALUES (
53, 'Chicken Burger Delux', 48.95, 'BKMP', 'BG');

INSERT INTO f_RMItem VALUES (
54, 'Chilli Cheese Chicken Burger', 46.95, 'BKMP', 'BG');

INSERT INTO f_RMItem VALUES (
55, 'Chicken Burger with Cheese', 45.90, 'BKMP', 'BG');

INSERT INTO f_RMItem VALUES (
56, 'KitKat Cone', 7.00, 'BKMP', 'IC');

INSERT INTO f_RMItem VALUES (
57, 'Bar-One Wafer', 9.50, 'BKMP', 'IC');

INSERT INTO f_RMItem VALUES (
58, 'Peperement Crisp Log', 9.50, 'BKMP', 'IC');

INSERT INTO f_RMItem VALUES (
59, 'Loaded Fries with Chillies', 25.90, 'BKMP', 'SD');

INSERT INTO f_RMItem VALUES (
60, 'S Margharita', 35.9, 'CCHM', 'PZ');

INSERT INTO f_RMItem VALUES (
61, 'M Margharita', 48.95, 'CCHM', 'PZ');

INSERT INTO f_RMItem VALUES (
62, 'L Margharita', 67.95, 'CCHM', 'PZ');

INSERT INTO f_RMItem VALUES (
63, 'S Chicken and Mayo', 42.95, 'CCHM', 'PZ');

INSERT INTO f_RMItem VALUES (
64, 'M Chicken and Mayo', 58.95, 'CCHM', 'PZ');

INSERT INTO f_RMItem VALUES (
65, 'X Chicken and Mayo', 72.95, 'CCHM', 'PZ');

/*=  5 : F_CUSTOMER =================================================================================
Cno N(5)   MemberOf N(5)   SURNAME  V2(13)   FName V2(8)   straddr  V2(20)   suburb V2(12)   cellNo C(10)   cType C   JoinDate D
12345, 12345, '1111111110123', '12345678', '111111111012345', '111111111012', '1234567890', '1' 
==================================================================================================*/

INSERT INTO f_customer VALUES (
10001, NULL, 'NKOSI', 'Happy', '15 Wattle Street', 'Model Park', '0835447676', 'L', '12-DEC-2017');

INSERT INTO f_customer VALUES (
10002, NULL, 'MALHERBE', 'Benjamin', '2362 Poplar Street', 'Model Park', '0845668231', 'L', '18-DEC-2017');

INSERT INTO f_customer VALUES (
10003, NULL, 'PHUDI', 'Thabo', '3562 Els Street', 'Die Heuwel', '0713358234', 'L', '23-MAR-2018');

INSERT INTO f_customer VALUES (
10004, NULL, 'NKOSI', 'Milton', '1435 Rachel Street', 'Die Heuwel', '0823358876', 'P', '15-APR-2018');

INSERT INTO f_customer VALUES (
10005, 10002, 'MALHERBE', 'Susanna', NULL, NULL, '0836672323', 'O', '15-JUN-2018');

INSERT INTO f_customer VALUES (
10006, NULL, 'RADINGOANA', 'Johnny Boy', '12 Dora Street', 'Riverview', '0722245897', 'O', '17-JUL-2018');

INSERT INTO f_customer VALUES (
10007, NULL, 'MAGAGULA', 'Pretty', '877 Frans Street', 'Fransville', '0713447233', 'L', '09-OCT-2018');

INSERT INTO f_customer VALUES (
10008, NULL, 'BALOY', 'Gentleman', '756 Dora Street', 'Riverview', '082394592', 'O', '13-NOV-2018');

INSERT INTO f_customer VALUES (
10009, NULL, 'DICKSON', 'Master', '599 Dixon Street', 'Reyno Ridge', '0838568922', 'L', '08-JAN-2019');

INSERT INTO f_customer VALUES (
10010, NULL, 'BOTHA', 'Rachel', '2233 Rachel Street', 'Die Heuwel', '0719985642', 'O', '09-JAN-2019');

INSERT INTO f_customer VALUES (
10011, NULL, 'DE WET', 'Klaas', '123 Loraine Street', 'Del Judor', '0719982443', 'O', '28-FEB-2019');

INSERT INTO f_customer VALUES (
10012, NULL, 'MASHABA', 'Lazarus', '99 Dreyer Street', 'Riverview', '0847782312', 'L', '15-APR-2019');

INSERT INTO f_customer VALUES (
10013, 10007, 'MAGAGULA', 'Innocent', NULL, NULL, '0723667244', 'P', '15-JUN-2019');

INSERT INTO f_customer VALUES (
10014, NULL, 'MANGWALE', 'Innocent', '13 Acacia Street', 'Die Heuwel', '0736658989', 'C', '23-AUG-2019');

INSERT INTO f_customer VALUES (
10015, NULL, 'MALHERBE', 'Louis', '2323 Louis Street', 'Riverview', '0848892323', 'L', '23-SEP-2019');

INSERT INTO f_customer VALUES (
10016, 10012, 'MASHABA', 'Herman', '345 Orion Street', 'Reyno Ridge', '0928892323', NULL, '09-OCT-2019');

INSERT INTO f_customer VALUES (
10017, NULL, 'STRYDOM', 'Lucinda', '2233 Leo Street', 'Reyno Ridge', '0712339675', 'O', '29-OCT-2019');

INSERT INTO f_customer VALUES (
10018, NULL, 'XABA', 'Xolisi', '2333 Ursula Street', 'Del Judor', '0729987676', 'C', '16-DEC-2019');

INSERT INTO f_customer VALUES (
10019, 10012, 'MASHABA', 'Sarah', NULL, NULL, '0838897755', 'P', '25-DEC-2019');

INSERT INTO f_customer VALUES (
10020, NULL, 'ZITHA', 'Sibongile', '1001 Judy Street', 'Fransville', '0843448778', 'O', '31-DEC-2019');

INSERT INTO f_customer VALUES (
10021, NULL, 'MONARENG', 'Cora', '1212 Cora Street', 'Fransville', '0926565788', 'C', '01-JAN-2020');

INSERT INTO f_customer VALUES (
10022, 10009, 'DIXON', 'Marianne', NULL, NULL, '0823889766', 'O', '01-JAN-2020');

INSERT INTO f_customer VALUES (
10023, NULL, 'MTHETHWA', 'Emmanuelle', '99 Liberty Street', 'Reyno Ridge', '0836778334', 'O', '09-JAN-2020');

INSERT INTO f_customer VALUES (
10024, NULL, 'NKOSI', 'Liberty', '2323 Louis Street', 'Riverview', '0723447823', 'N', '15-JAN-2020');

INSERT INTO f_customer VALUES (
10025, NULL, 'BARLOW', 'Nicky', '23 Pentalin Street', 'Marelden', '0846775289', 'O', '18-JAN-2020');

INSERT INTO f_customer VALUES (
10026, NULL, 'XABA', 'Susan', '879 Barlow Street', 'Riverview', '0712338723', 'O', '01-FEB-2020');

INSERT INTO f_customer VALUES (
10027, NULL, 'VENTER', 'Danie', '99 Susanna Street', 'Fransville', '0723889423', 'O', '02-FEB-2020');


/*= 6 : F_PAYTYPE ===================================================================================
pTCode C(2)   pTDesc V2(20)
'12', '11111111101234567890'
==================================================================================================*/

INSERT INTO f_paytype VALUES('CA','Cash');
INSERT INTO f_paytype VALUES('CH','Cheque');
INSERT INTO f_paytype VALUES('ET','Electronic Transfer');
INSERT INTO f_paytype VALUES('CC','Credit Card');

/*= 7 : F_DRIVERSLICENSE ===========================================================================
DLCode V2(2)   DLDesc V2(16)
'12', '1111111110123456'
==================================================================================================*/

INSERT INTO f_driverlicense VALUES('A','Motorbike<125cc');

INSERT INTO f_driverlicense VALUES('A1','Motorbike>=125cc');

INSERT INTO f_driverlicense VALUES('B','Motorcar');

INSERT INTO f_driverlicense VALUES('C1','Light Truck');

/*= 8 F_DELIVERYMAN ===============================================================================
DMCellno C(10) SURNAME V2(7)   fnames V2(14)   IdNo V2(13)   DLCode V2(2)	
'1234567890', '1234567', '11111111101234', '1111111110123', '12'
==================================================================================================*/

INSERT INTO f_deliveryman VALUES(
'0844444444', 'MARAIS', 'Pierre John', '5810093186745', 'C1');

INSERT INTO f_deliveryman VALUES(
'0833333333', 'NKOSI', 'Blessing', '6105240056089', 'A1');

INSERT INTO f_deliveryman VALUES(
'0833333339', 'MASINA', 'Happy Sunshine', '8910290034578', 'A1');

INSERT INTO f_deliveryman VALUES(
'0711111111', 'MASINGA', 'Susan Poppy', '8310230897239', 'B');

INSERT INTO f_deliveryman VALUES(
'0722222222', 'NELSON', 'Susan Sanny', '9801016755089', 'B');

INSERT INTO f_deliveryman VALUES(
'0833333338', 'MALINGA', 'Nelson Happy', '9905240056098', 'A');

/*= 9 : F_ORDER =================================================================================================
ONo N(3)   ODateTime DATE   Cno N(5)   pTCode C(2)   DMCellno C(10)   Delivered C   Collect C
12345, 'DD-MON-YYYY HH24:MI', 12345, '12', '1234567890', '1', '1'
==================================================================================================*/

INSERT INTO f_order VALUES(
100, TO_DATE('16-DEC-2017 17:15','DD-MON-YYYY HH24:MI'), 10001, 'CA', '0833333333', 'Y',      'N');

INSERT INTO f_order VALUES(
101, TO_DATE('25-DEC-2017 20:30','DD-MON-YYYY HH24:MI'), 10001, 'CC', NULL,               NULL, 'Y');

INSERT INTO f_order VALUES(
102, TO_DATE('25-DEC-2017 20:35','DD-MON-YYYY HH24:MI'), 10002, 'CA', NULL,               NULL, 'Y');

INSERT INTO f_order VALUES(
103, TO_DATE('15-APR-2018 17:35','DD-MON-YYYY HH24:MI'), 10004, 'CH', '0722222222', NULL, 'N');

INSERT INTO f_order VALUES(
104, TO_DATE('15-JUN-2018 20:15','DD-MON-YYYY HH24:MI'), 10009, 'ET', '0833333338', 'Y',      'N');

INSERT INTO f_order VALUES(
105, TO_DATE('08-JUL-2018 16:20','DD-MON-YYYY HH24:MI'), 10009, 'CC', '0833333333', 'Y',      'N');

INSERT INTO f_order VALUES(
106, TO_DATE('12-JUL-2018 12:30','DD-MON-YYYY HH24:MI'), 10010, 'CA', '0844444444', 'Y',     'N');

INSERT INTO f_order VALUES(
107, TO_DATE('25-JUL-2018 17:30','DD-MON-YYYY HH24:MI'), 10002, 'CA', '0722222222', 'Y',     'N');

INSERT INTO f_order VALUES(
108, TO_DATE('01-AUG-2018 09:45','DD-MON-YYYY HH24:MI'), 10007, 'ET', '0833333338', 'Y',   'N');

INSERT INTO f_order VALUES(
109, TO_DATE('23-SEP-2018 13:05','DD-MON-YYYY HH24:MI'), 10004, 'CA', '0844444444', 'Y',   'N');

INSERT INTO f_order VALUES(
110, TO_DATE('08-JAN-2019 14:09','DD-MON-YYYY HH24:MI'), 10002, 'ET', '0833333338', 'Y',    'N');

INSERT INTO f_order VALUES(
111, TO_DATE('15-APR-2019 21:45','DD-MON-YYYY HH24:MI'), 10012, 'CA', '0833333339', 'Y',    'N');

INSERT INTO f_order VALUES(
112, TO_DATE('16-AUG-2019 09:50','DD-MON-YYYY HH24:MI'), 10007, 'CA', '0844444444', 'Y',    'N');

INSERT INTO f_order VALUES(
113, TO_DATE('23-AUG-2019 21:30','DD-MON-YYYY HH24:MI'), 10014, 'CA', NULL,               NULL, 'Y');

INSERT INTO f_order VALUES(
114, TO_DATE('26-AUG-2019 22:35','DD-MON-YYYY HH24:MI'), 10015, 'CC', '0844444444', 'Y',     'N');

INSERT INTO f_order VALUES(
115, TO_DATE('31-AUG-2019 12:35','DD-MON-YYYY HH24:MI'), 10005, 'CA', '0833333339', 'Y',    'N');

INSERT INTO f_order VALUES(
116, TO_DATE('31-AUG-2019 10:22','DD-MON-YYYY HH24:MI'), 10015, 'ET', '0844444444', 'Y',     'N');

INSERT INTO f_order VALUES(
117, TO_DATE('11-SEP-2019 14:17','DD-MON-YYYY HH24:MI'), 10014, 'CC', NULL,                NULL, 'Y');

INSERT INTO f_order VALUES(
118, TO_DATE('09-OCT-2019 17:56','DD-MON-YYYY HH24:MI'), 10016, 'CH', '0722222222', 'Y',      'N');

INSERT INTO f_order VALUES(
119, TO_DATE('25-DEC-2019 11:35','DD-MON-YYYY HH24:MI'), 10002, 'CC', '0722222222', NULL, 'N');

INSERT INTO f_order VALUES(
120, TO_DATE('25-DEC-2019 11:45','DD-MON-YYYY HH24:MI'), 10019, 'CC', '0833333338', NULL, 'Y');

INSERT INTO f_order VALUES(
121, TO_DATE('31-DEC-2019 23:45','DD-MON-YYYY HH24:MI'), 10014, 'CA', '0711111111', 'Y',     'N');

INSERT INTO f_order VALUES(
122, TO_DATE('06-JAN-2020 12:30','DD-MON-YYYY HH24:MI'), 10021, 'CA', '0711111111', 'Y',      'N');

INSERT INTO f_order VALUES(
123, TO_DATE('08-JAN-2020 17:55','DD-MON-YYYY HH24:MI'), 10022, 'CA', NULL,               NULL, 'Y');

INSERT INTO f_order VALUES(
124, TO_DATE('15-JAN-2020 18:55','DD-MON-YYYY HH24:MI'), 10013, 'CC', NULL,               NULL, 'Y');

INSERT INTO f_order VALUES(
125, TO_DATE('22-JAN-2020 19:52','DD-MON-YYYY HH24:MI'), 10016, 'ET', '0844444444', NULL, 'N');


/*= 9 : F_ORDITEM ==================================================================================
ONo N(3)   OItem N(1)   RMItem# N(4)   quantity N(2)   
123, 1, 1234, 12
==================================================================================================*/

INSERT INTO f_orditem VALUES(
100, 1, 1, 1);

INSERT INTO f_orditem VALUES(
100, 2, 3, 2);

INSERT INTO f_orditem VALUES(
100, 3, 16, 2);

INSERT INTO f_orditem VALUES(
101, 1, 23, 1);

INSERT INTO f_orditem VALUES(
101, 2, 30, 1);

INSERT INTO f_orditem VALUES(
102, 1, 34, 3);

INSERT INTO f_orditem VALUES(
102, 2, 35, 3);

INSERT INTO f_orditem VALUES(
102, 3, 45, 2);

INSERT INTO f_orditem VALUES(
102, 4, 43, 1);

INSERT INTO f_orditem VALUES(
102, 5, 46, 1);

INSERT INTO f_orditem VALUES(
103, 1, 48, 1);

INSERT INTO f_orditem VALUES(
103, 2, 59, 1);

INSERT INTO f_orditem VALUES(
104, 1, 62, 1);

INSERT INTO f_orditem VALUES(
104, 2, 16, 2);

INSERT INTO f_orditem VALUES(
105, 1, 53, 3);

INSERT INTO f_orditem VALUES(
105, 2, 56, 2);

INSERT INTO f_orditem VALUES(
105, 3, 57, 1);

INSERT INTO f_orditem VALUES(
106, 1, 17, 6);

INSERT INTO f_orditem VALUES(
107, 1, 52, 1);

INSERT INTO f_orditem VALUES(
108, 1, 18, 2);

INSERT INTO f_orditem VALUES(
108, 2, 13, 2);

INSERT INTO f_orditem VALUES(
109, 1, 47, 2);

INSERT INTO f_orditem VALUES(
109, 2, 59, 2);

INSERT INTO f_orditem VALUES(
110, 1, 64, 1);

INSERT INTO f_orditem VALUES(
110, 2, 62, 1);

INSERT INTO f_orditem VALUES(
111, 1, 54, 4);

INSERT INTO f_orditem VALUES(
112, 1, 47, 1);

INSERT INTO f_orditem VALUES(
112, 2, 39, 1);

INSERT INTO f_orditem VALUES(
112, 3, 52, 1);

INSERT INTO f_orditem VALUES(
113, 1, 36, 1);

INSERT INTO f_orditem VALUES(
113, 2, 46, 1);

INSERT INTO f_orditem VALUES(
114, 1, 5, 1);

INSERT INTO f_orditem VALUES(
114, 2, 20, 1);

INSERT INTO f_orditem VALUES(
115, 1, 53, 1);

INSERT INTO f_orditem VALUES(
116, 1, 40, 2);

INSERT INTO f_orditem VALUES(
116, 2, 56, 2);

INSERT INTO f_orditem VALUES(
117, 1, 2, 2);

INSERT INTO f_orditem VALUES(
117, 2, 17, 12);

INSERT INTO f_orditem VALUES(
118, 1, 27, 2);

INSERT INTO f_orditem VALUES(
119, 1, 25, 4);

INSERT INTO f_orditem VALUES(
119, 2, 13, 4);

INSERT INTO f_orditem VALUES(
120, 1, 48, 3);

INSERT INTO f_orditem VALUES(
120, 2, 59, 3);

INSERT INTO f_orditem VALUES(
120, 3, 57, 3);
INSERT INTO f_orditem VALUES(
121, 1, 4, 2);

INSERT INTO f_orditem VALUES(
121, 2, 8, 2);

INSERT INTO f_orditem VALUES(
121, 3, 6, 2);

INSERT INTO f_orditem VALUES(
121, 4, 15, 2);

INSERT INTO f_orditem VALUES(
121, 5, 14, 2);

INSERT INTO f_orditem VALUES(
122, 1, 37, 1);

INSERT INTO f_orditem VALUES(
122, 2, 17, 12);

INSERT INTO f_orditem VALUES(
123, 1, 52, 2);

INSERT INTO f_orditem VALUES(
123, 2, 43, 2);

INSERT INTO f_orditem VALUES(
123, 3, 64, 1);

INSERT INTO f_orditem VALUES(
124, 1, 21, 6);

INSERT INTO f_orditem VALUES(
124, 2, 8, 6);

INSERT INTO f_orditem VALUES(
124, 3, 3, 6);

INSERT INTO f_orditem VALUES(
125, 1, 19, 4);

/* #-#-#-#-#_#-#-#-#-#_#-#-#-#-#_#-#-#-#-#_#-#-#-#-#_#-#-#-#-#_#-#-#-#-#_#-#-#-#-#_#-#-#-#-#_#-#-#-#-#_#-#-#-#-#_ */

COMMIT;
 
/* -------------------------------1--------------------------------*/
COL initials FORMAT A8

SELECT OwnerID "OwnerId", Surname "Surname", Initials "Initials", CellNo "CellNo", EMail "EMail"
FROM f_owner;

/* -------------------------------2--------------------------------*/
COL rcode 	FORMAT A5
COL rtype 	FORMAT A5
COL mgrinitials 	FORMAT A11
COL mgrclass	FORMAT A9
COL sex		FORMAT A4

SELECT RCode "RCode", Name "Name", RType "RType", MgrSurname "MgrSurname", 
MgrInitials "MgrInitials", MgrClass "MgrClass", Sex "Sex", PhoneNo "PhoneNo", Location "Location", 
OwnerId "OwnerId", RecommendedBy "RecommendedBy"
FROM f_restaurant;

/* -------------------------------3-------------------------------*/
COL  catcode FORMAT A7

SELECT CatCode "CatCode", CatDesc "CatDesc"
FROM f_category;

/* -------------------------------4-------------------------------*/

SELECT rmitem# "RMItem", ItemDesc "ItemDesc", ItemPrice "ItemPrice", RCode "RCode", CatCode "CatCode"	 
FROM f_rmitem;

/* -------------------------------5-------------------------------*/
COL  ctype     	FORMAT A5

SELECT Cno "CNo", MemberOf "MemberOf", Surname "Surname", FName "FName", StrAddr "StrAddr",
Suburb "Suburb", CellNo "CellNo", CType "CType", TO_CHAR(JoinDate, 'DD-MON-YYYY') "JoinDate"
FROM f_customer;

/* -------------------------------6--------------------------------*/
COL ptcode FORMAT A6

SELECT PTCode "PTCode", PTDesc "PTDesc"
FROM F_paytype;

/* -------------------------------7--------------------------------*/
COL  dlcode FORMAT A6

SELECT DLCode "DLCode", DLDesc "DLDesc"
FROM f_driverlicense;

/* -------------------------------8--------------------------------*/
COL  FORMAT A

SELECT DMCellNo "DMCellNo", surname "Surname", FNames "FNames", IdNo "IdNo", DLCode "DLCode"
FROM f_deliveryman;

/* -------------------------------9--------------------------------*/
COL ono 		FORMAT A4
COL odatetime 	FORMAT A17
COL cno 		FORMAT A6
COL ptcode	FORMAT A6
COL delivered 	FORMAT A9
COL collect	FORMAT A7

SELECT TO_CHAR(ONo,'999') "ONo", TO_CHAR(ODATEtime,'DD-MON-YYYY HH24:MI') "ODateTime",
TO_CHAR(CNo,'99999') "CNo", PTCode "PTCode", DMCellNo "DMCellNo", Delivered "Delivered", Collect "Collect"
FROM f_order;

/* -------------------------------10-------------------------------*/
COL ono 		FORMAT A4
COL oitem 	FORMAT A6
COL rmitem#  	FORMAT A9
COL quantity  	FORMAT A9

SELECT TO_CHAR(ONo,999) "ONo", TO_CHAR(OItem,99999) "OItem", 
TO_CHAR(RMItem#,99999999) "RMItem#", TO_CHAR(quantity,99999999) "Quantity"
FROM f_orditem;

