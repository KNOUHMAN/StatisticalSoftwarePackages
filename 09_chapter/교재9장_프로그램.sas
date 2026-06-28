/* 로지스틱 회귀분석*/
* 예제 9.1 혈관수축 발생 데이터;
data vaso;
length Response $12;
input Volume Rate Response @@;
LogVolume = log(Volume);
LogRate = log(Rate);
datalines;
3.70 0.825 yes 3.50 1.09 yes
1.25 2.50 yes 0.75 1.50 yes
0.80 3.20 yes 0.70 3.50 yes
0.60 0.75 no 1.10 1.70 no
0.90 0.75 no 0.90 0.45 no
0.80 0.57 no 0.55 2.75 no
0.60 3.00 no 1.40 2.33 yes
0.75 3.75 yes 2.30 1.64 yes
3.20 1.60 yes 0.85 1.415 yes
1.70 1.06 no 1.80 1.80 yes
0.40 2.00 no 0.95 1.36 no
1.35 1.35 no 1.50 1.36 no
1.60 1.78 yes 0.60 1.50 no
1.80 1.50 yes 0.95 1.90 no
1.90 0.95 yes 1.60 0.40 no
2.70 0.75 yes 2.35 0.03 no
1.10 1.83 no 1.10 2.20 yes
1.20 2.00 yes 0.80 3.33 yes
0.95 1.90 no 0.75 1.90 no
1.30 1.625 yes
;
run;
** 로지스틱 회귀분석 ;
proc logistic data = vaso plots(only) = roc;* ROC 곡선만 그래프로 출력;
model Response(event = 'yes') = Volume Rate / lackfit;
run;
