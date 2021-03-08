select user(), database();

-- 0. 데이터베이스 생성 및 연결
create database test_test_coffee;
use test_test_coffee;


-- 0. 계정생성 및 권한주기
grant all on test_test_coffee.*
	to 'user_test_test_coffee'@'localhost' identified by 'rootroot';
	

-- --------------------------------------------

-- 1 ERD를 참고하여 company라는 데이터베이스에 테이블을 생성 sql을 작성하시오.
select user(), database();
use company;


create  table department(
	deptno int not null primary key,
	deptname char(10) not null,
	floor int
);


create table employee(
	empno	int not null primary key,
	empname varchar(20) not null,
	title	varchar (10),
	manager int,
	salary	int,
	dno		int,
	foreign key (manager) references employee (empno),
	foreign key (dno) references department (deptno)
);

-- 2. 아래 결과를 참고하여 insert문을 작성하시오
insert into department values
	(1,'영업',8),
	(2,'기획',10),
	(3,'개발',9),
	(4,'총무',7);

insert into employee values
	(4377,'이성래','사장',null,5000000,2),
	(3011,'이수민','부장',4377,4000000,3),
	(3426,'박영권','과장',4377,3000000,1),
	(1003,'조민희','과장',4377,3000000,2),
	(2106,'김창섭','대리',1003,2500000,2),
	(1365,'김상원','사원',3426,1500000,1),
	(3427,'최종철','사원',3011,1500000,3);
select * from employee;
select * from department;

-- 3. department 테이블에서 부서번호가 4번인 부서를 삭제하는 sql을 작성하시오.
delete 
	from department 
	where deptno = 4;

-- 4. 사원번호가 2106인 사원의 소속부서를 3번부서로 옮기고 급여를 5% 올리는 sql문을 작성하시오.

update employee
set dno= 3, salary = salary*1.05
where empno = 2106;
-- 5. Employee 테이블에서 salary가 4000000 이상이면 '3시퇴근', 3000000이상이면 '5시퇴근', 2000000이상이면 '7시퇴근', 나머지는 '야근'으로 나오도록 사원명, 직책, 퇴근시간을 계산하여 출력하는 sql문을 작성하시오
select empname,title,
	case when salary >= 4000000 then '3시 퇴근'
		 when salary >= 3000000 then '5시 퇴근'
		 when salary >= 2000000 then '7시 퇴근'
		 else '야근'
		 end as '퇴근시간'
from employee ;


-- 6. 이씨 성을 가진 사원들의 이름, 직책, 소속 부서번호를 검색하는 sql문을 작성하시오.
select empname,title,dno
from employee
where empname like '이%';



-- 7. 직급이 과장이면서 1번부서에서 근무하는 사원들의 이름과 급여를 검색하는 sql문을 작성하시오.
select empname,title,salary
from employee
where title = '과장'and dno = 1;


-- 8. 급여가 3000000원 이상이고 4500000원 이하인 사원들의 이름, 직책, 급여를 검색하는 sql문을 작성하시오
select  empname,title,salary
from employee
where salary >= 3000000 and salary <=4500000;


-- 9. 1번부서나 3번 부서에 소속된 사원들에 관한 모든 정보를 검색하는 sql문을 작성하시오
select * 
from employee 
where dno=1 or dno =3;


select * 
from employee 
where dno in (1,3);


-- 10. 직급이 과장인 사원들에 대하여 이름과, 현재의 급여, 급여가 10% 인상됐을 때의 값을 검색하는 sql문을 작성하시오
select empname,salary,salary*1.1 as '인상된 급여'
from employee 
where title = '과장';

-- 11. 모든 사원들의 평균 급여와 최대 급여를 검색하는 sql문을 작성하시오.
select avg(salary) as '평균급여',
		max(salary) as '최대급여'
from employee;

-- 12. 모든 사원들에 대해서 사원들이 속한 부서번호별로 그룹화하고, 각 부서마다 부서번호, 평균급여, 최대급여를 검색하는 sql문을 작성하시오.
select dno, avg(salary) as '평균급여', max(salary) as '최대급여'
from employee
group by dno;

-- 13. 모든 사원들에 대해서 사원들이 속한 부서번호별로 그룹화하고, 평균 급여가 2500000원 이상인 부서에 대하여 부서번호, 평균급여, 최대급여를 검색하는 sql문을 작성하시오.
select dno,avg(salary) as '평균급여',max(salary) as '최대급여'
from employee 
group by dno
having avg(salary) >= 2500000;

-- 14. 모든 사원들의 이름과 이 사원이 속한 부서명을 검색하는 sql문을 작성하시오.
select empname,deptname
from employee e join department d on e.dno = d.deptno; 

-- 15. 모든 사원에 대해서 사원명과 직속상사의 이름을 검색하는 sql문을 작성하시오.
select * from employee;
select * from department;

select e.empname as '사원', m.empname as '직속상사'
from employee e join employee m on e.empno = m.manager
where e.salary >= 2000000;



-- 16 모든 사원에 대해서 소속 부서명, 사원명, 직급, 급여를 검색하는 sql문을 작성하시오.
-- 단, 부서 이름에 대해서 오름차순, 부서이름이 같을 경우 급여에 대해서 내림차순으로 정렬하시오.

select d.deptname,e.empname,e.title,e.salary
from employee e join  department d on e.dno = d.deptno 
order by  deptname, salary desc;


select d.deptname,e.empname,e.title,e.salary
from  department d join employee e  on d.deptno = e.dno 
order by  deptname, salary desc;





-- 17 박영권과 같은 직급을 갖는 모든 사원들 이름과 직급을 검색하는 sql문을 작성하시오.

select empname, title
from employee
where title = (select title from employee where empname = '박영권');


-- 18 영업부나 개발부에 근무하는 사원들의 이름을 검색하는 sql문을 작성하시오 (중첩질의를 이용)

select empname
from employee 
where dno in(select deptno from department  where deptname = '영업' or deptname = '개발') ;



-- 이 질의를 중첩 질의를 사용하지 않은 다음과 같은 조인 질의로 나타낼 수 있다. 실제로 중첩질의를 사용하여 표현된 대부분의 질의를 중첩 질의가 없는 조인 질의로 표현할 수 있다.
SELECT EMPNAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DNO = D.DEPTNO AND (D.DEPTNAME = ‘영업’ OR D.DEPTNAME = ‘개발’); 

-- 19 질의 : 영업부나 개발부에 근무하는 사원들의 이름을 검색하라. exists를 이용
SELECT EMPNAME
FROM EMPLOYEE E
WHERE EXISTS
(SELECT *
FROM DEPARTMENT D
WHERE E.DNO = D.DEPTNO
AND (DEPTNAME = '영업' OR DEPTNAME = '개발');

-- 20 질의 : 자신이 속한 부서의 사원들의 평균급여보다 많은 급여를 받는 사원들에 대해서 이름, 부서번호, 급여를 검색하라. (상관중첩질의)

SELECT EMPNAME, DNO, SALARY
FROM EMPLOYEE E
WHERE SALARY >
(SELECT AVG(SALARY)
FROM EMPLOYEE
WHERE DNO = E.DNO);


-- 21  질의 : 방법1을 이용하여 급여가 많이 받는 사원 순으로 순위를 검색하라. (스칼라쿼리)  ??? 순위별 오름차순
select empname, salary,
(select count(*)+1 from employee sub_e where salary > e.salary) as rank  ???


-- 22 질의 : EMPLOYEE 릴레이션에 대해서 “3번 부서에 근무하는 사원들의 사원번호, 사원이름, 직책, 부서번호으로 이루어진 뷰”
를 정의하시오. (뷰 이름 : vw_employee_dno3)
아래의 뷰의 정의에는 뷰의 애트리뷰트들을 별도로 명시했기 때문에 뷰에는 EMPNO, EMPNAME, TITLE의 세 애트리뷰트
가 포함됨
CREATE VIEW vw_employee_dno3 (ENO, ENAME, TITLE, DNO) AS
SELECT EMPNO, EMPNAME, TITLE, DNO
FROM EMPLOYEE
WHERE DNO=3;


-- 24번 company 데이터베이스만 select, ilnsert, delete, update 할 수 있는 권한을 가진 user_copany 계정을 추가하는 하나의 sql문장을 작성하시오.
-- 단, 비밀번호는'123456'으로 하시오

select user(), database();
grant  select ,insert,delete,update on company.* to 'user_company'@'localhost' identified by '123456';
 































