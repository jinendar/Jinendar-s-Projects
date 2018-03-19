
# coding: utf-8

# Topics:
# 
# Hello world
# Data types
# 
# Numbers
# variables
# List
# Tuple
# Set
# Dictionary
# String
# Printing
# Comparison Operators
# 
# if,elif, else Statements
# for Loops
# while Loops
# list comprehension

# ## Hello World !

# In[2]:


print('Hello world !')


# ## Data Types

# ### Numbers

# In[3]:


1 + 1 #Addition


# In[4]:


1 * 2 #Multiplication


# In[5]:


1 / 2 #Division


# In[6]:


2 ** 4 #Exponential


# In[7]:


4 % 3 #Remainder


# In[8]:


(2 + 3) * (5 + 5)


# ### Variables

# In[9]:


a = 10 #Int


# In[10]:


type(a)


# In[11]:


print(a)


# In[12]:


b = 20.5 #Float


# In[13]:


type(b)


# In[14]:


print(b)


# In[15]:


c = True #Boolean


# In[16]:


type(c)


# In[17]:


print(c)


# In[18]:


d = "My string" #String


# In[20]:


type(d)


# In[21]:


print(d)


# In[22]:


print(type(d))


# ### List

# In[1]:


my_list = [1,2,3,1,2,5,1,2]


# In[2]:


print(my_list)


# In[3]:


type(my_list)


# In[4]:


my_list.append(6)


# In[5]:


my_list


# In[6]:


my_another_list = [7, 8, 9]


# In[7]:


my_list.extend(my_another_list)


# In[8]:


my_list


# In[12]:


my_list.count(5)


# In[13]:


my_list.reverse()


# In[14]:


my_list


# In[15]:


len(my_list)


# In[16]:


min(my_list)


# In[17]:


max(my_list)


# In[18]:


sum(my_list)


# In[19]:


my_list[0]


# In[20]:


my_list[4]


# In[21]:


my_list[-1]


# In[22]:


my_list[2:4]


# In[23]:


my_list[:5]


# In[24]:


my_list[6:]


# In[25]:


my_list[0] = 10


# In[26]:


my_list


# In[27]:


my_str_list = ['a','b','c']


# In[28]:


my_str_list


# In[29]:


my_str_list.append('d')


# In[30]:


my_str_list


# In[31]:


my_nest_list = [1,2,3,[4,5,['target','hello']]]


# In[32]:


print(my_nest_list)


# In[33]:


my_nest_list[3]


# In[34]:


my_nest_list[3][0]


# In[35]:


my_nest_list[3][1]


# In[36]:


my_nest_list[3][2]


# In[37]:


my_nest_list[3][2][0][0]


# ### List Assignment   

# In[38]:


my_list03 = [1, 2, 3, 1, 2, 3]


# In[39]:


print(my_list03)


# In[40]:


print(type(my_list03))


# In[41]:


my_list03[0]


# In[42]:


my_list03[2]


# In[43]:


my_list03[-1]


# In[44]:


my_list03[1:5] #Range


# In[45]:


my_list03[2:5]


# In[46]:


my_list03[0] = 10 #Replace


# In[47]:


print(my_list03)


# In[48]:


my_list03.append(100) #append list with 100


# In[49]:


print(my_list03)


# In[51]:


my_list03.extend(my_list) #extend list with other list


# In[52]:


my_list03


# In[53]:


my_list03.index(1) #Gives the index number of respective number from the list 


# In[54]:


my_list03.insert(2, 1) #Index number,the number to be inserted


# In[55]:


my_list03


# In[56]:


my_list03.pop(10) #pop-up the element and delete it, if no elment is specified it deletes last number in the list


# In[57]:


my_list03


# In[58]:


my_list03.remove(1)


# In[59]:


my_list03


# In[60]:


my_list03.sort() #Sorth the values in ascending order


# In[61]:


my_list03


# In[62]:


my_list03.count(2) #Give the count of value present in the list


# In[63]:


my_list03.reverse() #arrange in descending order


# In[64]:


my_list03


# In[65]:


my_list03.copy()


# In[66]:


my_list03.clear()


# In[67]:


my_list03


# ### Tuple

# In[71]:


my_tuple1 = (1, 2, 3, 10, 2, 10, 100)


# In[72]:


type(my_tuple1)


# In[74]:


print(my_tuple1) #It allows duplicate


# In[75]:


my_tuple1[2] #Allows indexing


# In[76]:


my_tuple1[2] = 4 #It is immutable


# In[77]:


len(my_tuple1)


# In[78]:


my_tuple1[1]


# In[79]:


my_tuple1[-1]


# In[80]:


my_tuple1[1:5]


# In[81]:


my_tuple1[5:]


# In[82]:


my_tuple1[:4]


# In[83]:


my_tuple1.index(3)


# In[86]:


my_tuple1.count(2)


# In[87]:


my_list1 = list(my_tuple1)


# In[88]:


my_list1


# In[89]:


type(my_list1)


# ### Tuple Assignment

# In[90]:


my_list2 = [1, 2, 4, 5, 7, 2, 1, 3]


# In[91]:


my_tuple2 = tuple(my_list2) #Converting list into tuple


# In[92]:


my_tuple2


# ### Set

# In[72]:


my_set = {1, 2, 3, 1 , 3}


# In[73]:


print(my_set) #Doesn't allow duplicate


# In[74]:


my_set[1] #Doesn't allow indexing


# In[75]:


my_set[2] = 4 #It is immutable


# ### Set Assignment
# #### Example for all the methods of set

# In[76]:


my_set.add(4) #Add number as the last element in the set


# In[77]:


my_set


# In[78]:


my_set.copy() #Copies the elements in the set


# In[79]:


my_set.difference()


# In[80]:


my_set.difference_update()


# In[81]:


my_set


# In[82]:


my_set.discard(4) #Removes the given element


# In[83]:


my_set


# In[84]:


my_set.intersection()


# In[85]:


my_set.intersection_update()


# In[86]:


my_set


# In[87]:


my_set.isdisjoint("hi")


# In[88]:


my_set.pop() #Pop from zero index


# In[91]:


my_set.remove(3)


# In[92]:


my_set


# In[93]:


my_set.union()


# In[94]:


my_set.clear()


# In[95]:


my_set


# #### list vs tuple with example
# #### list vs tuple with example
# #### similarity of list and tuple
# #### list vs set with example
# #### tuple vs set

# In[96]:


my_list4 = [1, 2, 3, 4, 1, 2, 3]


# In[97]:


print(my_list4) #It allows duplicate


# In[98]:


my_list4[2] #Indexing is allowed


# In[100]:


my_list4[4] = 4


# In[101]:


print(my_list4) #It is mutable


# In[102]:


my_tuple2 = (1, 2, 3, 10, 2, 10, 100)


# In[103]:


print(my_tuple2) #It allows duplicate


# In[105]:


my_tuple2[2] #Allows indexing


# In[106]:


my_tuple1[2] = 4 #It is immutable


# #### convert set to list and tuple

# In[107]:


my_set1 = {1, 4, 5, 7, 10, 10, 6, 8}


# In[108]:


my_list_set = list(my_set1) #converting set to list


# In[109]:


my_list_set


# In[110]:


my_tuple_set = tuple(my_set1) #converting set to tuple


# In[111]:


my_tuple_set


# #### Convert list and tuple to set

# In[112]:


my_list5 = [1, 4, 5, 7, 10, 10, 6, 8]


# In[113]:


my_set_list = set(my_list5) #converting list to set


# In[114]:


my_set_list 


# In[115]:


my_tuple3 = (1, 4, 5, 7, 10, 10, 6, 8)


# In[116]:


my_tuple_list = set(my_tuple3) #converting tuple to set


# In[117]:


my_tuple_list


# ### Dictionary

# In[119]:


my_dict = {"name":"james", "age" :29, "Prog_languages":['python','scala','java']}


# In[120]:


type(my_dict)


# In[122]:


my_dict["name"]


# In[123]:


my_dict["Prog_languages"]


# In[125]:


my_dict['Prog_languages'][2]


# In[127]:


my_dict['Prog_languages'][1][1]


# In[128]:


my_dict.update({"country" : "USA"})


# In[129]:


my_dict


# ### Dictionary Assignment
# #### Create dictionary from list,tuple and set

# In[131]:


my_dict1 = {"name":"james", "age" :29, "num":{1, 2, 1, 4, 5, 6, 7, 2}}


# In[136]:


my_dict1["num"] #Creating dict from set


# In[133]:


my_dict2 = {"name":"james", "age" :29, "num":(1, 2, 1, 4, 5, 6, 7, 2)}


# In[135]:


my_dict2["num"] #Creating dict from tuple


# In[138]:


my_dict3 = {"name":"james", "age" :29, "num":[1, 2, 1, 4, 5, 6, 7, 2]}


# In[139]:


my_dict3["num"] #Creating dict from list


# ### Comparison Operators

# In[1]:


1 > 2


# In[2]:


1 < 2


# In[3]:


3 >= 3


# In[4]:


1 <= 4


# In[5]:


7 == 7


# In[6]:


'hi' == 'bye'


# ### Logical Operators

# In[7]:


(1 > 2) and (2 < 3)


# In[8]:


(1 > 2) or (2 < 3)


# In[9]:


(1 == 2) or (2 == 3) or (4 == 4)


# ### If, elif, else statements

# In[10]:


if 1 < 2:
    print('Yep!')


# In[11]:


if 1 > 2:
    print('Yep!')


# In[12]:


n = 10


# In[13]:


if n > 7:
    print('Yep!')


# In[14]:


a = 1
b = 2


# In[15]:


if a < b:
    print('true')
else:
    print('false')


# In[16]:


if a > b:
    print('true')
else:
    print('false')


# In[17]:


if 1 == 2:
    print('first')
elif 3 == 3:
    print('middle')
else:
    print('Last')


# In[18]:


num = 0


# In[19]:


if num > 0:
    print("Positive number")
elif num == 0:
    print("Zero")
else:
    print("Negative number")


# In[20]:


num = float(input("Enter a number: "))


# In[21]:


if num > 0:
    print("Positive number")
elif num == 0:
    print("Zero")
else:
    print("Negative number")


# #### If elif else statements Assignment

# In[22]:


if 7 < 5:
    print("True")
else:
    print("False")


# In[23]:


n = "hello"


# In[24]:


if n == "bye":
    print("correct")
else:
    print("Incorrect")


# In[25]:


n = [1, 2, 3, 5]


# In[27]:


if n == 2:
    print("Yes")
else:
    print("No")
        


# In[28]:


k = range(100) #Range not supported in such conditions


# In[41]:


if k > 100:
    print("Greater than 100")
elif k == 90:
    print("In range of 100")
else:
    print("Lesser than 100")


# In[36]:


j = 100


# In[38]:


if j > 100:
    print("Greater than 100")
elif j == 100:
    print("It is 100")
else:
    print("Lesser than 100")


# In[39]:


num = float(input("Enter a number: "))


# In[43]:


if num >= 0:
    print("Positive number")
elif num < 0:
    print("Negative number")
else:
    print("Others")


# ### For statements

# In[44]:


seq = [1,2,3,4,5]


# In[45]:


for item in seq:
    print(item)


# In[46]:


for item in seq:
    print('Yep')


# In[47]:


for jelly in seq:
    print(jelly+jelly)


# In[48]:


l = range(20)


# In[49]:


l


# In[50]:


for i in l:
    print(i)


# In[51]:


for i in l:
    print(i+i)


# In[52]:


for i in l:
    print(i*i)


# In[53]:


even_list = []


# In[54]:


odd_list = []


# In[55]:


for i in l:
    if(i%2==0):
        even_list.append(i)     
    else:
        odd_list.append(i)     


# In[56]:


even_list


# In[57]:


odd_list


# In[58]:


sum = 0


# In[59]:


for val in l:
    sum = sum+val


# In[60]:


sum


# In[61]:


programming_languages = ['Python', 'Scala', 'Java']


# In[62]:


for p_language in range(len(programming_languages)):
    print("I like {}".format(programming_languages[p_language]))


# ### For statements Assignment

# In[3]:


for i in range(7):
   print(i)


# In[4]:


for i in range(20,25):
   print(i)


# In[5]:


for i in range(0,15,3):
   print(i)


# In[6]:


for i in range(100,0,-10):
   print(i)


# In[7]:


num_list = [1, 2, 3]
alpha_list = ['a', 'b', 'c']

for number in num_list:
    print(number)
    for letter in alpha_list:
        print(letter)


# In[8]:


list_of_lists = [['hammerhead', 'great white', 'dogfish'],[0, 1, 2],[9.9, 8.8, 7.7]]

for list in list_of_lists:
    print(list)


# In[9]:


list_of_lists = [['hammerhead', 'great white', 'dogfish'],[0, 1, 2],[9.9, 8.8, 7.7]]

for list in list_of_lists:
    for item in list:
        print(item)


# ### While Statements

# In[10]:


i = 1
while i < 5:
    print('i is: {}'.format(i))
    i = i+1


# In[13]:


count = 0
while (count < 9):
   print ('The count is:', count)
   count = count + 1

print ("Good bye!")


# ### List Comprehension

# In[14]:


x = [1,2,3,4]


# In[15]:


out = []
for item in x:
    out.append(item**2)
print(out)


# In[16]:


[item**2 for item in x]


# In[18]:


y = range(10)


# In[23]:


[i*i for i in y]


# In[24]:


[i+i for i in y]


# ### List Comprehension Assignment

# In[25]:


l = [22, 13, 45, 50, 98, 69, 43, 44, 1]


# In[26]:


[x+1 if x >= 45 else x+5 for x in l]


# In[27]:


number_list = [x ** 2 for x in range(10) if x % 2 == 0]


# In[28]:


print(number_list)


# In[29]:


num_list = [x for x in range(100) if x % 3 == 0 if x % 5 == 0]


# In[30]:


print(num_list)


# In[31]:


my_list_comp = [x * y for x in [20, 40, 60] for y in [2, 4, 6]]


# In[32]:


print(my_list_comp)

