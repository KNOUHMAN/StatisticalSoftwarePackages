/*[프로그램 1.1]*/
/*데이터 직접 입력하기*/
/* 별도의 라이브러리를 지정하지 않으면 생성된 SAS 데이터세트는 임시로 자동 생성되는 WORK 라이브러리에 표시되며, 
SAS 종료 시 자동으로 삭제된다. ‘WORK.’은 SAS의 기본값(default) 중 하나이므로 입력하지 않아도 된다.*/
DATA aaa; /* aaa 대신 WORK.aaa로 입력 가능 */
INPUT name $ number gender $ dept $ exam1 exam2;
DATALINES; /* 또는 CARDS; */
Minyoung 1 F Stat 50 50
Minji 2 F Computer 50 50
Kongjui 6 F Computer 20 40
Patjui 3 F Stat 20 45
Heungboo 5 M Computer 25 25
Nolboo 4 M Stat 29 28
;
RUN;
/*SAS 데이터 출력하기*/
PROC PRINT DATA = aaa;
RUN;

/*[프로그램 1.2]*/
/*텍스트 파일(example.txt) 불러와서 SAS 데이터 생성하기*/
DATA aaa;
INFILE 'C:\data\package\example.txt';
INPUT name $ number gender $ dept $ exam1 exam2;
RUN;
/*SAS 데이터 출력하기*/
PROC PRINT DATA=aaa;
RUN;

/*[프로그램 1.3]*/
/*엑셀 파일(example.xlsx) 불러와서 SAS 데이터 생성하기*/
PROC IMPORT DBMS = EXCEL
DATAFILE = "C:\data\package\example.xlsx"
OUT = aaa
REPLACE ;
RANGE = "Sheet1$";
RUN;
/*SAS 데이터 출력하기*/
PROC PRINT DATA = aaa;
RUN;

/*[프로그램 1.4.1]*/
/*영구 라이브러리 ‘mylib’ 지정*/
LIBNAME mylib 'C:\sasdata'; RUN;
/*임시 라이브러리에 있는 ‘aaa’(또는 ‘WORK.aaa’) SAS 데이터를 영구 라이브러리‘mylib’에 ‘bbb’ SAS 데이터로 저장하기*/
DATA mylib.bbb;
SET aaa; /* aaa 대신 WORK.aaa로 입력해도 됨*/
RUN;
/*SAS 데이터 출력하기*/
PROC PRINT DATA = mylib.bbb;
RUN;

/*[프로그램 1.4.2]*/
/* 영구 라이브러리 동시에 생성 */
/* 아래의 프로그램 코딩 전 “C:\ANA_1_DATA”, “C:\ANA_2_DATA”, “C:\ANA_3_DATA” 폴더 우선 생성 */
LIBNAME ANA_1 'C:\ANA_1_DATA'; RUN;
LIBNAME ANA_2 'C:\ANA_2_DATA'; RUN;
LIBNAME ANA_3 'C:\ANA_3_DATA'; RUN;


/*[프로그램 1.5]*/
/*MEANS 프로시저를 이용한 exam1 변수의 기술통계량 출력*/
PROC MEANS DATA = mylib.bbb;
VAR exam1;
RUN;

/*[프로그램 1.6]*/
/*UNIVARIATE 절차를 이용한 exam1 변수의 기술통계량 출력*/
PROC UNIVARIATE DATA = mylib.bbb;
VAR exam1;
RUN;

/*[프로그램 1.7]*/
/*영구 라이브러리 ‘mylib’ 지정*/
LIBNAME mylib 'C:\sasdata';
/*성별(gender)과 시험성적(exam2) 변수에 대한 빈도표 출력하기*/
PROC FREQ DAT A =mylib.bbb;
TABLES gender*exam2;
RUN;

/*[프로그램 1.8]*/
/*시험성적(exam2) 변수에 대한 히스토그램 출력하기*/
PROC UNIVARIATE DATA = mylib.bbb;
VAR exam2;
HISTOGRAM exam2;
RUN;

/*[프로그램 1.9]*/
/*시험성적(exam2)과 성별(gender) 변수에 대한 상자그림 출력하기*/
PROC SORT DATA = mylib.bbb; BY gender; RUN;
PROC BOXPLOT DATA = mylib.bbb;
PLOT exam2*gender;
RUN;

/*[프로그램 1.10]*/
/*새로운 변수가 포함된 SAS 데이터 ‘mylib.ccc’ 생성*/
DATA mylib.ccc;
SET mylib.bbb;
exam_mean = mean(exam1,exam2);
RUN;


/*[프로그램 1.11]*/
/*사용자 출력 포맷 작성을 통한 연속형 변수의 범주형 변수로의 변환*/
PROC FORMAT;
VALUE f_exam_mean low -< 30 = '하'
							30 -< 50 = '중'
							50 - high = '상';
VALUE $f_gender 'F' = '여자'
					  'M' = '남자';
RUN;
/*새로운 변수 생성한 파일에 format한 변수 넣은 후 영구 라이브러리에 ‘mylib.ddd’로 저장하기 */
DATA mylib.ddd;
SET mylib.ccc;
FORMAT exam_mean f_exam_mean. gender $f_gender.;
LABEL exam_mean = '평균 성적' gender = '성별';
RUN;

/*[프로그램 1.12]*/
/*이차원 분할표*/
PROC FREQ DATA = mylib.ddd;
TABLES exam_mean*gender;
RUN;


/*[프로그램 1.13]*/
/*막대그래프*/
PROC CHART DATA = mylib.ddd;
VBAR name/SUMVAR = exam1;
RUN;



/*[프로그램 1.14]*/
/*산점도*/
PROC PLOT DATA = mylib.ddd;
PLOT exam1*name = 'A' exam2*name = 'B'/HPOS = 70 VPOS = 20 OVERLAY;
RUN;
