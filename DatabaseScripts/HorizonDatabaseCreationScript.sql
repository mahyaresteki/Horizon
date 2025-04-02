CREATE SCHEMA Basic;
CREATE SCHEMA UserManagement;
CREATE SCHEMA HumanResource;
CREATE SCHEMA DocumentManagement;
CREATE SCHEMA ProjectManagement;
CREATE SCHEMA Finance;

CREATE TYPE gender AS ENUM ('male', 'female');
CREATE TYPE weekday AS ENUM ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');


CREATE TABLE Basic.EducationLevel(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Basic.Priority(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Ordering int NOT NULL,
	Color varchar(7) NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Basic.IssueType(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	IconAddress varchar(1000) NOT NULL,
	Color varchar(7) NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Basic.Status(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Color varchar(7) NOT NULL,
	IsToDo boolean NOT NULL,
	IsInProgress boolean NOT NULL,
	IsDone boolean NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Basic.Resolvation(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Color varchar(7) NOT NULL,
	IsResolved boolean NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Basic.MeetingType(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Basic.DocumentType(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Basic.FileExtention(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Basic.ContractType(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Basic.TimeUnit(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	BasedOnMiliscond bigint NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE UserManagement.Role(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE UserManagement.Groups(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE UserManagement.Permission(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE UserManagement.Form(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE UserManagement.FormPermission(
    Id serial PRIMARY KEY NOT NULL, 
    FormId bigint NOT NULL,
	PermissionId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (FormId) REFERENCES UserManagement.Form(Id),
    FOREIGN KEY (PermissionId) REFERENCES UserManagement.Permission(Id)
);

CREATE TABLE UserManagement.RolePermission(
    Id serial PRIMARY KEY NOT NULL, 
    FormPermissionId bigint NOT NULL,
	RoleId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (RoleId) REFERENCES UserManagement.Role(Id),
    FOREIGN KEY (FormPermissionId) REFERENCES UserManagement.FormPermission(Id)
);

CREATE TABLE UserManagement.GroupPermission(
    Id serial PRIMARY KEY NOT NULL, 
    FormPermissionId bigint NOT NULL,
	GroupId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (GroupId) REFERENCES UserManagement.Groups(Id),
    FOREIGN KEY (FormPermissionId) REFERENCES UserManagement.FormPermission(Id)
);

CREATE TABLE UserManagement.Profile(
    Id serial PRIMARY KEY NOT NULL,
	FirstName varchar(200) NOT NULL,
	LastName varchar(200) NOT NULL,
	Gender gender NOT NULL,
	Avatar varchar(1000),
	Birthday date,
	PhoneNumber varchar(20),
	MobileNumber varchar(20),
	EmailAddress varchar(200),
	Address varchar(1000),
	PostalCode varchar(20),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE UserManagement.Users(
    Id serial PRIMARY KEY NOT NULL,
	ProfileId bigint NOT NULL,
	Username varchar(200) NOT NULL,
	Pass varchar(255) NOT NULL,
	PassSalt varchar(5),
	ActiveFrom timestamp NOT NULL,
	ActiveTo timestamp,
	LastLogInDate timestamp,
	LogInCount int NOT NULL DEFAULT 0,
	WrongLogInCount int NOT NULL DEFAULT 0,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProfileId) REFERENCES UserManagement.Profile(Id)
);

CREATE TABLE UserManagement.UserPermission(
    Id serial PRIMARY KEY NOT NULL, 
    FormPermissionId bigint NOT NULL,
	UserId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (UserId) REFERENCES UserManagement.Users(Id),
    FOREIGN KEY (FormPermissionId) REFERENCES UserManagement.FormPermission(Id)
);

CREATE TABLE UserManagement.UserRole(
    Id serial PRIMARY KEY NOT NULL, 
    UserId bigint NOT NULL,
	RoleId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (RoleId) REFERENCES UserManagement.Role(Id),
    FOREIGN KEY (UserId) REFERENCES UserManagement.Users(Id)
);

CREATE TABLE UserManagement.UserGroup(
    Id serial PRIMARY KEY NOT NULL, 
    UserId bigint NOT NULL,
	GroupId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (GroupId) REFERENCES UserManagement.Groups(Id),
    FOREIGN KEY (UserId) REFERENCES UserManagement.Users(Id)
);

CREATE TABLE DocumentManagement.Document(
    Id serial PRIMARY KEY NOT NULL, 
    TableId bigint NOT NULL,
    TableName varchar(255) NOT NULL,
	FileAddress varchar(4000) NOT NULL,
	DocumentTypeId bigint NOT NULL,
	FileExtentionId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (DocumentTypeId) REFERENCES Basic.DocumentType(Id),
	FOREIGN KEY (FileExtention) REFERENCES Basic.FileExtention(Id)
);


CREATE TABLE HumanResource.Company(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
	ParentId bigint,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ParentId) REFERENCES HumanResource.Company(Id)
);

CREATE TABLE HumanResource.Department(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
	ParentId bigint,
	CompanyId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ParentId) REFERENCES HumanResource.Department(Id),
	FOREIGN KEY (CompanyId) REFERENCES HumanResource.Company(Id)
);

CREATE TABLE HumanResource.Position(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(10) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
	ParentId bigint,
	DepartmentId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ParentId) REFERENCES HumanResource.Position(Id),
	FOREIGN KEY (DepartmentId) REFERENCES HumanResource.Department(Id)
);

CREATE TABLE HumanResource.Staff(
    Id serial PRIMARY KEY NOT NULL, 
    StaffNumber varchar(20) NOT NULL UNIQUE,
	ProfileId bigint Not Null,
	CompanyId bigint NOT NULL,
	StartDate date,
	EndDate date,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProfileId) REFERENCES UserManagement.Profile(Id),
	FOREIGN KEY (CompanyId) REFERENCES HumanResource.Company(Id)
);

CREATE TABLE HumanResource.StaffPosition(
    Id serial PRIMARY KEY NOT NULL, 
	StaffId bigint Not Null,
	PositionId bigint NOT NULL,
	StartDate date,
	EndDate date,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (StaffId) REFERENCES HumanResource.Staff(Id),
	FOREIGN KEY (PositionId) REFERENCES HumanResource.Position(Id)
);

CREATE TABLE HumanResource.ProfileEducation(
    Id serial PRIMARY KEY NOT NULL, 
	ProfileId bigint Not Null,
	EducationLevelId bigint NOT NULL,
	DocumentId bigint,
	Title varchar(255) NOT NULL,
	CollageName varchar(255),
	StartDate date,
	EndDate date,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProfileId) REFERENCES UserManagement.Profile(Id),
	FOREIGN KEY (DocumentId) REFERENCES DocumentManagement.Document(Id),
	FOREIGN KEY (EducationLevelId) REFERENCES Basic.EducationLevel(Id)
);

CREATE TABLE HumanResource.ProfileJobExperience(
    Id serial PRIMARY KEY NOT NULL, 
	ProfileId bigint Not Null,
	JobTitle varchar(255) NOT NULL,
	CompanyName varchar(255) NOT NULL,
	StartDate date,
	EndDate date,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProfileId) REFERENCES UserManagement.Profile(Id)
);

CREATE TABLE HumanResource.ProfileCertificate(
    Id serial PRIMARY KEY NOT NULL, 
	ProfileId bigint Not Null,
	Title varchar(255) NOT NULL,
	InstituteNmae varchar(255) NOT NULL,
	HasCertificate boolean NOT NULL,
	StartDate date,
	EndDate date,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProfileId) REFERENCES UserManagement.Profile(Id)
);


CREATE TABLE HumanResource.WorkingTimeTable(
    Id serial PRIMARY KEY NOT NULL, 
	CompnayId bigint Not Null,
	WorkingDay weekday NOT NULL,
	StartTime time NOT NULL,
	EndTime time NOT NULL,
	FloatingStartTime time,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (CompanyId) REFERENCES HumanResource.Company(Id),
	UNIQUE (CompnayId, WorkingDay)
);

CREATE TABLE HumanResource.Holidaies(
    Id serial PRIMARY KEY NOT NULL, 
	CompnayId bigint Not Null,
	HolidayDate date NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (CompanyId) REFERENCES HumanResource.Company(Id),
	UNIQUE (CompnayId, HolidayDate)
);