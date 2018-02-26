libname lr "/folders/myfolders/Datasets/Linear Regression/";

/* preparing data */
/* make a copy of the original data so that you dont end up
permanently changing original data and go back to it whenever 
required */

data ld;
set lr.loandata;
run;


data ld(drop=interest_rate);
set ld;
IR=input(tranwrd(interest_rate,"%",""),8.);
if IR ne .;
run;



proc freq data=ld;
table employment_length;
run;


proc means data=ld mean maxdec=1 ;
class employment_length;
var ir;
run;

/*groups for interest rate
 12.5 : 1 year 
 12.8 : 3 years
 12.9 : 2 years,< 1 year,n/a
 13.0 : 8 years
 13.1 : 7 years,4 years
 13.2 : 9 years
 13.3 : 6 years,10+ years
 13.4 : 5 years
 */
data ld(drop=employment_length);
set ld;
el1=(employment_length="1 year");
el2=(employment_length="3 years");
el3=(employment_length in ("2 years","< 1 year","n/a"));
el4=(employment_length="8 years");
el5=(employment_length in ("7 years","4 years"));
el6=(employment_length="9 years");
el7=(employment_length in ("6 years","10+ years"));
el8=(employment_length="5 years");
run;
/* either convert epm length to numbers or group
them and make lesser number of dummy vars */





proc freq data=ld;
table loan_length;
run;

data ld(drop=loan_length);
set ld;
/* where loan_length ne "NA"; */
ll_36=(loan_length="36 months");
run;


proc means data=ld mean maxdec=0;
var IR;
class loan_purpose;
run;


data ld(drop=loan_purpose);
set ld;
lp_11=(loan_purpose in ("car","educational", "major_purchase"));
lp_12=(loan_purpose in ("vacation","wedding", "medical","home_improvement"));
lp_13=(loan_purpose in ("credit_card","house", "other","small_business"));
lp_14=(loan_purpose in ("debt_consolidation","moving"));
run;


data ld(drop=amount_funded_by_investors debt_to_income_ratio);
set ld;
DIR=input(tranwrd(debt_to_income_ratio,"%",""),8.);
run;


data ld(drop=home_ownership);
set ld;
hw_mort=(home_ownership="MORTGAGE");
hw_rent=(home_ownership="RENT");
/* where home_ownership not in ("NA", "NONE", "OTHER"); */
run;


data ld(drop=fico_range);
set ld;
fico=0.5*(input(scan(fico_range,1,"-"),8.)+
input(scan(fico_range,2,"-"),8.));
run;


data ld;
set ld;
drop state;
run;

data ld;
set ld;
drop id;
run;




proc surveyselect data=ld out=ld samprate=0.75 outall seed=123;
run;



data train(drop=selected) test(drop=selected);
set ld;
if selected=1 then output train;
else output test;
run;




proc sql ;
select name into :vars separated by " " from dictionary.columns 
where libname="WORK" and memname="TRAIN";
quit;

%put &vars.;



proc reg data=train;
model ir = Amount_Requested Monthly_Income Open_CREDIT_Lines 
Revolving_CREDIT_Balance Inquiries_in_the_Last_6_Months  el1 el2 el3 el4 el5 
 el6 el7 el8 ll_36 lp_11 lp_12 lp_13 lp_14 DIR hw_mort hw_rent fico/vif;
run;




/* variable lp_14 has very high vif we'll drop that first */
proc reg data=train;
model ir = Amount_Requested Monthly_Income Open_CREDIT_Lines 
Revolving_CREDIT_Balance Inquiries_in_the_Last_6_Months  el1 el2 el3 el4 el5 
 el6 el7 el8 ll_36 lp_11 lp_12 lp_13  DIR hw_mort hw_rent fico/vif;
run;


/*next to go is variable el7  */
proc reg data=train;
model ir = Amount_Requested Monthly_Income Open_CREDIT_Lines 
Revolving_CREDIT_Balance Inquiries_in_the_Last_6_Months  el1 el2 el3 el4 el5 
 el6  el8 ll_36 lp_11 lp_12 lp_13  DIR hw_mort hw_rent fico/vif;
run;



proc reg data=train ;
model ir=Amount_Requested Monthly_Income Open_CREDIT_Lines 
Revolving_CREDIT_Balance Inquiries_in_the_Last_6_Months  el1 el2 el3 el4 el5 
 el6  el8 ll_36 lp_11 lp_12 lp_13  DIR hw_mort hw_rent fico
/selection=stepwise slentry=0.05 slstay=0.05;
run;

data train;
set train;
fico2=fico*fico;
run;

data test;
set test;
fico2=fico*fico;
run;


/*lets include the variable fico2 also in our model  */

proc reg data=train outest=par;
model ir=Amount_Requested Monthly_Income Open_CREDIT_Lines 
Revolving_CREDIT_Balance Inquiries_in_the_Last_6_Months  el1 el2 el3 el4 el5 
 el6  el8 ll_36 lp_11 lp_12 lp_13  DIR hw_mort hw_rent fico fico2
/selection=stepwise slentry=0.05 slstay=0.05;
run;

proc transpose data=par out=tpar;
run;

proc sql noprint;
select _name_  into :model_vars separated by " " from tpar
where col1 ne . and _name_ not in ("Intercept","_RMSE_");
quit;

%put &model_vars;


proc score data=test score=par out=test type=parms;
var &model_vars.;
run;



proc sql;
select sqrt(mean(model1**2)) as rmse from test;
quit;



