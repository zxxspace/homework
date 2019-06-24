CREATE DATABASE [stdtb] ON  PRIMARY 
( NAME = N'stdtb_data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\stdtb_data.mdf' , SIZE = 10240KB , MAXSIZE = 102400KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'stdtb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQL\DATA\stdtb_log.ldf' , SIZE = 5120KB , MAXSIZE = 2048GB , FILEGROWTH = 10%);
GO
ALTER DATABASE [stdtb] SET COMPATIBILITY_LEVEL = 100
GO


-----------------------------------------------------------------------

CREATE LOGIN zhengxiaoxiao with password='zhengxiaoxiao'--, default_database=stdtb

-----------------------------------------------------------------------
CREATE USER [usr1] FOR LOGIN [zhengxiaoxiao]
CREATE USER [usr2] FOR LOGIN [zhengxiaoxiao]
CREATE USER [uer3] FOR LOGIN [zhengxiaoxiao] 
GO
-----------------------------------------------------------------------
CREATE TABLE [dbo].[Student](
	[Sno] [nchar](10) NOT NULL,
	[Sname] [nchar](10) NULL,
	[Ssex] [nchar](10) NULL,
	[Sage] [nchar](10) NULL,
	[Sdept] [nchar](10) NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Sno] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
--------------------------------------------------
CREATE TABLE [dbo].[Course](
	[Cno] [nchar](10) NULL,
	[Cname] [nchar](10) NULL,
	[Cpno] [nchar](10) NULL,
	[Ccredit] [nchar](10) NULL
) ON [PRIMARY]

GO

------------------------------------------------------
CREATE TABLE [dbo].[SC](
	[Sno] [nchar](10) NOT NULL,
	[Cno] [nchar](10) NOT NULL,
	[Grade] [nchar](10) NULL,
 CONSTRAINT [PK_SC] PRIMARY KEY CLUSTERED 
(
	[Sno] ASC,
	[Cno] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
---------------------------------------------------------------


USE stdtb
GO
INSERT INTO Student
VALUES('201215121','李勇','男','20','CS'),
('201215122','刘晨','女','19','CS'),
('201215123','王敏','女','18','MA'),
('201215125','张立','男','20','IS'),
('201215129','李丹','女','20','EE');
GO

USE stdtb
GO
INSERT INTO Course
VALUES('1','数据库','5','4'),
('2','数学',' ','2'),
('3','信息系统','1','4'),
('4','操作系统','6','2'),
('5','数据结构','7','4'),
('6','数据处理',' ','2'),
('7','PASCAL语言','6','4');
GO

USE stdtb
GO
INSERT INTO SC
VALUES('201215121','1','92'),
('201215121','2','85'),
('201215121','3','88'),
('201215122','2','90'),
('201215122','3','80'),
('201215123','2','82'),
('201215125','2','78'),
('201215125','1','58');
GO
--------------------------------------------------------
CREATE UNIQUE INDEX Stusno ON Student(Sno);
CREATE UNIQUE INDEX COucno ON Course(Cno);
CREATE UNIQUE INDEX Scno ON SC(Sno ASC,Cno DESC);


-------------------------------------
SELECT Sname,Sno,Sdept
FROM Student;
-------

SELECT* 
FROM Student;
-----------------------
SELECT Sname,2019-Sage
FROM Student;
-----------------------
SELECT Sname,'Year of Birth',2014-Sage,LOWER(Sdept)
FROM Student
-----------------------
SELECT DISTINCT Sno
FROM SC
-----------------------去掉结果中的重复行用distinct
SELECT Sname,Sage
FROM Student
WHERE Sage<20
-----------------------
SELECT DISTINCT Sno
FROM SC
WHERE Grade<60
-----------------------
SELECT Sname,Sdept,Sage
FROM Student
WHERE Sage BETWEEN 20 AND 23;
-----------------------
SELECT*
FROM Student
WHERE Sno LIKE '20125121';  
-----------------------
SELECT Sname,Sno,Ssex
FROM Student 
WHERE Sname LIKE'刘%';
-----------------------
SELECT Sno,Grade
FROM SC
WHERE Cno='2'
ORDER BY Grade DESC;
-----------------------降序DESC，升序ASC
SELECT*
FROM Student
ORDER BY Sdept,Sage DESC;
-----------------------
SELECT COUNT(*)
FROM Student;
-----------------------
SELECT AVG(Grade)
FROM SC
WHERE Cno='2';
-----------------------
SELECT SUM(Ccredit)
FROM SC,Course
WHERE Sno='201215121' AND SC.Cno=Course.Cno;
-----------------------
SELECT Cno,COUNT(Sno)
FROM SC
GROUP BY Cno;
-----------------------
SELECT Student.*,SC.*
FROM Student,SC
WHERE Student.Sno=SC.Sno;
-----------------------
SELECT Student.Sno,Sname,Cname,Grade
FROM Student,SC,Course
WHERE Student.Sno=SC.Sno AND SC.Cno=Course.Cno
-----------------------
SELECT Sname,Sage
FROM Student
WHERE Sage<ALL(SELECT Sage
               FROM Student 
               WHERE Sdept='CS')
AND Sdept<>'CS';
---------------------------------------
UPDATE Student
SET Sage=Sage+1;
--------------------------------------
USE stdtb
 GO
 CREATE VIEW IS_Student
        AS 
        SELECT Sno,Sname,Sage
        FROM Student
        WHERE Sdept='IS'
        WITH CHECK OPTION
        GO
        
 CREATE VIEW BT_S(Sno,Sname,Sbirth)
        AS 
        SELECT Sno,Sname,Sage
        FROM Student
        GO


-----------------------------------------

create login zhengxiaoxiao with password='zhengxiaoxiao', default_database=stdtb

create user zhengxiaoxiao for login zhengxiaoxiao with default_schema=dbo
exec sp_addrolemember 'usr1','zhengxiaoxiao'
EXEC sp_addrole 'Teacher'
GRANT SELECT,UPDATE,INSERT
ON SC
TO Teacher

EXEC sp_addrolemember Teacher, 'usr1'
EXEC sp_addrolemember Teacher, 'usr2'
EXEC sp_addrolemember Teacher, 'usr3'

---------------------------------------------


CREATE TABLE TEACHER
(Eno NUMERIC(4)PRIMARY KEY,
Ename CHAR(10),
Job CHAR(8),
Sal NUMERIC(7,2),
Deduct NUMERIC(7,2),
Deptno NUMERIC(2),
CONSTRANT TEACHERKey FOREIGN KEY(Deptno)
REFERENCES DEPT(Deptno),
CONSTRAINT C1 CHECK(Sal+Deduct>=3000)
);



