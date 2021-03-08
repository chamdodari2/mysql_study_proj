select user(),database ();

-- 병원
DROP SCHEMA IF EXISTS Hospital;

-- 병원
CREATE SCHEMA Hospital;

-- 환자
CREATE TABLE Hospital.Patient (
	patient_no   CHAR(5)     NOT NULL COMMENT '환자번호', -- 환자번호
	name         VARCHAR(50) NULL     COMMENT '이름', -- 이름
	age          INTEGER     NULL     COMMENT '나이', -- 나이
	disease_code CHAR(3)     NULL     COMMENT '질병코드' -- 질병코드
)
COMMENT '환자';

-- 환자
ALTER TABLE Hospital.Patient
	ADD CONSTRAINT PK_Patient -- 환자 기본키
		PRIMARY KEY (
			patient_no -- 환자번호
		);

-- 질병
CREATE TABLE Hospital.disease (
	disease_code CHAR(3)      NOT NULL COMMENT '질병코드', -- 질병코드
	disease_name VARCHAR(50)  NULL     COMMENT '질병명', -- 질병명
	symptom      VARCHAR(255) NULL     COMMENT '증상' -- 증상
)
COMMENT '질병';

-- 질병
ALTER TABLE Hospital.disease
	ADD CONSTRAINT PK_disease -- 질병 기본키
		PRIMARY KEY (
			disease_code -- 질병코드
		);

-- 환자
ALTER TABLE Hospital.Patient
	ADD CONSTRAINT FK_disease_TO_Patient -- 질병 -> 환자
		FOREIGN KEY (
			disease_code -- 질병코드
		)
		REFERENCES Hospital.disease ( -- 질병
			disease_code -- 질병코드
		);