-- =====================================================
-- Create Sections Table
-- Created: 2025-12-16 23:30:43 UTC
-- =====================================================

CREATE TABLE [dbo].[Sections]
(
    [Id] INT PRIMARY KEY IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL UNIQUE,
    [Description] NVARCHAR(MAX) NULL,
    [IsActive] BIT NOT NULL DEFAULT 1,
    [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [ModifiedDate] DATETIME NULL
);

-- =====================================================
-- Insert Default Sections
-- =====================================================

INSERT INTO [dbo].[Sections] ([Name], [Description], [IsActive])
VALUES
    (N'شعبة التوظيف', N'قسم التوظيف والموارد البشرية', 1),
    (N'شعبة التطوير', N'قسم التطوير والتدريب', 1),
    (N'شعبة الرواتب', N'قسم إدارة الرواتب والمستحقات', 1);
