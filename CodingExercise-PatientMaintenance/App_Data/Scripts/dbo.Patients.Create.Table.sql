CREATE TABLE [dbo].[Patient] (
    [Id]              INT             IDENTITY (1, 1) NOT NULL,
    [FirstName]       NVARCHAR (50)   NOT NULL,
    [LastName]        NVARCHAR (50)   NOT NULL,
    [Phone]           NVARCHAR (50)   NOT NULL,
    [Email]           NVARCHAR (50)   NOT NULL,
    [Gender]          NVARCHAR (50)   NOT NULL,
    [Notes]           NVARCHAR (1000) NULL,
    [CreatedDate]     DATETIME         NOT NULL,
    [LastUpdatedDate] DATETIME        DEFAULT (getdate()) NOT NULL,
    [IsDeleted]       BIT             DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

