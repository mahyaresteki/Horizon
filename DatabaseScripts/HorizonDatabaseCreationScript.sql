CREATE SCHEMA Basic;
CREATE SCHEMA UserManagement;
CREATE SCHEMA HumanResource;
CREATE SCHEMA DocumentManagement;
CREATE SCHEMA ProjectManagement;
CREATE SCHEMA Finance;


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