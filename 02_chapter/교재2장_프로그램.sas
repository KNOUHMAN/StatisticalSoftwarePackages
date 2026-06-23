/*[프로그램2.1]*/
DATA class; /* DATA WORK.class; */ 
INPUT name $ number gender $ dept $ exam1 exam2;
DATALINES;
Minyoung 1 F Stat 50 50
Minji 2 F Computer 50 50
Kongjui 6 F Computer 20 40
Patjui 3 F Stat 20 45
Heungboo 5 M Computer 25 25
Nolboo 4 M Stat 29 28
;
RUN;
DATA new; 
SET class;
score = exam1 + exam2;
RUN;
DATA new; 
SET new;
average = score/2;
RUN;

PROC PRINT DATA=new; RUN;


/*2.3.1 INPUT 자유입력*/
DATA list_input;
INPUT lastname $ age height weight children;
DATALINES;
LEE            33  180  80   2
KIM            40  168  65   1
CHOI           25  174  73   0
;
run;

/*2.3.2 INPUT 열입력*/
DATA column_input;
INPUT lastname $ 1-15 age 16-17 height 20-22 weight 25-26 children 30;
DATALINES;
LEE            33  180  80   2
KIM            40  168  65   1
CHOI           25  174  73   0
;
run;

/*2.3.3 INPUT 포맷입력*/
DATA formatted_input;
INPUT lastname $CHAR15. age 2. height 5. weight 4. children 4.;
DATALINES;
LEE            33  180  80   2
KIM            40  168  65   1
CHOI           25  174  73   0
;
run;

/*2.3.4 INPUT 혼용입력*/
DATA mixed_input;
INPUT lastname $ age 16-17 height 5. weight 4. children 30;
DATALINES;
LEE            33  180  80   2
KIM            40  168  65   1
CHOI           25  174  73   0
;
run;

/*2.3.5 INPUT 포인터*/
DATA pointer_input;
INPUT #1 name $ 1-15 #3 children #2 @10 weight 2. #3;
DATALINES;
LEE SOON SHIN
33  180  80
2
KIM JUNG HO
40  168  65
1
CHOI CHEE WON
25  174  73
0
;
RUN;

/*2.3.6 INPUT 줄 포인터의 이동 정지  @@ - 한 줄에 여러 관측이 있는 경우*/
DATA line_pointer_input1;
INPUT lastname $ age height weight children @@;
DATALINES;
LEE 33 180 80 2 KIM 40 168 65 1 PARK 25 174 73 0
;
RUN;

/*INPUT 줄 포인터의 이동 정지 @ - 상황에 따라 입력 형식이 바뀔 경우*/
DATA line_pointer_input2;
INPUT status $ 1 @;
IF status='P'
	THEN INPUT course $ profname $ 12-32;
ELSE IF status='S'
	THEN INPUT course $ number name $ 19-39;
DATALINES;
P STAT-101 SUNG NAE KYUNG
S STAT-101 901123 KIM AH MOO GAE
S MATH-205 901242 HONG NOO GOO
;
RUN;


/*2.3.7 INPUT 그룹 포맷입력*/
DATA group_formatted_input1;
INPUT x1 4. x2 4. x3 4. x4 4. x5 4.; 
DATALINES;
23414598385703845126
;
run;
DATA group_formatted_input2;
INPUT (x1 x2 x3 x4 x5) (4. 4. 4. 4. 4.);
DATALINES;
23414598385703845126
;
run;
DATA group_formatted_input3;
INPUT (x1-x5) (5*4.);
DATALINES;
23414598385703845126
;
run;
DATA group_formatted_input4;
INPUT (x1-x5) (4.); 
DATALINES;
23414598385703845126
;
run;


/* 2.4 DATALINES 문장*/
DATA temp;
INPUT x y;
DATALINES;
1 2.2
2 4.0
3 5.7
4 8.4
5 9.9
;
RUN;

/*2.6 INFILE 문장 [프로그램 1.2]*/
DATA aaa;
INFILE 'C:\data\package\example.txt' DLM='09'X;
INPUT name $ number gender $ dept $ exam1 exam2;
RUN;

/*2.7 자료 입력의 포맷*/
DATA b;
INPUT y 6.2;
DATALINES;
1234  
  1234
 12.34
;
RUN;
DATA c;
INPUT @1 country $7.;
DATALINES;
KOREA  
 KOREA 
  KOREA
;
RUN;

DATA c1;
INPUT country $ 1-7;
DATALINES;
KOREA  
 KOREA 
  KOREA
;
RUN;
DATA c2;
INPUT @1 country $CHAR7.;
DATALINES;
KOREA  
 KOREA 
  KOREA
;
RUN;

/*2.7 OUTPUT 문장*/
DATA sample;
INPUT x y;
z = x+y;
DATALINES;
1 23
2 15
3 36
;
RUN;

DATA stat math;
INPUT course $ name $ score1 score2 score3;
IF course='Stat' THEN OUTPUT stat;
					 ELSE OUTPUT math;
DATALINES;
Stat Sung 30 30 40
Math Kim 20 20 30
Stat Lee 10 10 20
Math Park 25 25 35
;
RUN;
PROC PRINT DATA = stat; RUN;

/* 2.8 DO문장*/
DATA example;
	DO i = 1 TO 5 BY 1;
		square = i*i; OUTPUT;
	END;
RUN;

/*2.9 데이터 입력 사례 1 : 일반적인 입력*/
DATA apple;
INPUT variety $ yield;
DATALINES;
A 13
A 19
A 39
A 38
A 22
A 25
A 10
B 27
B 31
B 36
B 29
B 45
B 32
B 44
C 40
C 44
C 41
C 37
C 36
C 38
C 35
D 17
D 28
D 41
D 45
D 15
D 13
D 20
E 36
E 32
E 34
E 29
E 25
E 31
E 30
;
RUN;

/*데이터 입력 사례 2 : 한 줄에 여러 관측값 입력*/
DATA apple;
INPUT variety $ yield @@;
DATALINES;
A 13 B 27 C 40 D 17 E 36
A 19 B 31 C 44 D 28 E 32
A 39 B 36 C 41 D 41 E 34
A 38 B 29 C 37 D 45 E 29
A 22 B 45 C 36 D 15 E 25
A 25 B 32 C 38 D 13 E 31
A 10 B 44 C 35 D 20 E 30
;
RUN;

/*데이터 입력 사례 3 :  DO문장 활용*/
DATA apple;
	DO variety = 'A','B','C','D','E';
		INPUT yield @@; OUTPUT;
	END;
DATALINES;
13 27 40 17 36
19 31 44 28 32
39 36 41 41 34
38 29 37 45 29
22 45 36 15 25
25 32 38 13 31
10 44 35 20 30
;
RUN;

/*2.10 PRINT 프로시저 */
DATA class;
INPUT name $ number gender $ dept $ exam1 exam2;
DATALINES;
Minyoung 1 F Stat 50 50
Minji 2 F Computer 50 50
Kongjui 6 F Computer 20 40
Patjui 3 F Stat 20 45
Heungboo 5 M Computer 25 25
Nolboo 4 M Stat 29 28
;
RUN;
PROC PRINT DATA = class(obs=3);
RUN;
PROC PRINT DATA = class NOOBS;
RUN;

/*2.10.1 ID 문장*/
PROC PRINT DATA=class;
ID name;
RUN;
PROC PRINT DATA=class;
ID name dept;
RUN;
PROC PRINT DATA=class;
ID number;
RUN;

/*2.10.2 VAR 문장*/
PROC PRINT DATA = class;
ID number;
VAR dept name gender;
RUN;

/*2.10. 3 BY 문장*/
PROC SORT DATA = class;
BY dept;
RUN;
PROC PRINT DATA = class;
BY dept;
RUN;
PROC PRINT DATA = class;
ID number;
BY dept;
VAR name gender exam1 exam2;
RUN;


LIBNAME mylib "C:\sasdata"; RUN;
DATA mylib.example;
INPUT name $ number gender $ dept $ exam;
DATALINES;
Minyoung 	1 F 	Stat 			50
Minji 			2 F 	Computer 	50
Kongjui 		6 F 	Computer 	30
Patjui 			3 F 	Stat 			32.5
Heungboo 	5 M 	Computer 	25
Nolboo 		4 M 	Stat 			28.5
;
RUN;
PROC FORMAT;
VALUE fexam low -< 30 = '하'
				   30 -< 50 = '중'
				    50 - high = '상';
VALUE $fgender 'F' = '여자'
					 'M' = '남자';
RUN;
PROC PRINT;
RUN ;
PROC PRINT DATA = mylib.example ;
FORMAT exam fexam. gender $fgender. ;
RUN;

/* 2.12 SORT 프로시저*/
DATA class;
INPUT name $ number gender $ dept $ exam1 exam2;
DATALINES;
Minyoung 1 F Stat 50 50
Minji 2 F Computer 50 50
Kongjui 6 F Computer 20 40
Patjui 3 F Stat 20 45
Heungboo 5 M Computer 25 25
Nolboo 4 M Stat 29 28
;
RUN;
/* 2.12.1 DATA와 OUT 지정*/
PROC SORT DATA = class;
BY dept;
RUN;
PROC SORT OUT = new;
BY dept;
RUN;

/*2.12.2  BY 문장*/
PROC SORT DATA=class OUT=new;
BY DESCENDING gender dept;
RUN;

PROC SORT DATA=class OUT=new;
BY DESCENDING gender DESCENDING dept;
RUN;

/* 2.13 SET 문장*/
DATA temp;
SET class;
RUN;

DATA one;
SET new (KEEP = name number gender);
RUN;
DATA two;
SET new (KEEP = name score);
RUN;

DATA one(KEEP = name number gender) two(KEEP = name score);
SET new;
RUN;

DATA males;
SET new;
IF gender = 'M';
RUN;
DATA females;
SET new;
IF gender = 'F';
RUN;

DATA males females;
SET new;
IF gender = 'M' THEN OUTPUT males;
					ELSE OUTPUT females;
RUN;

DATA final;
SET new;
IF score >= 50 THEN c='Pass';
					ELSE c='Fail';
RUN;

DATA whole;
SET males females;
RUN;

DATA a1;
INPUT name $ gender $ @@;
DATALINES;
Sung M Park F Kim M Lee F
;
RUN;
DATA a2;
INPUT name $ gender $ @@;
DATALINES;
Moon F Yoon M Oh M Jang F
;
RUN;
DATA b;
SET a1 a2;
RUN;

/*2.14 MERGE 문장*/
/*2.14.1 일대일 병합*/
DATA owner; 
INPUT name $ @@;
DATALINES;
Naekyung Minyoung Minji
;
RUN;
DATA car; 
INPUT year make $ model $;
DATALINES;
1998 Daewoo Leganza
2000 Kia Sephia
1999 Hyundai Atoz
;
RUN;
DATA color;
INPUT color $ @@;
DATALINES;
Silver Purple White Red
;
RUN;
DATA driver;
MERGE owner car color;
RUN;

/*2.14.2 짝짓기 병합 */
/* [프로그램 2.2] */
DATA car;
INPUT name $ year make $ model $;
DATALINES;
Naekyung 1998 Daewoo Leganza
Minyoung 2000 Kia Sephia
Minji 1999 Hyundai Atoz
;
RUN;
DATA color;
INPUT name $ color $;
DATALINES;
Minyoung Purple
Naekyung Silver
Aree Grey
Minji White
;
RUN;
DATA driver;
MERGE car color; /* 잘못된 짝짓기 병합 */
BY name;
RUN;
PROC SORT DATA=car;
BY name;
RUN;
PROC SORT DATA=color;
BY name;
RUN;
DATA driver;
MERGE car color;
BY name;
RUN;

/* 2.15 IF-THEN/ELSE 문장*/
DATA class;
INPUT name $ gender $ age @@;
DATALINES;
Sung M 33 Park M 28 Huh F 19
Moon F 29 Ahn M 34 Kim M 42
;
RUN;
DATA males;
SET class;
IF gender = 'M';
RUN;

DATA new;
SET class;
IF gender='M' THEN gender='male';
RUN;

DATA class;
SET class;
IF gender='M'	THEN gender='Male';
					ELSE gender='Female';
RUN;

DATA year_test;
INPUT year;
DATALINES;
2000
2100
2024
2026
;
RUN;
DATA year_test;
set year_test;
IF MOD(year, 400) = 0 THEN February = 29;
    						  ELSE IF MOD(year, 100) = 0 THEN February = 28;
    																ELSE IF MOD(year, 4) = 0 THEN February = 29;
    																								  ELSE February = 28;
RUN;


/*2.16 DELETE 문장*/
DATA males;
INPUT name $ gender $ age;
IF gender = 'F' THEN DELETE;
DATALINES;
Sung M 33
Moon F 29
Ahn M 34
;
RUN;


/* 2.17자료의 분할*/
DATA class;
INPUT name $ number gender $ dept $ exam1 exam2;
DATALINES;
Minyoung 1 F Stat 50 50
Minji 2 F Computer 50 50
Kongjui 6 F Computer 20 40
Patjui 3 F Stat 20 45
Heungboo 5 M Computer 25 25
Nolboo 4 M Stat 29 28
;
RUN;
/*방법 1*/
DATA males;
SET class; IF gender="M";
RUN;
DATA females;
SET class; IF gender="F";
RUN;
/*방법 2*/
DATA males females;
SET class;
IF gender="M" THEN OUTPUT males;
				  ELSE OUTPUT females;
RUN;

/*2.18 결측값의 처리*/
DATA;
INPUT name $ gender;
DATALINES;
Nolboo	0
Sabangee .
.			1
;
RUN;

DATA;
INPUT name $ 1-8 gender 10;
DATALINES;
Nolboo   0
Sabangee .
         1
;
RUN;

/* 2.19 응용*/
/*예제 2.1*/
DATA gasoline;
	DO driver = 1 TO 4;
		DO car = 1 TO 4;
			INPUT gas $ km @; OUTPUT;
		END;
	END;
DATALINES;
D 15.5 B 33.9 C 13.2 A 29.1
B 16.3 C 26.6 A 19.4 D 22.8
C 10.8 A 31.1 D 17.1 B 30.3
A 14.7 D 34.0 B 19.7 C 21.6
;
RUN;
/*예제 2.2*/
DATA soybean;
	DO insecide = 1 TO 3;
		DO block = 1 TO 4;
			INPUT seedings @; OUTPUT;
		END;
	END;
DATALINES;
56 49 65 60
84 78 94 93
80 72 83 85
;
RUN;
/*예제 2.3*/
DATA linear;
INPUT sales ad;
logsales = LOG(sales);
DATALINES;
2.5 1.0
2.6 1.6
2.7 2.5
5.0 3.0
5.3 4.0
9.1 4.6
14.8 5.0
17.5 5.7
23.0 6.0
28.0 7.0
;
RUN;
