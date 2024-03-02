Create database ATM;
use ATM;

create table [User]
(
	[userId] int primary key,
	[name] varchar(20) not null,
	[phoneNum] varchar(15) not null,
	[city] varchar(20) not null
)

create table CardType
(
	[cardTypeID] int primary key,
	[name] varchar(15),
	[description] varchar(40) null
)

create Table [Card]
(
	cardNum Varchar(20) primary key,
	cardTypeID int foreign key references  CardType([cardTypeID]),
	PIN varchar(4) not null,
	[expireDate] date not null,
	balance float not null
)

Create table UserCard
(
	userID int foreign key references [User]([userId]),
	cardNum varchar(20) foreign key references [Card](cardNum),
	primary key(cardNum)
)

create table [Transaction]
(
	transId int primary key,
	transDate date not null,
	cardNum varchar(20) foreign key references [Card](cardNum),
	amount int not null
)

INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) 
VALUES (1, N'Ali', N'03036067000', N'Narowal')
GO

INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) 
VALUES (2, N'Ahmed', N'03036047000', N'Lahore')
GO

INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) 
VALUES (3, N'Aqeel', N'03036063000', N'Karachi')
GO

INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) 
VALUES (4, N'Usman', N'03036062000', N'Sialkot')
GO

INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) 
VALUES (5, N'Hafeez', N'03036061000', N'Lahore')
GO

INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) 
VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO

INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) 
VALUES (2, N'Credit', N'Spend Now, Pay later')
GO

INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) 
VALUES (N'1234', 1, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO

INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) 
VALUES (N'1235', 1, N'9234', CAST(N'2020-03-02' AS Date), 14425.62)
GO

INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance])
VALUES (N'1236', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO

INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) 
VALUES (N'1237', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO

INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) 
VALUES (N'1238', 2, N'9004', CAST(N'2020-09-02' AS Date), 34025.12)
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) 
VALUES (1, N'1234')
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) 
VALUES (1, N'1235')
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) 
VALUES (2, N'1236')
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) 
VALUES (3, N'1238')
GO

Insert  [dbo].[UserCard] ([userID], [cardNum]) 
VALUES (4, N'1237')

INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) 
VALUES (1, CAST(N'2017-02-02' AS Date), N'1234', 500)
GO

INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) 
VALUES (2, CAST(N'2018-02-03' AS Date), N'1235', 3000)
GO

INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) 
VALUES (3, CAST(N'2020-01-06' AS Date), N'1236', 2500)
GO

INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) 
VALUES (4, CAST(N'2016-09-09' AS Date), N'1238', 2000)
GO

INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) 
VALUES (5, CAST(N'2020-02-10' AS Date), N'1234', 6000)
GO

--Q1
select CT.cardTypeID, count(UC.userID) as Unique_Users
from CardType CT
join Card C ON C.cardTypeID = CT.cardTypeID
join UserCard UC ON C.cardNum = UC.cardNum
group by CT.cardTypeID

--Q2
select *
from UserCard UC
join Card C ON UC.cardNum = C.cardNum AND (C.balance > 20000 AND C.balance < 40000)
join [User] U ON U.userId = UC.userID

--Q3
select Distinct u.name as Names
from [User] u
except
select Distinct u.name as Names
from [User] u
Join UserCard uc ON u.userId = uc.userID

--Q3 (alternative)
select U.name
from [User] U

join

(select U.userId
from [User] U

except 

select UC.userID
from UserCard UC) Users_with_no_cards ON U.userId = Users_with_no_cards.userId

--Q4 (Join)
select distinct(C.cardTypeID), CT.name Card_type, U.name UserName
from [Transaction] T
join UserCard UC ON UC.cardNum = T.cardNum
join [Card] C ON C.cardNum = UC.cardNum
join CardType CT ON CT.cardTypeID = C.cardTypeID
join [User] U ON U.userId = UC.userID
where YEAR(T.transDate) != Year(GETDATE() - 1)

--Q5
select CT.cardTypeID, count(distinct(T.cardNum)) as Total_Cards
from CardType CT
left join [Card] C ON CT.cardTypeID = C.cardTypeID
join [Transaction] T ON T.cardNum = C.cardNum
where YEAR(T.transDate) >= 2017 AND YEAR(T.transDate) <= 2020	--to check the query year changed to in between 2017-2020
group by CT.cardTypeID, T.cardNum
having sum(T.amount) > 6000

--Q6
select U.userId, U.name, U.phoneNum, U.city
from [User] U
join [UserCard] uC ON U.userId = UC.userID
join [Card] C ON UC.cardNum = C.cardNum
where  DATEPART(DAYOFYEAR, C.expireDate) - DATEPART(DAYOFYEAR, GETDATE()) <= 90

--Q7
select U.userId, U.name
from [User] U
join [UserCard] UC ON U.userId = UC.userID
join [Card] C ON C.cardNum = UC.cardNum
group by U.userId, U.name
having sum(C.balance) > 50000

--Q8
select C.cardNum Card1, C1.cardNum Card2
from [Card] C, [Card] C1
where Year(C.expireDate) = Year(C1.expireDate) AND C.cardNum != C1.cardNum

--Q9
select U.name, U1.name
from [User] U, [User] U1
where U.name != U1.name
group by U.name, U1.name
having SUBSTRING(U.name, 1, 1) = SUBSTRING(U1.name, 1, 1)

--Q10
select U.userId, U.name
from [User] U
join UserCard UC ON U.userId = UC.userID
join [Card] C ON UC.cardNum = C.cardNum
where C.cardTypeID = 1 AND C.cardTypeID = 2

--Q11
select U.city, count(distinct(U.userId)) Total_Users, sum(C.balance) Sum_Of_Balance
from [User] U, [User] U1
join [UserCard] UC ON U1.userId = UC.userID
join [Card] C ON C.cardNum = UC.cardNum
where U.city = U1.city
group by U.city
having count(distinct(U.userId)) > 1

Select * from [User];
Select * from UserCard;
Select * from [Card];
Select * from CardType;
Select * from [Transaction];