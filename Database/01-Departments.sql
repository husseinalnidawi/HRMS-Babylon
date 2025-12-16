-- =====================================================
-- HR Management System - Departments Table
-- Created: 2025-12-16 23:30:35 UTC
-- Purpose: Store organizational departments for the HR system
-- =====================================================

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Departments]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Departments] (
        [DepartmentID] INT PRIMARY KEY IDENTITY(1,1),
        [DepartmentName] NVARCHAR(100) NOT NULL UNIQUE,
        [DepartmentNameAr] NVARCHAR(100) NOT NULL,
        [Description] NVARCHAR(500),
        [DescriptionAr] NVARCHAR(500),
        [Manager] NVARCHAR(100),
        [IsActive] BIT NOT NULL DEFAULT 1,
        [CreatedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
        [ModifiedDate] DATETIME NOT NULL DEFAULT GETUTCDATE(),
        [CreatedBy] NVARCHAR(100),
        [ModifiedBy] NVARCHAR(100)
    );

    -- Create index on DepartmentName for faster searches
    CREATE INDEX [IX_DepartmentName] ON [dbo].[Departments] ([DepartmentName]);
    CREATE INDEX [IX_DepartmentNameAr] ON [dbo].[Departments] ([DepartmentNameAr]);

END

-- =====================================================
-- Insert Initial Departments Data
-- =====================================================

IF NOT EXISTS (SELECT 1 FROM [dbo].[Departments] WHERE [DepartmentNameAr] = N'الموارد البشرية')
BEGIN
    INSERT INTO [dbo].[Departments] 
    ([DepartmentName], [DepartmentNameAr], [Description], [DescriptionAr], [IsActive], [CreatedBy], [ModifiedBy])
    VALUES 
    (N'Human Resources', N'الموارد البشرية', N'Human Resources Department', N'قسم الموارد البشرية', 1, N'System', N'System');
END

-- =====================================================
-- Add additional common departments
-- =====================================================

IF NOT EXISTS (SELECT 1 FROM [dbo].[Departments] WHERE [DepartmentName] = N'Finance')
BEGIN
    INSERT INTO [dbo].[Departments] 
    ([DepartmentName], [DepartmentNameAr], [Description], [DescriptionAr], [IsActive], [CreatedBy], [ModifiedBy])
    VALUES 
    (N'Finance', N'التمويل', N'Finance Department', N'قسم التمويل', 1, N'System', N'System');
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Departments] WHERE [DepartmentName] = N'Operations')
BEGIN
    INSERT INTO [dbo].[Departments] 
    ([DepartmentName], [DepartmentNameAr], [Description], [DescriptionAr], [IsActive], [CreatedBy], [ModifiedBy])
    VALUES 
    (N'Operations', N'العمليات', N'Operations Department', N'قسم العمليات', 1, N'System', N'System');
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Departments] WHERE [DepartmentName] = N'Information Technology')
BEGIN
    INSERT INTO [dbo].[Departments] 
    ([DepartmentName], [DepartmentNameAr], [Description], [DescriptionAr], [IsActive], [CreatedBy], [ModifiedBy])
    VALUES 
    (N'Information Technology', N'تكنولوجيا المعلومات', N'Information Technology Department', N'قسم تكنولوجيا المعلومات', 1, N'System', N'System');
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Departments] WHERE [DepartmentName] = N'Sales')
BEGIN
    INSERT INTO [dbo].[Departments] 
    ([DepartmentName], [DepartmentNameAr], [Description], [DescriptionAr], [IsActive], [CreatedBy], [ModifiedBy])
    VALUES 
    (N'Sales', N'المبيعات', N'Sales Department', N'قسم المبيعات', 1, N'System', N'System');
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Departments] WHERE [DepartmentName] = N'Marketing')
BEGIN
    INSERT INTO [dbo].[Departments] 
    ([DepartmentName], [DepartmentNameAr], [Description], [DescriptionAr], [IsActive], [CreatedBy], [ModifiedBy])
    VALUES 
    (N'Marketing', N'التسويق', N'Marketing Department', N'قسم التسويق', 1, N'System', N'System');
END
