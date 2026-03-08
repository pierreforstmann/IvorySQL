--
-- ora_listagg.sql: test LISTAGG aggregate 
--
--
CREATE TABLE emp(deptno number, ename varchar2(30), sal number, dob date);

ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-YYYY';

INSERT INTO emp VALUES
  (1, 'KING', 1000, '01-JAN-1960'),
  (1, 'JOHN', 900, '01-JAN-1961'),
  (1, 'PAUL' , 800, '01-JAN-1962'),
  (2, 'DAVID', 700, '01-JAN-1963'),
  (2, 'PETER', 600, '01-JAN-1964'),
  (3, 'MARK', 500, '01-JAN-1965');
  (1, NULL,  NULL, NULL),          -- NULLs mixed into an existing group
  (4, NULL,  NULL, NULL),          -- all-NULL group
  (4, NULL,  NULL, NULL);


SELECT deptno,
       listagg(ename, ',' ORDER BY ename) AS employees
FROM emp
GROUP BY deptno
ORDER BY deptno;

SELECT deptno,
       listagg(sal, ',' ORDER BY sal) AS employees
FROM emp
GROUP BY deptno
ORDER BY deptno;

SELECT deptno,
       listagg(dob, ',' ORDER BY dob) AS employees
FROM emp
GROUP BY deptno
ORDER BY deptno;

SELECT deptno,
       listagg(ename, NULL ORDER BY ename) AS employees
FROM emp
GROUP BY deptno
ORDER BY deptno;

SELECT deptno,
       listagg(NULL::varchar2, ',' ORDER BY ename) AS employees
FROM emp
GROUP BY deptno
ORDER BY deptno;

-- NULL rows are skipped; mixed group still produces output
SELECT deptno,
       listagg(ename, ',' ORDER BY ename) AS employees
FROM emp
WHERE deptno IN (1, 4)
GROUP BY deptno
ORDER BY deptno;
