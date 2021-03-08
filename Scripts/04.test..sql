select user(), database();

-- 1. 데이터베이스 생성
create database test_coffee; 


drop user 'user_hospital'@'localhost';


-- 유저 생성
grant all on hospital.*
	to 'user_hospital'@'localhost' identified by 'rootroot';
	