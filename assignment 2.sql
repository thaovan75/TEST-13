drop database if exists testing_system;
create database if not exists testing_system;
use testing_system;

drop table if exists department;
create table department (
	DepartmentID tinyint primary key auto_increment,
    DepartmentName varchar(50) not null unique
);

create table position (
	PositionID tinyint primary key auto_increment,
    PositionName enum('Dev', 'Test', 'scrum Master', 'PM') -- chi dc la string, 0 dc la so
);

create table `account` (
	AccountID int primary key auto_increment, 
    Email varchar(50) not null unique,
    FullName varchar(100),
    DepartmentID tinyint, 
    PositionID tinyint,
    CreateDate date,
    constraint account_department_fk foreign key(DepartmentID) references department(DepartmentID),
    constraint account_position_fk foreign key(PositionID) references `position`(PositionID)
);

create table `group`(
	GroupID tinyint primary key auto_increment,
    GroupName varchar(100) not null unique,
    CreatorID int,
    CreateDate date,
    constraint group_account_fk foreign key(CreatorID) references `account`(AccountID)
);

create table group_account (
	GroupID tinyint,
    AccountID int,
    JoinDate date,
    constraint groupaccount_group_fk foreign key(GroupID) references `group`(GroupID),
	constraint groupaccount_account_fk foreign key(AccountID) references `account`(AccountID)
);

create table type_question (
	TypeID tinyint primary key auto_increment,
    TypeName enum('Essay', 'Multiple-Choice')
);

create table category_question (
	CategoryID tinyint primary key auto_increment,
    CategoryName varchar(20)
);

create table question(
	QuestionID tinyint primary key auto_increment,
    Content varchar(500) not null,
    CategoryID tinyint,
    TypeID tinyint,
    CreatorID int,
    CreateDate date,
    constraint question_categoryquestion_fk foreign key (CategoryID) references category_question(CategoryID),
    constraint question_typequestion_fk foreign key (TypeID) references type_question(TypeID),
    constraint question_account_fk foreign key (CreatorID) references `account`(AccountID)
);

create table answer (
	AnswerID tinyint primary key auto_increment,
    Content varchar(500) not null unique,
    QuestionID tinyint,
    isCorrect enum('True', 'False'),
    constraint answer_question_fk foreign key(QuestionID) references question(QuestionID)
);
    
create table exam (
	ExamID tinyint primary key auto_increment,
    `Code` tinyint not null,
    Title varchar(100),
    CategoryID tinyint,
    Duration tinyint,
    CreatorID int,
    CreateDate date,
    constraint exam_categoryquestion_fk foreign key (CategoryID) references category_question(CategoryID),
    constraint exam_account_fk foreign key (CreatorID) references `account`(AccountID)
);

create table exam_question (
	ExamID tinyint,
    QuestionID tinyint,
    constraint examquestion_exam_fk foreign key (ExamID) references exam(ExamID),
    constraint examquestion_exam_fk2 foreign key (QuestionID) references question(QuestionID)
);