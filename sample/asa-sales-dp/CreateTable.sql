DROP TABLE [dbo].[CustomerMapping]
DROP TABLE [dbo].[Customer]
DROP TABLE [dbo].[StandardCustomer]

CREATE TABLE [dbo].[Customer](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [Store] [nvarchar](100) NULL,
    [CustomerCode] [nvarchar](100) NULL,
    [CustomerName] [nvarchar](100) NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[Customer] 
	ADD CONSTRAINT PK_Customer_ID PRIMARY KEY ([ID])
ALTER TABLE [dbo].[Customer] 
	ADD CONSTRAINT UK_Customer_CustomerCode UNIQUE ([Store], [CustomerCode])

CREATE TABLE [dbo].[StandardCustomer](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [StandardCode] [nvarchar](100) NULL,
    [StandardName] [nvarchar](100) NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[StandardCustomer] 
	ADD CONSTRAINT PK_StandardCustomer_ID PRIMARY KEY ([ID])
ALTER TABLE [dbo].[StandardCustomer] 
	ADD CONSTRAINT UK_StandardCustomer_StandardCode UNIQUE ([StandardCode])

CREATE TABLE [dbo].[CustomerMapping](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [CustomerID] [int],
    [StandardID] [int]
) ON [PRIMARY]
ALTER TABLE [dbo].[CustomerMapping] 
	ADD CONSTRAINT PK_CustomerMapping_ID PRIMARY KEY ([ID])
ALTER TABLE [dbo].[CustomerMapping]
	ADD CONSTRAINT FK_CustomerMapping_CustomerID FOREIGN KEY ([CustomerID])
		REFERENCES [dbo].[Customer] ([ID]) 
		ON DELETE CASCADE
ALTER TABLE [dbo].[CustomerMapping]
	ADD CONSTRAINT FK_CustomerMapping_StandardID FOREIGN KEY ([StandardID])
		REFERENCES [dbo].[StandardCustomer] ([ID]) 
		ON DELETE CASCADE


INSERT [dbo].[Customer] ([Store], [CustomerCode], [CustomerName]) VALUES (N'store-a', N'A0001', N'CustomerA')
INSERT [dbo].[Customer] ([Store], [CustomerCode], [CustomerName]) VALUES (N'store-a', N'A0002', N'CustomerB')
INSERT [dbo].[Customer] ([Store], [CustomerCode], [CustomerName]) VALUES (N'store-a', N'A0003', N'CustomerC')
INSERT [dbo].[Customer] ([Store], [CustomerCode], [CustomerName]) VALUES (N'store-b', N'B0001', N'CustomerA')
INSERT [dbo].[Customer] ([Store], [CustomerCode], [CustomerName]) VALUES (N'store-b', N'B0002', N'CustomerB')
INSERT [dbo].[Customer] ([Store], [CustomerCode], [CustomerName]) VALUES (N'store-b', N'B0003', N'CustomerC')


INSERT [dbo].[StandardCustomer] ([StandardCode], [StandardName]) VALUES (N'S0001', N'�ڋqA')
INSERT [dbo].[StandardCustomer] ([StandardCode], [StandardName]) VALUES (N'S0002', N'�ڋqB')
INSERT [dbo].[StandardCustomer] ([StandardCode], [StandardName]) VALUES (N'S0003', N'�ڋqC')

INSERT [dbo].[CustomerMapping] ([CustomerID], [StandardID]) VALUES (1, 1)
INSERT [dbo].[CustomerMapping] ([CustomerID], [StandardID]) VALUES (2, 2)
INSERT [dbo].[CustomerMapping] ([CustomerID], [StandardID]) VALUES (3, 3)
INSERT [dbo].[CustomerMapping] ([CustomerID], [StandardID]) VALUES (4, 1)
INSERT [dbo].[CustomerMapping] ([CustomerID], [StandardID]) VALUES (5, 2)
INSERT [dbo].[CustomerMapping] ([CustomerID], [StandardID]) VALUES (6, 3)

CREATE VIEW [dbo].[CustomerView]
AS   
SELECT
c.[Store],
c.[CustomerCode],
sc.[StandardCode],
sc.[StandardName]
FROM [dbo].[Customer] AS c
LEFT OUTER JOIN [dbo].[CustomerMapping] AS cm ON c.[ID] = cm.[CustomerID]
LEFT OUTER JOIN [dbo].[StandardCustomer] AS sc ON cm.[StandardID] = sc.[ID]

SELECT * FROM [dbo].[Customer]
SELECT * FROM [dbo].[StandardCustomer]
SELECT * FROM [dbo].[CustomerMapping]

SELECT * FROM [dbo].[CustomerView]
