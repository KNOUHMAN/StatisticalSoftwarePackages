/* 영구라이브러리 설정 */
LIBNAME mylib "C:\sasdata"; RUN;

/* 예제데이터 mylib.auto */
/* 엑셀 데이터 가져오기 */
PROC IMPORT OUT = mylib.auto
DATAFILE = "C:\sasdata\auto.xlsx"
DBMS = EXCEL REPLACE;
RANGE = "Sheet$"; 
RUN;
/**** 참고: 라벨블 붙이기 ****/
DATA mylib.auto;
SET mylib.auto;
LABEL price = '권장소비자가격'; 				LABEL invoice = '딜러도매가격';
LABEL biprice = '로지스틱회귀종속변수'; 	LABEL hp = '마력';
LABEL es = '엔진배기량'; 							LABEL mpg = '연비';
LABEL age = '자동차나이';							LABEL region = '생산지역';
LABEL drtype = '구동방식';
RUN;

/* 텍스트 데이터 가져오기 - 구분자 TAB */
LIBNAME mylib "C:\sasdata"; RUN;
PROC IMPORT OUT = mylib.auto
DATAFILE = "C:\sasdata\auto.txt"
DBMS = TAB REPLACE;
GETNAMES = YES; DATAROW = 2;
RUN;


/*5.3.1 MEANS 프로시저*/
/*CONTENTS 프로시저 : 변수 특성 확인 */
PROC CONTENTS DATA = mylib.auto VARNUM; 
RUN;

* MEASN 프로시저: 디폴트 출력 형태 ;
PROC MEANS DATA = mylib.auto;
VAR price invoice biprice hp es mpg age;
RUN;

/*** 참고***/
DATA mulib.auto_keep;
SET mylib.auto;
KEEP price hp es mpg;
RUN;

** MEANS 프로시저 옵션: FW와 통계량의 지정 ;
PROC MEANS DATA=mylib.auto FW=5 N MEAN STD MIN MAX RANGE;
VAR price invoice biprice hp es mpg age;
RUN;

*** MEANS 프로시저: 여러가지 통계량 산출 ;
PROC MEANS DATA=mylib.auto 
FW=5 SUM P10 P25 MEDIAN P75 P90;
VAR price es mpg;
RUN;

**** MEANS 프로시저: CLASS 문장 ;
PROC MEANS DATA=mylib.auto
FW=5 N MEAN STD MIN MAX;
CLASS region;
VAR price es mpg age;
RUN;

***** MEANS 프로시저: BY 문장 ;
PROC SORT DATA=mylib.auto OUT=mylib.auto_sort;
BY region;
RUN;
PROC MEANS DATA=mylib.auto_sort 
FW=5 N MEAN STD MIN MAX;
BY region;
VAR price es mpg age;
RUN;

/*5.3.2 UNIVARIATE 프로시저*/
*UNIVARIATE 프로시저: 디폴트 출력 형태;
PROC UNIVARIATE DATA = mylib.auto PLOT;
VAR es; 
RUN;

**UNIVARIATE 프로시저: BY 그룹별 상자그림 ;
PROC SORT DATA=mylib.auto OUT=mylib.auto_sort;
BY region; 
RUN;
PROC UNIVARIATE DATA = mylib.auto_sort PLOT;
VAR es;
BY region; 
RUN;



/*5.6.1 FREQ 프로시저*/
*FREQ 프로시저: 일차원 빈도표 디폴트 출력 형태;
PROC FREQ DATA = mylib.auto; TABLES region;RUN;

PROC FREQ DATA = mylib.auto; TABLES drtype; RUN;

PROC FREQ DATA = mylib.auto;TABLES region drtype;RUN;

****** FREQ 프로시저: 가중치 부여;
DATA aaa;
SET mylib.auto;
IF drtype in ('AWD','FWD')	THEN drtype_wgt = 1; *drtype에 따른 가중치 변수 생성;
										ELSE drtype_wgt = 2;
RUN;
PROC FREQ DATA = aaa;
WEIGHT drtype_wgt; 
TABLES drtype;
RUN;

**FREQ 프로시저: 이차원 분할표 디폴트 출력 형태 ;
PROC FREQ DATA = mylib.auto;
TABLES region * drtype;
RUN;
**** FREQ 프로시저: 카이제곱 독립성 검정 ;
PROC FREQ DATA = mylib.auto;
TABLES region * drtype/CHISQ;
RUN;

*** FREQ 프로시저: 이차원 분할표 출력 통계량 지정;
PROC FREQ DATA = mylib.auto; TABLES region * drtype/NOFREQ; RUN;
PROC FREQ DATA = mylib.auto; TABLES region * drtype/NOROW; RUN;
PROC FREQ DATA = mylib.auto; TABLES region * drtype/NOCOL; RUN;
PROC FREQ DATA = mylib.auto; TABLES region * drtype/NOPERCENT; RUN;
PROC FREQ DATA = mylib.auto; TABLES region * drtype/NOROW NOPERCENT; RUN;
PROC FREQ DATA = mylib.auto; TABLES region * drtype/NOCOL NOPERCENT; RUN;
PROC FREQ DATA = mylib.auto; TABLES region * drtype/NOROW NOCOL; RUN;
PROC FREQ DATA = mylib.auto; TABLES region * drtype/NOROW NOCOL NOPERCENT; RUN;



***** FREQ 프로시저: 결과를 다른 SAS 데이터세트로 저장 ;
PROC FREQ DATA = mylib.auto NOPRINT; * NOPRINT: OUTPUT 창에 결과를 출력하지 말 것! ;
TABLES region*drtype/OUT = freqout1;
run;
PROC FREQ DATA = mylib.auto NOPRINT;
TABLES region*drtype/OUT = freqout2 OUTPCT ; * OUTPCT: 행 백분율과 열 백분율도 저장;
RUN;


