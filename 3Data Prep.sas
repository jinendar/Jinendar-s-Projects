libname dp "/folders/myfolders/Datasets/Data Prep";



/* data _null_ is used so that there is no data set created when you
write data step code */
/*put is to print any values on log */



data _null_;
x=sqrt(2000000);
y=log(x);
z=sum(23,34,56);
put x;
put y;
put z;
run;



/* lets create a data set and understand how these functions work
 row by row ; not column by column */
 
data func;
input x y z;
datalines;
10 20 30
1 2 3
5.4 6.7 9.33
100 200 0
;
run;

/* now lets apply some numerical functions and see what they do */

data func;
set func;
s1=sum(x);
s2=sum(x,y,z);
run;


/* differnce between simple addition and function sum */
data _null_;
x=10;
y=20;
z=.;
a=x+y+z;
b=sum(x,y,z);
put "a=" a;
put "b=" b;
run;



/* a short list of few functions:
log, exp, sqrt, mean, median, sum, n, nmiss
*/


/* ******* string functions *********/

/* scan : inputstring, n, delimiter*/


data _null_;
address="1502/Panch Mahal/Powai/Mumbai";
city=scan(address,-2,"/");
put "city=" city;
run;


/* substr : inputstring, stratingpos, numberofcharacters*/

data _null_;
IP="992.168.1.1:543";
port=substr(IP,13,3);
put "port=" port;
run;



/*what happend if i do not give "numberofcharacters" */
data _null_;
IP="192.168.1.1:543,AutomatedMails";
port=substr(IP,13);
port1=substr(IP,13,3);
put port;
put port1;
run;


/*upcase,lowcase : this function change the case of the string to
upper and lower respectively. */

/* find */

data _null_;
x="akjs@askj@asdkf@a";
z=find(x,"@a");
m=find(x,"@a",-length(x));
k=find(x,"@a",-17);
a=find(x,"@a",-7);
b=find(x,"@a",7);
put "z=" z;
put "m=" m;
put "k=" k;
put "a=" a;
put "b=" b;
run;




data _null_;
x="aIAjdkidA";
y=find(x,"i");
z=find(x,"a","i",-4);
put "y=" y;
put "z=" z;
run;



/* tranwrd */

data _null_;
address="1203-Some Tower-powai/Mumbai";
proper_add=tranwrd(address,"-","/");
put "proper_ad=" proper_add;
run;

data _null_;
x="lalit"||" "||"lalit";
put "x=" x;
run;

/* input function */

data temp;
x="12/01/2013";
run;

data temp;
set temp;
format y mmddyy10.;
y=input(x,ddmmyy10.);
run;


data temp;
input some $;
datalines;
10
20
30
a
b
12
13
14
;
run;

data temp;
set temp;
some_num=input(some,8.);
run;


data temp(keep=expense expense_lag);
set dp.ccu;
expense_lag=lag6(expense);
run;

/* round function */

data _null_;
x=123.45567;
y=round(x);
z=round(x,0.001);
put "z=" z;
put "y=" y;
run;

data _null_;
x=123.45567;
y=round(x,0.1);
z=round(x,100);
m=round(x,10);
put "y=" y;
put "z=" z;
put "m=" m;
run;

/* we'll resume @ 8:35 IST */

/* proc rank : is used to make bins in your data */

proc means data= sashelp.cars min max;
var invoice;
run;

/* groups=10 tells proc rank there are going to 10 bins/groups 
in the data. "ranks basket" this names the variable containing
group/bin number as "basket". */

proc rank data=sashelp.cars out=car_rank group=10;
var invoice;
ranks basket;
run;

proc means data=car_rank range n mean;
var invoice;
class basket;
run;

data for_rank;
input k;
datalines;
12
3
4
5
6
1
2100
99
7
8
20
;
run;

proc rank data=for_rank out=for_rank groups=3;
var k;
ranks bins;
run;


/********proc transpose *********/
/* long to wide, wide to long */
/* by statement: makes rows based how many unique values the specifieds
variable in the by statment has */
/*id statement: makes columns based how many unique values the specified 
variable in the id statement has */
/*var statement fills the values of variable specified in the var
statement in the resulting cells of transposed data frame */


data long1 ; 
  input famid year faminc ; 
datalines ; 
1 96 40000 
1 97 40500 
1 98 41000 
2 96 45000 
2 97 45400 
2 98 45800 
3 96 75000  
3 98 77000 
3 98 40000
; 
run;


proc transpose data=long1 out=wide1 prefix=yr;
    by famid ;
    id year;
    var faminc;
run;



data long2; 
  input famid year faminc spend ; 
cards; 
1 96 40000 38000 
1 97 40500 39000 
1 98 41000 40000 
2 96 45000 42000 
2 97 45400 43000 
2 98 45800 44000 
3 96 75000 70000 
3 97 76000 71000 
3 98 77000 72000 
; 
run ;


proc transpose data=long2 out=together prefix=year;
   by famid;
   id year;
   var faminc spend;
run;


/******* proc SQL : implementation SQL within SAS 
whatever you can do in SQL, you can do in data step ******/

/* simple selection */

proc sql;
select * from sashelp.cars;
quit;


/* this selects and puts in the output everything from the table */

proc sql ;
create table temp2 as select * from sashelp.cars;
quit;



/* this puts all the data which you selected in the table/dataset temp*/




proc sql;
select make,model from sashelp.cars;
quit;



/* this controls number of variables/columns which you are selecting
from the dataset */

/* now what if i want to restrict number of observations */


proc sql inobs=10;

select weight from sashelp.bweight;
select make,model from sashelp.cars;

quit;



proc sql;

select weight from sashelp.bweight(firstobs=3 obs=10);
select make from sashelp.cars(firstobs=4 obs=20);

quit;









/* there is also an option called outobs. Outobs specifies number of 
observation which go out */


proc sql outobs=10;
select name from sashelp.baseball;
quit;


/* how to apply conditional filters on the data */

proc sql;
select origin,invoice,drivetrain from sashelp.cars 
 where origin="Asia";
quit;










proc sql;
create table temp as 

select invoice,origin,drivetrain 
from sashelp.cars
where origin="USA" and type="Sedan" and mpg_city>15;

quit;






/* you dont need to neccessarily select the variable on which
you are apply conditional statement */



/* order by is essentially same as proc sort */


proc sql;
	select origin,invoice from sashelp.cars 
	 order by origin desc,invoice;
quit;






/* default order of sorting is ascending. If you want to sort  */
/* things in descending order then you'll have to use the kyeword */
/* desc as given below */

proc sql;
select invoice,origin from sashelp.cars 
order by origin, invoice desc;
quit;

/* you can order by multiple variables as well */

proc sql;
select origin,msrp from sashelp.cars 
order by  origin,msrp desc ;
quit;


/*now next is to group variables or get aggregated/summary statistics 
such as mean std etc which are defined for a group of values
rather than individual observation */


proc sql ;
 
select  origin,drivetrain,mean(msrp) as msrp_avg 
from sashelp.cars 
group by origin,drivetrain;


quit;









proc sql ;
select make, std(msrp) as price_var from sashelp.cars 
group by make order by price_var;
quit;






/* now if we wanted to put condition here on the new var which is 
created [price_var]; lets see if simple where condition works */


proc sql ;
select make, std(msrp) as price_var from sashelp.cars 
where price_var>10000 group by make order by price_var;
quit;





/* above mentioned code throws an error:
ERROR: The following columns were not found in the 
contributing tables: price_var.*/

/* to apply conditions on the variables which are created in
sql queries we need to use "having" */

proc sql ;
select make, std(msrp) as price_var from sashelp.cars 
 group by make having(price_var>10000) order by price_var ;
quit;






/*squence in which you should write :
where > group by > having > order by
*/
