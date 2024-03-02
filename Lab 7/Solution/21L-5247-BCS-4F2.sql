Create database ATM
go 
use ATM
go
create Table UserType(
userTypeID int primary key,
[name] varchar(20) not null
)
go
create table [User](
[userId] int primary key,
[name] varchar(20) not null,
[userType] int foreign key references UserType(UserTypeID),
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
create table TransactionType(
transTypeID int primary key,
typeName varchar(20) not null,
[description] varchar (40) null
)
go
create table [Transaction](
transId int primary key,
transDate date not null,
cardNum varchar(20) foreign key references [Card](cardNum),
amount int not null,
transType int foreign key references TransactionType(transTypeID)
)




GO
INSERT [dbo].[UserType] ([userTypeID], [name]) VALUES (1, N'Silver')
GO
INSERT [dbo].[UserType] ([userTypeID], [name]) VALUES (2, N'Gold')
GO
INSERT [dbo].[UserType] ([userTypeID], [name]) VALUES (3, N'Bronze')
GO
INSERT [dbo].[UserType] ([userTypeID], [name]) VALUES (4, N'Common')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (1, N'Ali', 2, N'03036067000', N'Narowal')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (2, N'Ahmed', 1, N'03036047000', N'Lahore')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (3, N'Aqeel', 3, N'03036063000', N'Karachi')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (4, N'Usman', 4, N'03036062000', N'Sialkot')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (5, N'Hafeez', 2, N'03036061000', N'Lahore')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (2, N'Credit', N'Spend Now, Pay later')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (3, N'Gift', N'Enjoy')
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1324327436569', 3, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'2324325423336', 3, N'0234', CAST(N'2020-03-02' AS Date), 14425.62)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'2324325436566', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'2324325666456', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'2343243253436', 2, N'0034', CAST(N'2020-09-02' AS Date), 34025.12)
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1324327436569')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'2343243253436')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (2, N'2324325423336')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (3, N'2324325436566')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName], [description]) VALUES (1, N'Withdraw', NULL)
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName], [description]) VALUES (2, N'Deposit', NULL)
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName], [description]) VALUES (3, N'ScheduledDeposit', NULL)
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName], [description]) VALUES (4, N'Failed', NULL)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (1, CAST(N'2017-02-02' AS Date), N'1324327436569', 500, 1)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (2, CAST(N'2018-02-03' AS Date), N'2343243253436', 3000, 3)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (3, CAST(N'2017-05-06' AS Date), N'2324325436566', 2500, 2)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (4, CAST(N'2016-09-09' AS Date), N'2324325436566', 2000, 1)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (5, CAST(N'2015-02-10' AS Date), N'2324325423336', 6000, 4)
GO


Select * from UserType
Select * from [User]
Select * from UserCard
Select * from [Card]
Select * from CardType
Select * from [Transaction]
Select * from TransactionType

--Q1

create procedure userDetails
as
begin
		select * from [User]
end

execute userDetails

--Q2

create procedure specific_User_Details
@tempName varchar (20)
as
begin
		select * from [User] where name=@tempName
end

declare @name1 varchar(20) = 'Aqeel';

execute specific_User_Details
@tempName = @name1

--Q3

create procedure specific_User_Details1
@cardNum1 varchar(20)
as 
begin
		select U.name, U.phoneNum, U.city
		from [Card] C
		join UserCard UC ON C.cardNum = UC.cardNum
		join [User] U ON U.userId = UC.userID
		where C.cardNum = @cardNum1
end

declare @cardNum2 varchar(20)
set @cardNum2 = '1324327436569'

execute specific_User_Details1
@cardNum1 = @cardNum2

--Q4

create procedure min_Balance
@balance1 float OUTPUT
as
begin
		select min(C.balance) as MinBalance
		from [Card] C
end

declare @balance2 float;

execute min_Balance
@balance1 = @balance2 OUTPUT

print @balance2

--Q5

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

--Q6

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

select @temp_Status as Login_Status

--Q7

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

--Q8

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

