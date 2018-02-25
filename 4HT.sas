libname h "/folders/myfolders/Datasets/Hypothesis Testing";

/* We'll be looking at 4 kind of hypothesis tests. Key to understand results of any hypothesis
test result is to know what is null hypothesis and how to conclude by looking at p-value.
In short you need to do this:
1. Know what is the null hypothesis Ho. Complimentary to this would be Alternate
hypotheis Ha.
2. If p-value of the test is smaller than alpha 
[standard value is 0.05, you can take 0.1,0.01 etc]
then conclude against Ho; otherwise in favor of Ho.
*/

data h.white_wine;
infile "/folders/myfolders/Datasets/Hypothesis Testing/winequality-white.csv"
dlm=";" dsd missover firstobs=2;
input fixed_acidity volatile_acidity citric_acid
residual_sugar chlorides free_sulfur_dioxide
total_sulfur_dioxide density pH sulphates alcohol quality;
run;

proc means data=h.white_wine
var alcohol
run

/* single sample ttest. you are checking whther mean of the variable in question is equal to 
the specified value [h0=6.10] or not. Chaging alpha does not change p-value of
the test as that depends on the data only  however it does change the confidence intervals
being displayed*/

/*Ho: mean of the data =specified value.
In the example given below. Null hypothesis is that mean of fixed_acidity=6.10

*/


proc ttest data=h.white_wine h0=6.83;
var fixed_acidity;
run;

/* find out how to do one sided tests */


proc ttest data=h.white_wine h0=6.83 alpha=0.01 sides=u;
var fixed_acidity;
run;


/* 
You get 3 tables in the results on top. first two tables are summary of the data.
3rd table contains DF[degrees of freedom:parameter for test statistic] , 
t-value:value of the test statistic , p-value: this is the value we'd be using
in concluding in favor or against Ho.

as per the results p-value is very very small [<.0001], we'll conclude against Ho
and say that mean is different from 6.10
The accompanying normality plot show histogram of the variable.
On the histogram in red color is the density plot [supposed distribution curve for the data]
and in greyish blue is the normal distribution plot if the variable was following
normal distribution. We can see that there is slight deviation.

In the Q:Q plot, if variable was perfectly following normal distribution then all
the values would have been along the line in the middle. You can see that this alignment
goes bad towards right

*/

/* paired ttest : this test is used in situations where outcomes of two variables are 
related by some underlying process, for example if you are checking a medicine which
claims to reduce your weight, you'll pick say 20 individuals and take their weight before 
taking the medicine and lets say after a one week course of the medicine. Now you
are intersetd in whether average weights are statistically different before and 
afterwards are not.

Null Hypothesis: Means of the variables taken in consideration are NOT different
OR in other words
Mean of "the difference of the means" is equal to ZERO

In the example given below, Ho: Mean of Diffence between means of write and read=0
*/



proc ttest data=h.hsb2 h0=0;
paired write*read;
run;


/*p-value of test is high [0.3868], we'll be concluding in FAVOUR of Ho and say
that means of the variable write and read are NOT different.

Looking at the histograms and distribution plot we can see that difference of variable
read and write is almost following normal distribution, which can be seen at the
end in Q:Q plot as well.

On the "Paired Profile" Plot values of read and write have been plotted.
each pair has been joined by a line. Read line is joining overall means of each
variable and is almost flat [which again confirms mean of difference to be zero]

Agreement plot is another way of looking at the same thing as above.
*/

proc sql;
select distinct quality from h.white_wine;
run;

/* unpaired ttest: we need to find out whether alcohol percentages in wine vary across
quality ratings . Remember that you can do this test if number of classes are two.
for more classes you'll have to use ANOVA. */

/* Here variables values are from the same variable but belonging
to different classes. They are not "paired" 

In this example Ho: Difference between means of alchol in 
class quality=3 and quality=9 is equal to zero
*/

/* data wine_sub; */
/* set h.white_wine; */
/* where quality in (3,9); */
/* run; */
/*  */
/* proc ttest data=h.white_wine h0=0; */
/* var alcohol; */
/* class quality; */
/* run; */
proc ttest data=h.hsb2 h0=0;
var read;
class female;
run;




proc ttest data=wine_sub h0=0;
var alcohol;
class quality;
run;




proc ttest data=h.hsb2 h0=0;
var read;
class female;
run;




/* here we get 4 tables in result instead of 3. We'll talk about table number 3,4 below

There are two ways of checking the Equality of mean hypothesis in the unpaired t-test
depending upon whether the variance of the variable in question is similar or different
in two given classes. 

These two ways are "Pooled" and "Satterthwaite" .

"Pooled" test assumes that variances are equal

"Satterthwaite" assumes variances are unequal.

how do we determine whether variances are equal or unequal?

By using table <4>. Null hypothesis for Equality of variances test is 
Ho: Variances are equal. 

Looking at p-value in table <4> 0.7784: this is very high we conclude that
variances are equal. Now since we have taken a decision on this, it implies 
that in table 3, we'll be using p-value corresponding to "Pooled" test

which is .0052, so we conclude that alcohol averages in these two classes [quality=3
and quality=9] are statistically different

*/


/* in the above test we checked whether avaerage alcohol content is statistically different
for classes defined by quality=3 or quality=9. Next you might be interested in whether
alcohol averages are different across all the classes defined by quality variable [not 
just two] */

/* for that we go to ANOVA */

/* in Case of ANOVA test is based on F distribution, Test statistic is called
F-statistics. Way to conclude in favour/against the Ho remains same */

/* Null hypothesis in this case is that
Ho:means of variable in question is same in all the classes
Ha: mean in Atleast one class is different from the rest

*/

proc ttest data=h.hsb2;
var read;
class race;
run;

proc anova data=h.white_wine;
class quality;
model alcohol=quality;
means quality/ bon alpha=0.05;
run;







/* table here look a bit different because of test being based on
F-distribution. We'll be looking at p-value in the 3rd table again.
we see that p-value [<.0001] is very small. We conclude that Atleast
one class mean is different. 
Now to figure which class mean is differnt we have specified "/bon" option
which is short for bonferroni test

This test also generates box-plots for the variable across all classes
and we can observe mean,median and spread of alcohol percentages in different
classes are quite different

Now back to bonferroni test.
This test generates a large table towards the end which has
all classes paired.
For each class it tells you with which class it's mean is significantly different 
[at alpha=.01 in this case as specified]

in the result if you notice 
against pair 9-4 and 9-5 there are *** in the last columns which
tells that these class means are significantly different at alpha=0.01

You can similarly draw conclusions regarding other classes as well
*/

/* tests for categorical variable relative frequencies */

proc freq data=h.hsb2;
table race /chisq testp=(12 6 10 72);
run;


proc freq data=h.hsb2;
table schtyp*female/chisq;
run;




proc freq data=h.hsb2;
table race*ses/chisq;
run;


proc freq data=h.hsb2;
table race*ses/fisher;
run;



