/ 테이블 스페이스 생성 /
CREATE TABLESPACE smartInStudy
DATAFILE 'E:\Smart_In_Study\DataBase\Smart_In_Study.ORA' SIZE 1G
/파일의 이름과 경로 지정, 사이즈 설정/
AUTOEXTEND ON NEXT 1G MAXSIZE 3G
/ 파일크기가 10M 이상이면 자동으로 10M 만 자동확장, 최대 사이즈 1024M 지정 /
EXTENT MANAGEMENT LOCAL
/EXTENT : 데이터를 관리할때 가장 작은 단위 /
SEGMENT SPACE MANAGEMENT AUTO;
/데이터 저장공간을 오라클 DBMS가 자동으로 관리되게 해주는 옵션 /

/ 계정 생성 /
CREATE USER SISDBA
IDENTIFIED BY "1q2w3e4r"
DEFAULT TABLESPACE smartInStudy
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON smartInStudy;

/ 권한 지정 /
GRANT DBA, CONNECT TO SISDBA;