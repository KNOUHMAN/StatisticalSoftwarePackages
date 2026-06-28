/* 일원 분산분석 - 균형자료*/
* 예제 8.1 섬유 장력 데이터;
DATA cotton;
INPUT pct @;
	DO i = 1 TO 5;
		INPUT tensile @@; OUTPUT;
	END;
DATALINES;
15 7 7 15 11 9
20 12 17 12 18 18
25 14 18 18 19 19
30 19 25 22 19 23
35 7 10 11 15 11
;
RUN;
PROC ANOVA DATA = cotton;
CLASS pct;
MODEL tensile = pct;
MEANS pct / TUKEY DUNCAN;
RUN;

/* 일원 분산분석 - 불균형자료*/
* 예제 8.2 사료별 돼지의 체중 증가 데이터;
DATA pig;
INPUT feed weight @@;
DATALINES;
1 60.8 1 57.0 1 65.0 1 58.6 1 61.7
2 68.7 2 67.7 2 74.0 2 66.3 2 69.8
3 102.6 3 102.1 3 100.2 3 96.5
4 87.9 4 84.2 4 83.1 4 85.7 4 90.3
RUN;
PROC GLM DATA = pig;
CLASS feed;
MODEL weight = feed;
MEANS feed / LINES TUKEY;
RUN;

/* 일원 분산분석 - 불균형자료*/
*예제 mylib.auto 데이터(5.3절 참고);
LIBNAME mylib "C:\sasdata"; RUN;
PROC IMPORT OUT = mylib.auto
DATAFILE = "C:\exdata\auto.txt"
DBMS = TAB REPLACE;
GETNAMES = YES; DATAROW = 2;
RUN;
PROC GLM DATA = mylib.auto ;
CLASS drtype;
MODEL price = drtype;
MEANS drtype/LINES DUNCAN;
RUN;
PROC GLM DATA = mylib.auto;
CLASS drtype;
MODEL price = drtype;
MEANS drtype/LINES TUKEY;
RUN;


/*상호작용이 없는 이원 분산분석*/
*예제 8.4 새의 칼슘 데이터;
DATA birds;
INPUT hormone $ gender $ calcium @@;
DATALINES;
Yes Female 39.1 Yes Male 32.0 No Female 16.5 No Male 14.5
Yes Female 26.2 Yes Male 23.8 No Female 18.4 No Male 11.0
Yes Female 21.3 Yes Male 28.8 No Female 12.7 No Male 10.8
Yes Female 35.8 Yes Male 25.0 No Female 14.0 No Male 14.3
Yes Female 40.2 Yes Male 29.3 No Female 12.8 No Male 10.0
;
RUN;
PROC GLM DATA = birds;
CLASS hormone gender;
MODEL calcium = hormone gender hormone*gender;
RUN;

/*상호작용이 있는 이원 분산분석*/
*예제 mylib.auto 데이터(5.3절 참고);
LIBNAME mylib "C:\sasdata"; RUN;
PROC IMPORT OUT = mylib.auto
DATAFILE = "C:\exdata\auto.txt"
DBMS = TAB REPLACE;
GETNAMES = YES; DATAROW = 2;
RUN;
PROC GLM DATA = mylib.auto;
CLASS region drtype;
MODEL price = region drtype region*drtype;
MEANS region*drtype/LINE DUNCAN;
RUN;

** 이원 분산분석: 다중비교  DUNCAN 방법;
DATA mylib.auto;
SET mylib.auto;
IF region = 'AREA1' AND drtype = 'FWD' THEN re_ty = 'A1_FWD';
IF region = 'AREA1' AND drtype = 'RWD' THEN re_ty = 'A1_RWD';
IF region = 'AREA1' AND drtype = 'AWD' THEN re_ty = 'A1_AWD';
IF region = 'AREA2' AND drtype = 'FWD' THEN re_ty = 'A2_FWD';
IF region = 'AREA2' AND drtype = 'RWD' THEN re_ty = 'A2_RWD';
IF region = 'AREA2' AND drtype = 'AWD' THEN re_ty = 'A2_AWD';
RUN;
PROC GLM DATA = mylib.auto;
CLASS re_ty;
MODEL price = re_ty;
MEANS re_ty/LINE DUNCAN;
RUN;
