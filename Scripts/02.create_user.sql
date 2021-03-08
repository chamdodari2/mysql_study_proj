drop user 'user_hospital'@'localhost';


-- 유저 생성
grant all on hospital.*
	to 'user_hospital'@'localhost' identified by 'rootroot';
	
