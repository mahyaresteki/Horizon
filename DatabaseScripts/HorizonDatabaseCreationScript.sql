CREATE SCHEMA Basic;
CREATE SCHEMA UserManagement;
CREATE SCHEMA HumanResource;
CREATE SCHEMA DocumentManagement;
CREATE SCHEMA ProjectManagement;
CREATE SCHEMA Finance;

CREATE TYPE gender AS ENUM ('male', 'female');


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
	FOREIGN KEY (FormId) REFERENCES Form(Id),
    FOREIGN KEY (PermissionId) REFERENCES Permission(Id)
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
	FOREIGN KEY (RoleId) REFERENCES Role(Id),
    FOREIGN KEY (FormPermissionId) REFERENCES FormPermission(Id)
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
	FOREIGN KEY (GroupId) REFERENCES Groups(Id),
    FOREIGN KEY (FormPermissionId) REFERENCES FormPermission(Id)
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
	FOREIGN KEY (ProfileId) REFERENCES Profile(Id)
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
	FOREIGN KEY (UserId) REFERENCES Users(Id),
    FOREIGN KEY (FormPermissionId) REFERENCES FormPermission(Id)
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
	FOREIGN KEY (RoleId) REFERENCES Role(Id),
    FOREIGN KEY (UserId) REFERENCES Users(Id)
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
	FOREIGN KEY (GroupId) REFERENCES Groups(Id),
    FOREIGN KEY (UserId) REFERENCES Users(Id)
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
	FOREIGN KEY (ParentId) REFERENCES Company(Id)
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
	FOREIGN KEY (ParentId) REFERENCES Department(Id),
	FOREIGN KEY (CompanyId) REFERENCES Company(Id)
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
	FOREIGN KEY (ParentId) REFERENCES Position(Id),
	FOREIGN KEY (DepartmentId) REFERENCES Department(Id)
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
	FOREIGN KEY (ProfileId) REFERENCES Profile(Id),
	FOREIGN KEY (CompnayId) REFERENCES Company(Id)
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
	FOREIGN KEY (StaffId) REFERENCES Staff(Id),
	FOREIGN KEY (PositionId) REFERENCES Position(Id)
);