/*7.3.1 CORR 프로시저*/
*예제 mylib.auto 데이터(5.3절 참고);
LIBNAME mylib "C:\sasdata"; RUN;
PROC IMPORT OUT = mylib.auto
DATAFILE = "C:\exdata\auto.txt"
DBMS = TAB REPLACE;
GETNAMES = YES; DATAROW = 2;
RUN;
** 상관분석 ;
PROC CORR DATA = mylib.auto;
VAR price hp es mpg age ;
RUN;
*** 상관분석: 단순통계량 출력 제외 ;
PROC CORR DATA = mylib.auto NOSIMPLE;
VAR price hp es mpg age ;
RUN;
**** 상관분석:필요한 변수 간 상관계수만 출력;
PROC CORR DATA = mylib.auto NOSIMPLE;
VAR hp es mpg age;
WITH price;
RUN;


/*7.3.2 REG 프로시저*/
*예제 mylib.auto 데이터(5.3절 참고);
LIBNAME mylib "C:\sasdata"; RUN;
PROC IMPORT OUT = mylib.auto
DATAFILE = "C:\exdata\auto.txt"
DBMS = TAB REPLACE;
GETNAMES = YES; DATAROW = 2;
RUN;
** 다중 선형 회귀분석 ;
PROC REG DATA = mylib.auto;
MODEL price = hp es mpg age;
RUN;
*** 다중 선형 회귀분석-표준화 회귀계수와 다중공선성 검정 ;
PROC REG DATA = mylib.auto;
MODEL price = hp es mpg age/STB VIF;
RUN;
**** 다중 선형 회귀분석-변수 선택 ;
PROC REG DATA = mylib.auto;
MODEL price = hp es mpg age / SELECTION = BACKWARD;
MODEL price = hp es mpg age / SELECTION = FORWARD;
MODEL price = hp es mpg age / SELECTION = STEPWISE;
RUN;
QUIT;

***** 가변수 만들기 ;
DATA mylib.auto;
SET mylib.auto;
IF region = 'AREA1' THEN d_area1 = 1; ELSE d_area1 = 0;
IF drtype = 'FWD' THEN d_fwd = 1; ELSE d_fwd = 0;
IF drtype = 'RWD' THEN d_rwd = 1; ELSE d_rwd = 0;
RUN;
****** 가변수 적용 회귀분석 ;
PROC REG DATA = mylib.auto;
MODEL price = hp es mpg age d_area1 d_fwd d_rwd/STB VIF;
RUN;

