CREATE SCHEMA Basic;
CREATE SCHEMA UserManagement;
CREATE SCHEMA HumanResource;
CREATE SCHEMA DocumentManagement;
CREATE SCHEMA ProjectManagement;
CREATE SCHEMA Finance;


CREATE TYPE gender AS ENUM ('Male', 'Female');
CREATE TYPE weekday AS ENUM ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
CREATE TYPE enterancetype AS ENUM ('Enter', 'Exit');
CREATE TYPE leavetype AS ENUM ('FullTime', 'PartTime');


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

CREATE TABLE Basic.FileExtention(
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

CREATE TABLE Basic.TimeUnit(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(20) NOT NULL UNIQUE,
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
	FOREIGN KEY (ParentId) REFERENCES HumanResource.Company(Id)
);

CREATE TABLE HumanResource.Department(
    Id serial PRIMARY KEY NOT NULL, 
    Code varchar(20) NOT NULL UNIQUE,
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

CREATE TABLE HumanResource.Attendance(
    Id serial PRIMARY KEY NOT NULL, 
	StaffId bigint Not Null,
	WorkingDate date NOT NULL,
	EnteranceType enterancetype NOT NULL,
	EnternaceTime time NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (StaffId) REFERENCES HumanResource.Staff(Id)
);

CREATE TABLE HumanResource.Leave(
    Id serial PRIMARY KEY NOT NULL, 
	StaffId bigint Not Null,
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
	FOREIGN KEY (StaffId) REFERENCES HumanResource.Staff(Id)
);


CREATE TABLE HumanResource.WorkMission(
    Id serial PRIMARY KEY NOT NULL, 
	StaffId bigint Not Null,
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
	FOREIGN KEY (StaffId) REFERENCES HumanResource.Staff(Id)
);

CREATE TABLE HumanResource.Questionnaire(
    Id serial PRIMARY KEY NOT NULL, 
	CompanyId bigint NOT Null,
	Title varchar(255) NOT NULL
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
	ModifierId bigint,
	FOREIGN KEY (CompanyId) REFERENCES HumanResource.Company(Id)
);

CREATE TABLE HumanResource.QuestionnaireTargetDepartment(
    Id serial PRIMARY KEY NOT NULL, 
	QuestionnaireId bigint NOT Null,
	DepartmentId bigint NOT Null,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (QuestionnaireId) REFERENCES HumanResource.Questionnaire(Id),
	FOREIGN KEY (DepartmentId) REFERENCES HumanResource.Department(Id)
);

CREATE TABLE HumanResource.Question(
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
	FOREIGN KEY (QuestionnaireId) REFERENCES HumanResource.Questionnaire(Id)
);

CREATE TABLE HumanResource.QuestionOption(
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
	FOREIGN KEY (QuestionId) REFERENCES HumanResource.Question(Id)
);

CREATE TABLE HumanResource.QuestionnaireResult(
    Id serial PRIMARY KEY NOT NULL, 
	QuestionnaireId bigint NOT Null,
	StaffId bigint NOT Null,
	TotalScore int NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (QuestionnaireId) REFERENCES HumanResource.Questionnaire(Id),
	FOREIGN KEY (StaffId) REFERENCES HumanResource.Staff(Id)
);

CREATE TABLE HumanResource.QuestionnaireResultDetail(
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
	FOREIGN KEY (QuestionnaireResultId) REFERENCES HumanResource.QuestionnaireResult(Id),
	FOREIGN KEY (QuestionId) REFERENCES HumanResource.Question(Id)
);

CREATE TABLE HumanResource.QuestionnaireChoosedOptionResultDetail(
    Id serial PRIMARY KEY NOT NULL, 
	QuestionnaireResultDetailId bigint NOT Null,
	QuestionOptionId bigint NOT Null,
	Score int,
	Description varchar(4000),
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (QuestionnaireResultDetailId) REFERENCES HumanResource.QuestionnaireResultDetail(Id),
	FOREIGN KEY (QuestionOptionId) REFERENCES HumanResource.QuestionOption(Id)
);

CREATE TABLE ProjectManagement.Project(
    Id serial PRIMARY KEY NOT NULL, 
	CompanyId bigint NOT NULL,
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
	ModifierId bigint,
	FOREIGN KEY (CompanyId) REFERENCES HumanResource.Company(Id)
);

CREATE TABLE ProjectManagement.ProjectStaffMember(
    Id serial PRIMARY KEY NOT NULL, 
	ProjectId bigint NOT NULL,
	StaffId bigint NOT NULL,
	IsProjectManager boolean NOT NULL,
    IsActive boolean NOT NULL DEFAULT true,
    IsDeleted boolean NOT NULL DEFAULT false,
    CreateDate timestamp NOT NULL DEFAULT NOW(),
	CreatorId bigint NOT NULL,
    ModifyDate timestamp,
	ModifierId bigint,
	FOREIGN KEY (ProjectId) REFERENCES ProjectManagement.Project(Id),
	FOREIGN KEY (StaffId) REFERENCES HumanResource.Staff(Id),
	UNIQUE (ProjectId, StaffId)
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
	AssigneeStaffId bigint,
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
	FOREIGN KEY (AssigneeStaffId) REFERENCES HumanResource.StaffId(Id),
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