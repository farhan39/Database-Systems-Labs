Create database ATM
go 
use ATM
go

create table [User](
[userId] int primary key,
[name] varchar(20) not null,
[phoneNum] varchar(15) not null,
[city] varchar(20) not null
)
go

create table CardType(
[cardTypeID] int primary key,
[name] varchar(15),
[description] varchar(40) null
)
go
create Table [Card](
cardNum Varchar(20) primary key,
cardTypeID int foreign key references  CardType([cardTypeID]),
PIN varchar(4) not null,
[expireDate] date not null,
balance float not null
)
go


Create table UserCard(
userID int foreign key references [User]([userId]),
cardNum varchar(20) foreign key references [Card](cardNum),
primary key(cardNum)
)
go
create table [Transaction](
transId int primary key,
transDate date not null,
cardNum varchar(20) foreign key references [Card](cardNum),
amount int not null
)


INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (1, N'Ali', N'03036067000', N'Narowal')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (2, N'Ahmed', N'03036047000', N'Lahore')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (3, N'Aqeel', N'03036063000', N'Karachi')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (4, N'Usman', N'03036062000', N'Sialkot')
GO
INSERT [dbo].[User] ([userId], [name], [phoneNum], [city]) VALUES (5, N'Hafeez', N'03036061000', N'Lahore')
GO


INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (2, N'Credit', N'Spend Now, Pay later')
GO

INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1234', 1, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1235', 1, N'9234', CAST(N'2020-03-02' AS Date), 14425.62)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1236', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1237', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1238', 2, N'9004', CAST(N'2020-09-02' AS Date), 34025.12)
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1234')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1235')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (2, N'1236')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (3, N'1238')
GO
Insert  [dbo].[UserCard] ([userID], [cardNum]) VALUES (4, N'1237')

INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (1, CAST(N'2017-02-02' AS Date), N'1234', 500)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (2, CAST(N'2018-02-03' AS Date), N'1235', 3000)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (3, CAST(N'2020-01-06' AS Date), N'1236', 2500)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (4, CAST(N'2016-09-09' AS Date), N'1238', 2000)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount]) VALUES (5, CAST(N'2020-02-10' AS Date), N'1234', 6000)
GO


Select * from [User]
Select * from UserCard
Select * from [Card]
Select * from CardType
Select * from [Transaction]

--Q1
CREATE FUNCTION GetCardBalance(@cardNum VARCHAR(20))
RETURNS FLOAT
AS
BEGIN
  DECLARE @balance FLOAT;
  SELECT @balance = balance FROM [Card] WHERE cardNum = @cardNum;
  RETURN @balance;
END

SELECT dbo.GetCardBalance('1234')

--Q2
CREATE FUNCTION dbo.GetUserDetails (@UserId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT Name, phoneNum, city
    FROM [User]
    WHERE UserId = @UserId
)

SELECT * FROM dbo.GetUserDetails(1)

--Q3
CREATE PROCEDURE GetUserDetails1
    @UserName VARCHAR(50)
AS
BEGIN
    SELECT * 
    FROM [User]
    WHERE name = @UserName
END

EXEC GetUserDetails1 'Ali'

--Q4

CREATE FUNCTION dbo.GetBalance(@cardNum VARCHAR(16))
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @balance DECIMAL(10, 2)
    
    SELECT @balance = balance
    FROM cards
    WHERE cardNum = @cardNum
    
    RETURN @balance
END

CREATE PROCEDURE getUserCardsAndBalances
    @userId INT
AS
BEGIN
    SELECT c.cardNum, dbo.getBalance(C.cardNum) as balance
    FROM [Card] C
    INNER JOIN UserCard uc ON uc.cardNum = C.cardNum
    WHERE UC.userID = @userId
END


--Q5
CREATE FUNCTION GetUserCardBalance1(@userId INT)
RETURNS TABLE
AS
RETURN (
    SELECT C.cardNum, dbo.GetCardBalance(C.cardNum) AS balance
    FROM [Card] C, UserCard UC
    WHERE UC.userID = @userId
)

SELECT dbo.GetUserCardBalance1(1) AS balance;

--Q6
create procedure no_Of_cards
@userID1 int
as
begin
		select count(UC.userID) as Total_Cards
		from [UserCard] UC
		where @userID1 = UC.userID
end

declare @userID2 int 
set @userID2 = 1;

execute no_Of_cards
@userID1 = @userID2

--Q7
create procedure login1
(
	@cardNum1 varchar(20),
	@pin1 int,
	@status int OUTPUT
)
as
begin
	if exists(select * from [Card] C where @cardNum1 = C.cardNum AND @pin1 = C.PIN)
		set @status = 1
	else set @status = 0
end

declare @temp_Status int
declare @cardNum2 varchar(20) = '1324327436569'
declare @pin2 int = 1770

execute login1
@cardNum1 = @cardNum2,
@pin1 = @pin2,
@status = @temp_Status OUTPUT

--Q8
create procedure update_PIN
(
	@card_Num3 varchar(20),
	@pin3 int,
	@newPin int OUTPUT
)
as
begin
		if not exists(select * from [Card] C where @card_Num3 = C.cardNum AND @pin3 = C.PIN)
			set @newPin = 0
end

declare @cardNum4 varchar(20) = '1324327436569'
declare @pin4 int = 1770
declare @updatedPIN int = 1234

execute update_PIN
@card_Num3 = @cardNum4,
@pin3 = @pin4,
@newPin = @updatedPIN OUTPUT

select @updatedPIN as UPDATED_PIN

--Q9
create procedure withdraw_Login
(
	@card_Num5 varchar(20),
	@pin5 int,
	@amount3 int
)
as
begin
	declare @trans_Type_Temp int = 1
	if exists(select * from [Card] C where @card_Num5 = C.cardNum AND @pin5 = C.PIN AND C.balance >= @amount3)
	begin	
		set @trans_Type_Temp = 1
		update [Card]
		set [balance] = balance - @amount3
		where [Card].cardNum = @card_Num5 AND [Card].PIN = @pin5
	end

	else set @trans_Type_Temp = 4

	declare @max_Trans_ID int;
	select @max_Trans_ID = max(T.transId) + 1
	from [Transaction] T

	Insert into [Transaction]
	Values
	(@max_Trans_ID, GETDATE(), @card_Num5, @amount3, @trans_Type_Temp)
end

declare @card_Num6 varchar(20) = '1324327436569'
declare @pin6 int = 1770
declare @temporary_amount int = 50000

execute withdraw_Login
@card_Num5 = @card_Num6,
@pin5 = @pin6,
@amount3 = @temporary_amount

select * from [Transaction]

select @temp_Status as Login_Status

--No, we cannot write a UDF that performs the actions described in the question because UDFs are meant to only return
--a single value and cannot modify the data in the database.