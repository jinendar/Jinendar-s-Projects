
proc import 
datafile="/folders/myfolders/Datasets/Logistic Regression/Existing Base.csv"
dbms=dlm out=bd replace;
delimiter=",";
getnames=yes;
run;

proc freq data=bd;
table children;
run;

data bd(drop=children);
set bd;
if children="Zero" then children="0";
else children=substr(children,1,1);
child=input(children,8.);
run;

proc freq data=bd;
table age_band;
run;

proc freq data=bd;
table age_band*revenue_grid/nofreq nocol nopercent;
run;


data bd(drop=age_band);
set bd;
ab_1=(age_band in ("36-40"));
ab_2=(age_band in ("41-45","55-60"));
ab_3=(age_band in ("61-65","65-70","51-55"));
run;



data bd(drop=status);
set bd;
st_ds=(status="Divorced/Separated");
st_p=(status="Partner");
st_sn=(status="Single/Never Married");
st_w=(status="Widowed");
run;


proc freq data=bd;
table occupation*revenue_grid/nocol nopercent nofreq;
run;

data bd(drop=occupation);
set bd;
occ_ss=(occupation in ("Secretarial/Admin","Student"));
occ_rh=(occupation in ("Retired","Housewife"));
occ_bp=(occupation in ("Business Manager","Professional"));
run;


proc freq data=bd;
table occupation_partner*revenue_grid/nocol nopercent nofreq;
run;


data bd(drop=occupation_partner);
set bd;
occp_ss=(occupation_partner in ("Secretarial/Admin","Student"));
occp_R=(occupation_partner in ("Retired"));
occp_p=(occupation_partner in ("Professional"));
run;


proc freq data=bd;
table home_status*revenue_grid/nocol nopercent nofreq;
run;

data bd(drop=home_status);
set bd;
hs_own=(home_status="Own Home");
run;




proc freq data=bd;
table family_income*revenue_grid/nocol nopercent nofreq;
run;

data bd(drop=family_income);
set bd;
fi_1=(family_income in ("< 4,000","< 8,000, >= 4,000","Unknown"));
fi_2=(family_income in ("<10,000, >= 8,000","<12,500, >=10,000","<25,000, >=22,500"));
fi_3=(family_income in ("<17,500, >=15,000"));
run;


data bd(drop=self_employed self_employed_partner);
set bd;
se_yes=(self_employed="Yes");
sep_yes=(self_employed_partner="Yes");
drop tvarea post_code post_area ;
if year_last_moved ne 0;
run;

data bd;
set bd;
drop region;
gender_f=(gender="Female");
run;

data bd;
set bd;
drop ref_no gender;
run;

proc surveyselect data=bd samprate=0.8 seed=123 outall out=bd;
run;

data train(drop=selected) test(drop=selected);
set bd;
if selected then output train;
else output test;
run;



proc sql noprint;
select name into:vars separated by " " from dictionary.columns
where libname="WORK" and memname="TRAIN";
quit;

%put &vars.;






proc reg data=train;
model revenue_grid=year_last_moved Average_Credit_Card_Transaction 
Balance_Transfer Term_Deposit Life_Insurance Medical_Insurance 
Average_A_C_Balance 
 Personal_Loan Investment_in_Mutual_Fund Investment_Tax_Saving_Bond 
 Home_Loan Online_Purchase_Amount  
  
  child ab_1 ab_2 ab_3 st_ds  st_sn st_w 
 occ_ss occ_rh occ_bp occp_ss occp_R occp_p hs_own fi_1 fi_2 fi_3 
 se_yes sep_yes gender_f/vif;
 run;
 
/* these variables were sequenetially removed from the model 
for high vif , vif >10:
 Investment_in_Commudity
 Investment_in_Derivative
 Investment_in_Equity
 st_p
 Portfolio_Balance
 */

proc logistic data=train outmodel=bd_model;
model revenue_grid=year_last_moved Average_Credit_Card_Transaction 
Balance_Transfer Term_Deposit Life_Insurance Medical_Insurance 
Average_A_C_Balance 
 Personal_Loan Investment_in_Mutual_Fund Investment_Tax_Saving_Bond 
 Home_Loan Online_Purchase_Amount 
  child ab_1 ab_2 ab_3 st_ds 
 st_sn st_w 
 occ_ss occ_rh occ_bp occp_ss occp_R occp_p hs_own fi_1 fi_2 fi_3 
 se_yes sep_yes gender_f
/selection=stepwise slentry=0.05 slstay=0.05;
run;


proc logistic inmodel=bd_model;
score data=train out=train_score;
run;



data train_score;
set train_score;
revenue_grid=(revenue_grid=1);
run;



proc rank data=train_score groups=10 out=train_score descending;
var p_1;
ranks bin;
run;

proc means data=train_score n mean;
class bin;
var p_1;
run;



proc means data=train_score noprint nway;
class bin;
var revenue_grid;
output out=bd_summary sum=ones n=total;
run;

proc freq data=train_score;
table revenue_grid;
run;
/*7164 ,893 => DO NOT COPY THESE VALUES THEY MIGHT BE DIFFERENT FOR YOU */

data bd_summary;
set bd_summary;
zeroes=total-ones;
zero_p=zeroes/7164;
one_p=ones/893;
run;

data bd_summary1;
set bd_summary;
c_one_p+one_p;
c_zero_p+zero_p;
KS=c_one_p-c_zero_p;
run;

proc means data=train_score min;
var p_1;
class bin;
run;

/* cutoff = 0.0882878 => DO NOT COPY THIS . IT MIGHT BE SLIGHTLY DIFFERENT FOR YOU*/

/* NOW LETS TEST THE PERFORMANCE ON TEST DATA */

proc logistic inmodel=bd_model;
score data=test out=test_scored;
run;

data test_scored;
set test_scored;
revenue_grid=(revenue_grid=1);
rg_predicted=(p_1 > 0.0882878);
run;

proc freq data=test_scored;
table revenue_grid*rg_predicted/nocol nopercent norow;
run;

/* measures of performance */
/* accuracy , sensitivity, specificity , lift */


/* accuracy=(1623+169)/2014 =88.97 % */
/* sn=169/189 =0.8941 */
/* sp=1623/1825 =0.8893 */

/* lift = (169/189)/(371/2014) */







