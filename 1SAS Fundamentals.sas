SAS Program1 : Learning SAS fundementals
/* this is how you put comments in your code */

/**** Referencing : libname statment ****/


/* creating a SAS library to read/write datasets */

libNAme sF "/folders/myfolders/Datasets/SAS Fundamentals";



/**** Importing Datasets : infile statement ****/

/* similar to shortcut for library path you can create file shortcuts too*/

filename example "/folders/myfolders/Datasets/SAS Fundamentals/test.txt";

data first1;
run;

data first1;
infile example dlm=",|" missover firstobs=2 dsd;
retain sn name bdate phn;
/*retain statement should appear right after infile statement to fix 
the variable order*/
length name $15;
/*length statement should come before input statement*/
input sn name $ bdate phn;
label SN="Serial Number" phn="Phone Number" ;
informat bdate mmddyy10.;
format bdate weekdate20.; 
run;


/*proc import for importing standard format files*/
/* csv,excel,excel2000,xlsx */


proc import 
datafile="/folders/myfolders/Datasets/SAS Fundamentals/malad.xls"
dbms=xls 
out=first2 ;
sheet="malad";
getnames=yes;
run;


proc import 
datafile="/folders/myfolders/Datasets/SAS Fundamentals/powai_free.csv"
dbms=csv out=first2 replace;
getnames=yes;
run;

/* there is no option for importing a fixed number of obs as similar
to infile statement */

"guessingrows"

/**** looking at your data :  proc print ****/


proc print data=sf.cars;
run;


proc print data=sf.cars(obs=10);
run;


/**** copying data ****/

data cars_copy;
set sf.cars;
run;


/**** filtering data on number of observations ****/
data cars_filtered;
set sf.cars(firstobs=3 obs=12);
/*firstobs and obs dont work in data statement */
run;


/**** keeping and dropping variables ****/


data cars_keep;
set sf.cars(keep=mpg);
run;


data cars_kd(keep=eng cyl mpg);
set sf.cars(drop=mpg);
run;



/**** Renaming Variables ****/

data cars_rename;
set sf.cars(rename=(mpg=milesPerGallon cyl=cylinder));
run;

/* you can also use rename , drop, keep 
statements , but keep in mind that they will affect all
datasets at once . */


/*** conditional filtering on Observation ***/

data cars_where;
set sf.cars;
where mpg>20;
run;


data cars_if;
set sf.cars;
if mpg>20;
run;

/*

you can alsod use word equivalent for conditional operators
and or 
> : gt
< : lt
>= : ge
<= : le
= : eq


*/



/* newly created dataset here will have only those observations from */
/* cars where value of variable mpg is greater than 20 */
/* what about multiple conditions? */


data cars_wmult;
set sf.cars;
where mpg>20;
where cyl=6;
where eng>200;
run;



/* you'd notice that only the last where condition is processed. to get */
/* around this issue we need to combine these conditions together */
/* there are two ways in which you can combine conditions */

data cars_wmult1;
set sf.cars;
where mpg>20 and cyl=6 and eng>200;
run;


data cars_wmulti2;
set sf.cars;
where mpg>20;
where also cyl=6;
where also eng>200;
run;




data cars_vijay;
set sf.cars;
where mpg>20;
if cyl=6;
run;


/* you can use "or" operator as well to combine conditions if needed */



data cars_comb;
set sf.cars;
where (mpg>20 or cyl=6) and eng>200;
run;



/* you can use "if" statement as well for all such conditions. 
Difference */
/* between "if" and "where" is that, "where" works on incoming data */
/* and "if" works on outgoing data . Try reading log and it'll make 
sense to you*/

data cars_wmult1;
set sf.cars;
if mpg>20 and cyl=6 and eng>200;
run;


/* there is one more difference between "if" and "where" that if you write  */
/* multiple conditions ; all of them are processed sequentiall, this  */
/* behaviour is different from "where" */


data cars_ifmult;
set sf.cars;
if mpg>20;
if  cyl=6;
if  eng>200;
run;




/**** creating new variables with simple algebraic operations ****/
data temp;
set sf.cars;

rat1=mpg/cyl;
cons=100;
add1=(eng/mpg)+cyl+eng*cyl;
sub1=add1-20;

run;



/* you might have noticed that i used new variable which i just created  */
/* while creating another variable. if you want to use 
newly created variable */
/* then it has to appear after it is created */

/**** creating new variables based on conditions ****/


data cars_cond;
set sf.cars;

length new1 $10;

if cyl=4 then new1="low";
else if cyl=6 then new1="medium";
else new1="high";

run;




/*** nested conditions are different than cascading ones for which 
we used sequence of if then else. For nested conditions we need to
use if then do blocks. ***/





data cars_nested;
set sf.cars;
length new1 $15;

if eng>200 then do;
	
	if mpg<20 then new1="block1true";
	else new1="block1false";
end;

else do;
	
	if cyl=6 then new1="block2true";
	else new1="block2false";

end;

run;


/*** sorting data ****/


proc sort data=sf.cars out=cars_sorted;
by  cyl;
run;



proc sort data=sf.cars out=cars_sorted;
by  descending cyl;
run;


proc sort data=sf.cars out=cars_sorted;
by cyl descending mpg ;
run;


/* when you dont supply an out option with proc sort statment
sorted dataset replaces the original one */

proc sort data=cars_sorted;
by wgt;
run;


/*** creating datasets from codes itself. not importing from raw files
its a good tool for making practice datasets ***/


data m1;
input key1 $ a b;
datalines;
a1 20 30
a2 45 65
a3 89 73
a4 78 90
;
run;




/*** merging data ***/

data m2;
input key1 $ c d $;
datalines;
a3 1.2 west
a4 5.6 south
a6 8.9 east
a5 6.7 north
;
run;


data new;
set m1 m2;
run;


data new;
set m1;
set m2;
run;



/* we'd see this by statement at many places. Before you use by statment 
anywhere [except proc sort], your data need to be sorted by those
variables which you'll use in the "by" statement*/


proc sort data=m2;
by key1;
run;

data merged;
merge M1 m2;
by key1;
run;


data merged;
merge M1(in=x) m2(in=y);
by key1;
if x=1 and y=1;
run;



/* left join */
data merged2;
merge m1(in=x) m2(in=y);
by key1;
if x=1 ;
run;

/*right join*/

data merged3;
merge m1(in=x) m2(in=y);
by key1;
if y=1;
run;

/* inner join*/
data merged3;
merge m1(in=x) m2(in=y);
by key1;
if y=1 and x=1;
/* if x+y=2;*/
/*if x-y=0;*/
run;



