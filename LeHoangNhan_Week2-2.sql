
-- CREATE TABLES --
create table CAMPUS (
    CampusID varchar2(5),
    CampusName varchar2(100),
    Street varchar2(100),
    City varchar2(100),
    State varchar2(100),
    Zip varchar2(100),
    Phone varchar2(100),
    CampusDiscount decimal(2,2),
    
    Constraint pk_campus primary key (CampusID)
);
CREATE SEQUENCE pk_campus START WITH 1;

create table POSITION (
    PositionID varchar2(5),
    POSITION varchar2(100),
    YearlyMembershipFee decimal(7,2),
    
    Constraint pk_position primary key (PositionID)

);
CREATE SEQUENCE pk_position START WITH 1;

create table MEMBERS (
    MemberID varchar2(5),
    LastName varchar2(100),
    FirstName varchar2(100),
    CampusAddress varchar2(100),
    CampusPhone varchar2(100),
    CampusID varchar2(5),
    PositionID varchar2(5),
    ContractDuration integer,
    
    Constraint pk_member primary key (MemberID),
    Constraint fk_member_campus foreign key (CampusID) references CAMPUS(CampusID),
    Constraint fk_member_position foreign key (PositionID) references POSITION(PositionID)
);
CREATE SEQUENCE pk_member START WITH 1;

create table PRICES (
    FoodItemTypeID varchar2(5),
    MealType varchar2(100),
    MealPrice decimal(7,2),

    Constraint pk_price primary key (FoodItemTypeID)
);
CREATE SEQUENCE pk_price START WITH 1;

create table FOODITEMS (
    FoodItemID varchar2(5),
    FoodItemName varchar2(100),
    FoodItemTypeID varchar2(5),


    Constraint pk_fooditem primary key (FoodItemID),
    Constraint pk_fooditem_price foreign key (FoodItemTypeID) references PRICES(FoodItemTypeID)
);
CREATE SEQUENCE pk_fooditem START WITH 10001;

create table ORDERS (
    OrderID varchar2(5),
    MemberID varchar2(5),
    OrderDate varchar(25),

    Constraint pk_order primary key (OrderID),
    Constraint pk_order_memeber foreign key (MemberID) references MEMBERS(MemberID)
);
CREATE SEQUENCE pk_order START WITH 1;

create table ORDERLINE (
    OrderID varchar2(5),
    FoodItemID varchar2(5),
    Quantity integer,

    Constraint pk_orderline primary key (OrderID, FoodItemID),
    Constraint pk_orderline_order foreign key (OrderID) references ORDERS(OrderID),
    Constraint pk_orderline_fooditem foreign key (FoodItemID) references FOODITEMS(FoodItemID)
);
CREATE SEQUENCE pk_orderline START WITH 1;


-- INSERT DATA --
insert into CAMPUS values (TO_CHAR(PK_CAMPUS.nextval),'IUPUI', '425 University Blvd.', 'Indianapolis', 'IN','46202', 'tel:3172744591',.08);
insert into CAMPUS values (TO_CHAR(PK_CAMPUS.nextval),'Indiana University', '107 S. Indiana Ave.', 'Bloomington', 'IN','47405', 'tel:8128554848',.07);
insert into CAMPUS values (TO_CHAR(PK_CAMPUS.nextval),'Purdue University', '475 Stadium Mall Drive', 'West Lafayette', 'IN', '47907', 'tel:7654941776',.06);

insert into POSITION values (TO_CHAR(PK_POSITION.nextval),'Lecturer', 1050.50);
insert into POSITION values (TO_CHAR(PK_POSITION.nextval),'Associate Professor', 900.50);
insert into POSITION values (TO_CHAR(PK_POSITION.nextval),'Assistant Professor', 875.50);
insert into POSITION values (TO_CHAR(PK_POSITION.nextval),'Professor', 700.75);
insert into POSITION values (TO_CHAR(PK_POSITION.nextval), 'Full Professor', 500.50);

insert into MEMBERS values (TO_CHAR(PK_MEMBER.NEXTVAL), 'Ellen', 'Monk', '009 Purnell', 'tel:8121231234', '2', '5', 12);
insert into MEMBERS values (TO_CHAR(PK_MEMBER.NEXTVAL), 'Joe', 'Brady', '008 Statford Hall', 'tel:7652342345', '3', '2', 10);
insert into MEMBERS values (TO_CHAR(PK_MEMBER.NEXTVAL),'Dave', 'Davidson', '007 Purnell', 'tel:8123453456', '2', '3', 10);
insert into MEMBERS values (TO_CHAR(PK_MEMBER.NEXTVAL),'Sebastian', 'Cole', '210 Rutherford Hall', 'tel:7652342345', '3', '5', 10);
insert into MEMBERS values (TO_CHAR(PK_MEMBER.NEXTVAL),'Michael', 'Doo', '66C Peobody', 'tel:8125488956', '2', '1', 10);
insert into MEMBERS values (TO_CHAR(PK_MEMBER.NEXTVAL),'Jerome', 'Clark', 'SL 220', 'tel:3172749766', '1', '1', 12);
insert into MEMBERS values (TO_CHAR(PK_MEMBER.NEXTVAL), 'Bob', 'House', 'ET 329', 'tel:3172789098', '1', '4', 10);
insert into MEMBERS values (TO_CHAR(PK_MEMBER.NEXTVAL), 'Bridget','Stanley', 'SI 234', 'tel:3172745678', '1', '1', 12);
insert into MEMBERS values (TO_CHAR(PK_MEMBER.NEXTVAL),'Bradley', 'Wilson', '334 Statford Hall', 'tel:7652582567', '3', '2', 10);

insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'Lager', '1');
insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'Red Wine', '1');
insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'White Wine', '1');
insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'Coke', '4');
insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'Coffee', '4');
insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'Chicken a la King', '3');
insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'Rib Steak', '3');
insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'Fish and Chips', '3');
insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'Veggie Delight', '3');
insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'Chocolate Mousse', '2');
insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'Carrot Cake', '2');
insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'Fruit Cup', '2');
insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'Fish and Chips', '5');
insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'Angus Beef Burger', '5');
insert into fooditems values (TO_CHAR(PK_FOODITEM.NEXTVAL), 'Cobb Salad', '5');


insert into prices values (TO_CHAR(PK_PRICE.NEXTVAL),'Beer/Wine', 5.50);
insert into prices values (TO_CHAR(PK_PRICE.NEXTVAL), 'Dessert', 2.75);
insert into prices values (TO_CHAR(PK_PRICE.NEXTVAL),'Dinner', 15.50);
insert into prices values (TO_CHAR(PK_PRICE.NEXTVAL),'Soft Drink', 2.50);
insert into prices values (TO_CHAR(PK_PRICE.NEXTVAL),'Lunch', 7.25);


insert into orders values (TO_CHAR(PK_ORDER.NEXTVAL), '9', 'March 5, 2005');
insert into orders values (TO_CHAR(PK_ORDER.NEXTVAL), '8', 'March 5, 2005');
insert into orders values (TO_CHAR(PK_ORDER.NEXTVAL), '7', 'March 5, 2005');
insert into orders values (TO_CHAR(PK_ORDER.NEXTVAL), '6', 'March 7, 2005');
insert into orders values (TO_CHAR(PK_ORDER.NEXTVAL), '5', 'March 7, 2005');
insert into orders values (TO_CHAR(PK_ORDER.NEXTVAL), '4', 'March 10, 2005');
insert into orders values (TO_CHAR(PK_ORDER.NEXTVAL), '3', 'March 11, 2005');
insert into orders values (TO_CHAR(PK_ORDER.NEXTVAL), '2', 'March 12, 2005');
insert into orders values (TO_CHAR(PK_ORDER.NEXTVAL), '1', 'March 13, 2005');

insert into orderline values ('1','10001',1);
insert into orderline values ('1','10006',1);
insert into orderline values ('1','10012',1);
insert into orderline values ('2','10004',2);
insert into orderline values ('2','10013',1);
insert into orderline values ('2','10014',1);
insert into orderline values ('3','10005',1);
insert into orderline values ('3','10011',1);
insert into orderline values ('4','10005',2);
insert into orderline values ('4','10004',2);
insert into orderline values ('4','10006',1);
insert into orderline values ('4','10007',1);
insert into orderline values ('4','10010',2);
insert into orderline values ('5','10003',1);
insert into orderline values ('6','10002',2);
insert into orderline values ('7','10005',2);
insert into orderline values ('8','10005',1);
insert into orderline values ('8','10011',1);
insert into orderline values ('9','10001',1);


--CAU 1--
select * from user_constraints;

--CAU 2--
select table_name from user_tables;

--CAU 3--
select * from user_sequences;

--CAU 4--
select m.firstname, m.lastname, p.position, c.campusname, ROUND((p.yearlymembershipfee/ 12), 4) as Monthly_Dues
from members m 
join campus c on m.campusid = c.campusid
join position p on m.positionid = p.positionid
order by c.campusname desc, m.lastname asc;
