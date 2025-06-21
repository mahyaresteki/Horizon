/* 
	Note: This script is created specifically for PostgreSQL database.
	Last Version : 25.6.17
	User Guide for Creating Database : 
	1. Please create a database with "horizondb" name.
	2. Open connection to created databse.
	3. Then run the following script. 
*/

CREATE SCHEMA Basic;
CREATE SCHEMA UserManagement;
CREATE SCHEMA HumanResource;
CREATE SCHEMA DocumentManagement;
CREATE SCHEMA ProjectManagement;
CREATE SCHEMA Finance;
CREATE SCHEMA Evaluation;
CREATE SCHEMA QualityControl;



CREATE TYPE gender AS ENUM ('Male', 'Female');
CREATE TYPE weekday AS ENUM ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
CREATE TYPE enterancetype AS ENUM ('Enter', 'Exit');
CREATE TYPE leavetype AS ENUM ('FullTime', 'PartTime');
CREATE TYPE calculationtype AS ENUM ('Percentage', 'FixedAmount');


CREATE TABLE Basic.EducationLevel(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(20) NOT NULL UNIQUE,
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
    Code varchar(20) NOT NULL UNIQUE,
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
    Code varchar(20) NOT NULL UNIQUE,
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
    Code varchar(20) NOT NULL UNIQUE,
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
    Code varchar(20) NOT NULL UNIQUE,
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
    Code varchar(20) NOT NULL UNIQUE,
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
    Code varchar(20) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Basic.FileExtension(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(20) NOT NULL UNIQUE,
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
    Code varchar(20) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Basic.TestApproval(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(20) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	IsApproved boolean NOT NULL,
	Color varchar(10) NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Basic.TestComplexityLevel(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(20) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	ValueNumber float NOT NULL,
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
    Code varchar(20) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	ValueBasedOnMillisecond bigint NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Basic.Currency(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(20) NOT NULL UNIQUE,
	Symbol varchar(20) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
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
    Code varchar(20) NOT NULL UNIQUE,
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
    Code varchar(20) NOT NULL UNIQUE,
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
    Code varchar(20) NOT NULL UNIQUE,
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
    Code varchar(20) NOT NULL UNIQUE,
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

CREATE TABLE HumanResource.Department(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(20) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
	ParentId bigint,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ParentId) REFERENCES HumanResource.Department(Id)
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

CREATE TABLE UserManagement.Profile(
    Id serial PRIMARY KEY NOT NULL,
	FirstName varchar(200) NOT NULL,
	LastName varchar(200) NOT NULL,
	Gender gender NOT NULL,
	StaffNumber varchar(20) NOT NULL UNIQUE,
	ActiveFrom timestamp NOT NULL,
	ActiveTo timestamp,
	PositionId bigint,
	Avatar varchar(1000),
	Birthday date,
	PhoneNumber varchar(20),
	MobileNumber varchar(20),
	EmailAddress varchar(200),
	Address varchar(1000),
	PostalCode varchar(20),
	Username varchar(200) NOT NULL UNIQUE,
	Pass varchar(255) NOT NULL,
	PassSalt varchar(5),
	LastLogInDate timestamp,
	LogInCount int NOT NULL DEFAULT 0,
	WrongLogInCount int NOT NULL DEFAULT 0,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (PositionId) REFERENCES HumanResource.Position(Id)
);

CREATE TABLE UserManagement.ProfilePermission(
    Id serial PRIMARY KEY NOT NULL, 
    FormPermissionId bigint NOT NULL,
	ProfileId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProfileId) REFERENCES UserManagement.Profile(Id),
    FOREIGN KEY (FormPermissionId) REFERENCES UserManagement.FormPermission(Id)
);

CREATE TABLE UserManagement.ProfileRole(
    Id serial PRIMARY KEY NOT NULL, 
    ProfileId bigint NOT NULL,
	RoleId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (RoleId) REFERENCES UserManagement.Role(Id),
    FOREIGN KEY (ProfileId) REFERENCES UserManagement.Profile(Id)
);

CREATE TABLE UserManagement.ProfileGroup(
    Id serial PRIMARY KEY NOT NULL, 
    ProfileId bigint NOT NULL,
	GroupId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (GroupId) REFERENCES UserManagement.Groups(Id),
    FOREIGN KEY (ProfileId) REFERENCES UserManagement.Profile(Id)
);

CREATE TABLE DocumentManagement.Document(
    Id serial PRIMARY KEY NOT NULL, 
    TableId bigint NOT NULL,
    TableName varchar(255) NOT NULL,
	FileAddress varchar(4000) NOT NULL,
	DocumentTypeId bigint NOT NULL,
	FileExtensionId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (DocumentTypeId) REFERENCES Basic.DocumentType(Id),
	FOREIGN KEY (FileExtension) REFERENCES Basic.FileExtension(Id)
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
	ModifierId bigint
);

CREATE TABLE HumanResource.Holidaies(
    Id serial PRIMARY KEY NOT NULL, 
	HolidayDate date NOT NULL UNIQUE,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE HumanResource.Attendance(
    Id serial PRIMARY KEY NOT NULL, 
	ProfileId bigint Not Null,
	WorkingDate date NOT NULL,
	EnteranceType enterancetype NOT NULL,
	EnternaceTime time NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProfileId) REFERENCES UserManagement.Profile(Id)
);

CREATE TABLE HumanResource.Leave(
    Id serial PRIMARY KEY NOT NULL, 
	ProfileId bigint Not Null,
	LeaveType leavetype NOT NULL,
	LeavingStartDate date NOT NULL,
	LeavingEndDate date,
	LeavingStartTime time NOT NULL,
	LeavingEndTime time NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProfileId) REFERENCES UserManagement.Profile(Id)
);


CREATE TABLE HumanResource.WorkMission(
    Id serial PRIMARY KEY NOT NULL, 
	ProfileId bigint Not Null,
	MissionStartDate date NOT NULL,
	MissionEndDate date,
	MissionStartTime time NOT NULL,
	MissionEndTime time NOT NULL,
	MissionLocation varchar(255),
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProfileId) REFERENCES UserManagement.Profile(Id)
);


CREATE TABLE ProjectManagement.Project(
    Id serial PRIMARY KEY NOT NULL,
	Title varchar(255) NOT NULL,
	Code varchar(20) NOT NULL UNIQUE,
	StartDate date,
	EndDate date,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE ProjectManagement.ProjectProfileMember(
    Id serial PRIMARY KEY NOT NULL, 
	ProjectId bigint NOT NULL,
	ProfileId bigint NOT NULL,
	IsProjectManager boolean NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectId) REFERENCES ProjectManagement.Project(Id),
	FOREIGN KEY (ProfileId) REFERENCES UserManagement.Profile(Id),
	UNIQUE (ProjectId, ProfileId)
);

CREATE TABLE ProjectManagement.ProjectGroupMember(
    Id serial PRIMARY KEY NOT NULL, 
	ProjectId bigint NOT NULL,
	GroupId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectId) REFERENCES ProjectManagement.Project(Id),
	FOREIGN KEY (GroupId) REFERENCES UserManagement.Groups(Id),
	UNIQUE (ProjectId, GroupId)
);

CREATE TABLE ProjectManagement.ProjectRoleMember(
    Id serial PRIMARY KEY NOT NULL, 
	ProjectId bigint NOT NULL,
	RoleId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectId) REFERENCES ProjectManagement.Project(Id),
	FOREIGN KEY (RoleId) REFERENCES UserManagement.Role(Id),
	UNIQUE (ProjectId, RoleId)
);

CREATE TABLE ProjectManagement.ProjectDepartmentMember(
    Id serial PRIMARY KEY NOT NULL, 
	ProjectId bigint NOT NULL,
	DepartmentId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectId) REFERENCES ProjectManagement.Project(Id),
	FOREIGN KEY (DepartmentId) REFERENCES HumanResource.Department(Id),
	UNIQUE (ProjectId, DepartmentId)
);

CREATE TABLE ProjectManagement.ProjectWorkflow(
    Id serial PRIMARY KEY NOT NULL, 
	ProjectId bigint NOT NULL,
	Title varchar(255) NOT NULL,
	Code varchar(20) NOT NULL UNIQUE,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectId) REFERENCES ProjectManagement.Project(Id)
);

CREATE TABLE ProjectManagement.ProjectWorkflowStatus(
    Id serial PRIMARY KEY NOT NULL, 
	ProjectWorkflowId bigint NOT NULL,
	StatusId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectWorkflowId) REFERENCES ProjectManagement.ProjectWorkflow(Id),
	FOREIGN KEY (StatusId) REFERENCES Basic.Status(Id)
);

CREATE TABLE ProjectManagement.ProjectWorkflowResolvation(
    Id serial PRIMARY KEY NOT NULL, 
	ProjectWorkflowId bigint NOT NULL,
	ResolvationId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectWorkflowId) REFERENCES ProjectManagement.ProjectWorkflow(Id),
	FOREIGN KEY (ResolvationId) REFERENCES Basic.Resolvation(Id)
);

CREATE TABLE ProjectManagement.ProjectWorkflowProgress(
    Id serial PRIMARY KEY NOT NULL,
	Title varchar(255) NOT NULL,
	StartProjectWorkflowStatusId bigint,
	IsFromStartPoint boolean NOT NULL
	CanBeStartedFromAnyStatus boolean NOT NULL,
	EndProjectWorkflowStatusId bigint,
	IsWorkflowEndPoint boolean NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (StartProjectWorkflowStatusId) REFERENCES ProjectManagement.ProjectWorkflowStatus(Id),
	FOREIGN KEY (EndProjectWorkflowStatusId) REFERENCES ProjectManagement.ProjectWorkflowStatus(Id)
);

CREATE TABLE DocumentManagement.ProjectWorkflowDocumentType(
    Id serial PRIMARY KEY NOT NULL,
	DocumentTypeId bigint NOT NULL,
	ProjectWorkflowId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (DocumentTypeId) REFERENCES DocumentManagement.DocumentType(Id),
	FOREIGN KEY (ProjectWorkflowId) REFERENCES ProjectManagement.ProjectWorkflow(Id),
	UNIQUE(DocumentTypeId, ProjectWorkflowId)
);

CREATE TABLE ProjectManagement.Issue(
    Id serial PRIMARY KEY NOT NULL,
	ProjectId bigint NOT NULL,
	AssigneeId bigint,
	Code varchar(20) NOT NULL UNIQUE,
    Title varchar(200) NOT NULL,
	Description varchar(4000),
	PriorityId bigint,
	IssueTypeId bigint NOT NULL,
	CuurentStatusId bigint NOT NULL,
	CurrentResolvationId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (AssigneeId) REFERENCES UserManagement.Profile(Id),
	FOREIGN KEY (ProjectId) REFERENCES ProjectManagement.Project(Id),
	FOREIGN KEY (IssueTypeId) REFERENCES Basic.IssueType(Id),
	FOREIGN KEY (CuurentStatusId) REFERENCES ProjectManagement.ProjectWorkflowStatus(Id),
	FOREIGN KEY (CurrentResolvationId) REFERENCES ProjectManagement.ProjectWorkflowResolvation(Id)
);

CREATE TABLE ProjectManagement.IssueComment(
    Id serial PRIMARY KEY NOT NULL,
	IssueId bigint NOT NULL,
	CommentText varchar(4000) NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (IssueId) REFERENCES ProjectManagement.Issue(Id)
);

CREATE TABLE ProjectManagement.IssueAttachment(
    Id serial PRIMARY KEY NOT NULL,
	IssueId bigint NOT NULL,
	DocumentId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (IssueId) REFERENCES ProjectManagement.Issue(Id),
	FOREIGN KEY (DocumentId) REFERENCES DocumentManagement.Document(Id),
	UNIQUE(IssueId, DocumentId)
);

CREATE TABLE ProjectManagement.ProjectRelease(
    Id serial PRIMARY KEY NOT NULL,
	ProjectId bigint NOT NULL,
	VersionNumber varchar(20) NOT NULL UNIQUE,
    ReleaseDate date,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectId) REFERENCES ProjectManagement.Project(Id)
);

CREATE TABLE ProjectManagement.ProjectReleaseIssue(
    Id serial PRIMARY KEY NOT NULL,
	IssueId bigint NOT NULL,
	ProjectReleaseId bigint NOT NULL,
	IsFinalized boolean,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (IssueId) REFERENCES ProjectManagement.Issue(Id),
	FOREIGN KEY (ProjectReleaseId) REFERENCES ProjectManagement.ProjectRelease(Id),
	UNIQUE(IssueId, ProjectReleaseId)
);

CREATE TABLE ProjectManagement.WorkLog(
    Id serial PRIMARY KEY NOT NULL,
	IssueId bigint NOT NULL,
	LogDate date NOT NULL,
	StartWorkTime time NOT NULL,
	WorkingDuration float NOT NULL, 
	TimeUnitId bigint NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (IssueId) REFERENCES ProjectManagement.Issue(Id)
);

CREATE TABLE DocumentManagement.WorkflowEligibleFileExtension(
    Id serial PRIMARY KEY NOT NULL,
	FileExtensionId bigint NOT NULL,
	ProjectWorkflowId bigint NOT NULL,
	MaxFileSizeForUpload integer NOT NULL DEFAULT 5242880,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (FileExtensionId) REFERENCES DocumentManagement.FileExtension(Id),
	FOREIGN KEY (ProjectWorkflowId) REFERENCES ProjectManagement.ProjectWorkflow(Id),
	UNIQUE(FileExtensionId, ProjectWorkflowId)
);

CREATE TABLE ProjectManagement.IssueWorkflowHistory(
    Id serial PRIMARY KEY NOT NULL,
	IssueId bigint NOT NULL,
	StartStatusId bigint NOT NULL,
	EndStatusId bigint NOT NULL,
	ProjectWorkflowProgressId bigint NOT NULL,
	ProjectWorkflowResolvationId bigint,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (IssueId) REFERENCES ProjectManagement.Issue(Id),
	FOREIGN KEY (StartStatusId) REFERENCES ProjectManagement.StartStatus(Id),
	FOREIGN KEY (EndStatusId) REFERENCES ProjectManagement.EndStatus(Id),
	FOREIGN KEY (ProjectWorkflowProgressId) REFERENCES ProjectManagement.ProjectWorkflowProgress(Id),
	FOREIGN KEY (ProjectWorkflowResolvationId) REFERENCES ProjectManagement.ProjectWorkflowResolvation(Id)
);

CREATE TABLE ProjectManagement.ProjectMeeting(
    Id serial PRIMARY KEY NOT NULL,
	ProjectId bigint NOT NULL,
	MeetingTypeId bigint NOT NULL,
	MeetingDate date NOT NULL,
	Title varchar(255) NOT NULL,
	Location varchar(255) NOT NULL,
	MinutesDocumentId bigint,
	Description varchar(4000),
	ScheduleStartTime time,
	ScheduleEndTime time,
	ActualStartTime time,
	ActualEndTime time,
	IsCanncelled boolean NOT NULL DEFAULT false,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectId) REFERENCES ProjectManagement.Project(Id),
	FOREIGN KEY (MeetingTypeId) REFERENCES ProjectManagement.MeetingType(Id),
	FOREIGN KEY (MinutesDocumentId) REFERENCES DocumentManagement.Document(Id)
);

CREATE TABLE ProjectManagement.MeetingInvitees(
    Id serial PRIMARY KEY NOT NULL,
	ProjectMeetingId bigint NOT NULL,
	IsFromInsideCompnay boolean NOT NULL,
	ProfileId bigint,
	InviteeFullName varchar(255),
	InviteeCompanyName varchar(255),
	IsAttanded boolean,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectMeetingId) REFERENCES ProjectManagement.ProjectMeeting(Id),
	FOREIGN KEY (ProfileId) REFERENCES HumanResource.Profile(Id)
);

CREATE TABLE ProjectManagement.MeetingMinutes(
    Id serial PRIMARY KEY NOT NULL,
	ProjectMeetingId bigint NOT NULL,
	ResponsibleDepartmentId bigint NOT NULL,
	Resolution varchar(4000) NOT NULL,
	IssueId bigint,
	DueDate datetime,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectMeetingId) REFERENCES ProjectManagement.ProjectMeeting(Id),
	FOREIGN KEY (IssueId) REFERENCES ProjectManagement.Issue(Id),
	FOREIGN KEY (ResponsibleDepartmentId) REFERENCES HumanResource.Department(Id)
);

CREATE TABLE Finance.StaffContract(
    Id serial PRIMARY KEY NOT NULL,
	ProfileId bigint NOT NULL,
	ContractTypeId bigint NOT NULL,
	StartDate date NOT NULL,
	EndDate date NOT NULL,
	Title varchar(255) NOT NULL,
	Description varchar(4000),
	AutoRenewal boolean,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (PofileId) REFERENCES UserManagement.Profile(Id),
	FOREIGN KEY (ContractTypeId) REFERENCES Basic.ContractType(Id)
);

CREATE TABLE Finance.ContractSalaryItem(
    Id serial PRIMARY KEY NOT NULL,
	StaffContractId bigint NOT NULL,
	CalculationTimeUnitId bigint NOT NULL,
	Title varchar(255) NOT NULL,
	Amount numeric(22, 2) NOT NULL,
	CurrencyId bigint NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ContractId) REFERENCES Finance.StaffContract(Id),
	FOREIGN KEY (CurrencyId) REFERENCES Basic.Currency(Id),
	FOREIGN KEY (CalculationTimeUnitId) REFERENCES Basic.TimeUnit(Id)
);

CREATE TABLE Finance.ContractDeductionItem(
    Id serial PRIMARY KEY NOT NULL,
	CalculationType calculationtype NOT NULL,
	StaffContractId bigint NOT NULL,
	CalculationTimeUnitId bigint NOT NULL,
	Title varchar(255) NOT NULL,
	DeductionPercentage numeric(3,2),
	FixedAmount numeric(22, 2),
	FixedAmountCurrencyId bigint,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ContractId) REFERENCES Finance.StaffContract(Id),
	FOREIGN KEY (FixedAmountCurrencyId) REFERENCES Basic.Currency(Id),
	FOREIGN KEY (CalculationTimeUnitId) REFERENCES Basic.TimeUnit(Id)
);

CREATE TABLE Finance.Supplier(
    Id serial PRIMARY KEY NOT NULL,
	Title varchar(255) NOT NULL,
	Description varchar(4000),
	Address varchar(4000),
	PhoneNumber varchar(20),
	MobileNumber varchar(20),
	Email varchar(100),
	PostalCode varchar(20),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Finance.CostReceipt(
    Id serial PRIMARY KEY NOT NULL,
	SupplierId bigint NOT NULL,
	DocumentId bigint NOT NULL,
	CompnayId bigint NOT NULL,
	ReceiptDate date NOT NULL,
	TotalAmount numeric(22, 2) NOT NULL,
	CurrencyId bigint NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (SupplierId) REFERENCES Finance.Supplier(Id),
	FOREIGN KEY (DocumentId) REFERENCES DocumentManagement.Document(Id),
	FOREIGN KEY (CurrencyId) REFERENCES Basic.Currency(Id),
	FOREIGN KEY (CompnayId) REFERENCES HumanResource.Compnay(Id)
);

CREATE TABLE Finance.CostReceiptItem(
    Id serial PRIMARY KEY NOT NULL,
	CostReceiptId bigint NOT NULL,
	ItemTitle varchar(255) NOT NULL,
	UnitAmount numeric(22, 2) NOT NULL,
	CurrencyId bigint NOT NULL,
	Quantity float NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (CostReceiptId) REFERENCES Finance.CostReceipt(Id),
	FOREIGN KEY (CurrencyId) REFERENCES Basic.Currency(Id)
);

CREATE TABLE Finance.ProjectDirectCostItem(
    Id serial PRIMARY KEY NOT NULL,
	ProjectId bigint NOT NULL,
	CostReceiptItemId bigint NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectId) REFERENCES ProjectManagement.Project(Id),
	FOREIGN KEY (CostReceiptItemId) REFERENCES Finance.CostReceiptItem(Id)
);

CREATE TABLE Finance.CostPaymentReceipt(
    Id serial PRIMARY KEY NOT NULL,
	CostReceiptId bigint NOT NULL,
	DocumentId bigint NOT NULL,
	PaymentDate date NOT NULL,
	Amount numeric(22, 2) NOT NULL,
	CurrencyId bigint NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (CostReceiptId) REFERENCES Finance.CostReceipt(Id),
	FOREIGN KEY (CurrencyId) REFERENCES Basic.Currency(Id),
	FOREIGN KEY (DocumentId) REFERENCES DocumentManagement.Document(Id)
);

CREATE TABLE Finance.SalaryPaymentReceipt(
    Id serial PRIMARY KEY NOT NULL,
	StaffContractId bigint NOT NULL,
	DocumentId bigint NOT NULL,
	PaymentDate date NOT NULL,
	Amount numeric(22, 2) NOT NULL,
	CurrencyId bigint NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (StaffContractId) REFERENCES Finance.StaffContract(Id),
	FOREIGN KEY (CurrencyId) REFERENCES Basic.Currency(Id),
	FOREIGN KEY (DocumentId) REFERENCES DocumentManagement.Document(Id)
);


CREATE TABLE Finance.StaffAdditionalPaymentReceipt(
    Id serial PRIMARY KEY NOT NULL,
	ProfileId bigint NOT NULL,
	DocumentId bigint NOT NULL,
	PaymentDate date NOT NULL,
	Amount numeric(22, 2) NOT NULL,
	CurrencyId bigint NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProfileId) REFERENCES HumanResource.Profile(Id),
	FOREIGN KEY (CurrencyId) REFERENCES Basic.Currency(Id),
	FOREIGN KEY (DocumentId) REFERENCES DocumentManagement.Document(Id)
);

CREATE TABLE Finance.Customer(
    Id serial PRIMARY KEY NOT NULL,
	Title varchar(255) NOT NULL,
	Description varchar(4000),
	Address varchar(4000),
	PhoneNumber varchar(20),
	MobileNumber varchar(20),
	Email varchar(100),
	PostalCode varchar(20),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Finance.Contract(
    Id serial PRIMARY KEY NOT NULL, 
	CustomerId bigint NOT Null,
	ProjectId bigint NOT Null,
	StartDate date,
	ScheduledEndDate date,
	RealEndDate date,
	IsDevelopmentContract boolean,
	IsSupportContract boolean,
	TotalAmount numeric(22, 2) NOT NULL,
	CurrencyId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (CustomerId) REFERENCES Finance.Customer(Id),
	FOREIGN KEY (ProjectId) REFERENCES ProjectManagement.Project(Id),
	FOREIGN KEY (CurrencyId) REFERENCES Basic.Currency(Id)
);

CREATE TABLE Finance.ContractPaymentSchedule(
    Id serial PRIMARY KEY NOT NULL, 
	ContractId bigint NOT Null,
	PaymentTitle varchar(255) NOT NULL,
	ProjectReleaseId bigint,
	ScheduledPaymentDate date,
	Amount numeric(22, 2) NOT NULL,
	CurrencyId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ContractId) REFERENCES Finance.Contarct(Id),
	FOREIGN KEY (ProjectReleaseId) REFERENCES ProjectManagement.ProjectRelease(Id),
	FOREIGN KEY (CurrencyId) REFERENCES Basic.Currency(Id)
);

CREATE TABLE Finance.ContractPaymentReceipt(
    Id serial PRIMARY KEY NOT NULL, 
	ContractPaymentScheduleId bigint NOT Null,
	ReceiptDocumentId bigint,
	PaymentDate date,
	Amount numeric(22, 2) NOT NULL,
	CurrencyId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ContractPaymentScheduleId) REFERENCES Finance.ContractPaymentSchedule(Id),
	FOREIGN KEY (ReceiptDocumentId) REFERENCES DocumentManagement.Document(Id),
	FOREIGN KEY (CurrencyId) REFERENCES Basic.Currency(Id)
);

CREATE TABLE QualityControl.TestScenario(
    Id serial PRIMARY KEY NOT NULL, 
	TestComplexityLevelId bigint NOT Null,
	Title varchar(255) NOT NULL,
	Code varchar(10) NOT NULL,
	UsersAndRoles varchar(4000),
	Steps varchar(4000),
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (TestComplexityLevelId) REFERENCES Finance.TestComplexityLevel(Id)
);

CREATE TABLE QualityControl.PrerequisiteTestScenario(
    Id serial PRIMARY KEY NOT NULL, 
	TestScenarioId bigint NOT Null,
	PrerequisiteTestScenarioId bigint NOT Null,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (TestScenarioId) REFERENCES QualityControl.TestScenario(Id),
	FOREIGN KEY (PrerequisiteTestScenarioId) REFERENCES QualityControl.TestScenario(Id)
);

CREATE TABLE QualityControl.TestPlan(
    Id serial PRIMARY KEY NOT NULL, 
	ProjectReleaseId bigint,
	Title varchar(255) NOT NULL,
	Code varchar(10) NOT NULL,
	PlanningDate date,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectReleaseId) REFERENCES ProjectManagement.ProjectRelease(Id)
);

CREATE TABLE QualityControl.TestPlanScenario(
    Id serial PRIMARY KEY NOT NULL, 
	TestScenarioId bigint NOT NULL,
	TestPlanId bigint NOT NULL,
	Ordering float NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (TestScenarioId) REFERENCES QualityControl.TestScenario(Id),
	FOREIGN KEY (TestPlanId) REFERENCES QualityControl.TestPlan(Id),
	UNIQUE(TestScenarioId, TestPlanId, Ordering)
);

CREATE TABLE QualityControl.TestPlanScenarioIssueCoverage(
    Id serial PRIMARY KEY NOT NULL, 
	TestPlanScenarioId bigint NOT NULL,
	IssueId bigint NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (TestPlanScenarioId) REFERENCES QualityControl.TestPlanScenario(Id),
	FOREIGN KEY (IssueId) REFERENCES ProjectManagement.Issue(Id),
	UNIQUE(TestPlanScenarioId, IssueId)
);

CREATE TABLE QualityControl.TestResult(
    Id serial PRIMARY KEY NOT NULL, 
	TestPlanId bigint NOT NULL,
	TestDate date NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (TestPlanId) REFERENCES QualityControl.TestPlan(Id)
);

CREATE TABLE QualityControl.TestResultDetail(
    Id serial PRIMARY KEY NOT NULL, 
	TestPlanScenarioId bigint,
	TestApprovalId bigint NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (TestPlanScenarioId) REFERENCES QualityControl.TestPlanScenario(Id),
	FOREIGN KEY (TestApprovalId) REFERENCES Basic.TestApproval(Id)
);

CREATE TABLE Evaluation.Questionnaire(
    Id serial PRIMARY KEY NOT NULL,
	Title varchar(255) NOT NULL,
	TotalScore int NOT NULL,
	AcceptableScore int NOT NULL,
	WarningScore int NOT NULL,
	DisasterScore int NOT NULL,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint
);

CREATE TABLE Evaluation.QuestionnaireTargetDepartment(
    Id serial PRIMARY KEY NOT NULL, 
	QuestionnaireId bigint NOT Null,
	DepartmentId bigint NOT Null,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (QuestionnaireId) REFERENCES Evaluation.Questionnaire(Id),
	FOREIGN KEY (DepartmentId) REFERENCES HumanResource.Department(Id)
);

CREATE TABLE Evaluation.Question(
    Id serial PRIMARY KEY NOT NULL, 
	QuestionnaireId bigint NOT Null,
	Score int NOT NULL,
	Question varchar(4000) NOT NULL,
	IsDescriptive boolean NOT NULL,
	IsSingleChoice boolean NOT NULL,
	IsMultiChoice boolean NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (QuestionnaireId) REFERENCES Evaluation.Questionnaire(Id)
);

CREATE TABLE Evaluation.QuestionOption(
    Id serial PRIMARY KEY NOT NULL, 
	QuestionId bigint NOT Null,
	Score int NOT NULL,
	Title varchar(4000) NOT NULL,
	IsDescriptionRequired boolean NOT NULL
	IsSingleChoice boolean NOT NULL,
	IsMultiChoice boolean NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (QuestionId) REFERENCES Evaluation.Question(Id)
);

CREATE TABLE Evaluation.QuestionnaireResult(
    Id serial PRIMARY KEY NOT NULL, 
	QuestionnaireId bigint NOT Null,
	ProfileId bigint NOT Null,
	TotalScore int NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (QuestionnaireId) REFERENCES Evaluation.Questionnaire(Id),
	FOREIGN KEY (ProfileId) REFERENCES UserManagement.Profile(Id)
);

CREATE TABLE Evaluation.QuestionnaireResultDetail(
    Id serial PRIMARY KEY NOT NULL, 
	QuestionnaireResultId bigint NOT Null,
	QuestionId bigint NOT Null,
	Score int,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (QuestionnaireResultId) REFERENCES Evaluation.QuestionnaireResult(Id),
	FOREIGN KEY (QuestionId) REFERENCES Evaluation.Question(Id)
);

CREATE TABLE Evaluation.QuestionnaireChoosedOptionResultDetail(
    Id serial PRIMARY KEY NOT NULL, 
	QuestionnaireResultDetailId bigint NOT NULL
	Score int,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (QuestionnaireResultDetailId) REFERENCES Evaluation.QuestionnaireResultDetail(Id),
	FOREIGN KEY (QuestionOptionId) REFERENCES Evaluation.QuestionOption(Id)
);

CREATE TABLE Evaluation.StaffSatisfactionEvaluation(
    Id serial PRIMARY KEY NOT NULL, 
	ProfileId bigint NOT NULL,
	EvalationDate date NOT NULL,
	EvaluatedValue numeric(3, 2) NOT NULL CHECK(EvaluatedValue BETWEEN 1 AND 100),
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProfileId) REFERENCES UserManagement.Profile(Id)
);

CREATE TABLE Evaluation.ProjectProductivityEvaluation(
    Id serial PRIMARY KEY NOT NULL, 
	ProjectId bigint NOT NULL,
	EvalationDate date NOT NULL,
	EvaluatedValue numeric(3, 2) NOT NULL CHECK(EvaluatedValue BETWEEN 1 AND 100),
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectId) REFERENCES ProjectManagement.Project(Id)
);

CREATE TABLE Evaluation.CustomerSatisfactionEvaluation(
    Id serial PRIMARY KEY NOT NULL,
	CustomerId bigint NOT NULL,
	ProjectId bigint NOT NULL,
	EvalationDate date NOT NULL,
	EvaluatedValue numeric(3, 2) NOT NULL CHECK(EvaluatedValue BETWEEN 1 AND 100),
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (CustomerId) REFERENCES Finance.Customer(Id),
	FOREIGN KEY (ProjectId) REFERENCES ProjectManagement.Project(Id)
);

CREATE TABLE Evaluation.CustomerFeedback(
    Id serial PRIMARY KEY NOT NULL,
	CustomerId bigint NOT NULL,
	ProjectId bigint NOT NULL,
	FeedbackDate date NOT NULL,
	FeedbackValue numeric(2, 2) NOT NULL CHECK(EvaluatedValue BETWEEN 1 AND 10),
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (CustomerId) REFERENCES Finance.Customer(Id),
	FOREIGN KEY (ProjectId) REFERENCES ProjectManagement.Project(Id)
);