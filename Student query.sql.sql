--Dev: Pannha Oudom Munint, L2, Jr SWE
--Push to QA and TST not PROD
--From DEV
--External query for Student DB

Select * from Register
Select * from Student
Select * from Semester
Select * from Course

Select count(*) from Register
where grade IN ('A','A+','B+') and courseID like '%2040'

Select courseID, count(stdNo) from Register
Group by courseID

Select courseID, count(stdNo) from Register
where grade is not NULL
Group by courseID

Select stdNo, count(distinct courseID) from Register
group by stdNo

Select courseID, count(stdNo) from Register
--where grade is not NULL
Group by courseID
having count(stdNo) > 0
order by count(stdNo) desc

Select stdNo, avg(mark) as "Marks" from Register
where grade is not NULL
group by stdNo
having count(stdNo)>1
