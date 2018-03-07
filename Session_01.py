
# coding: utf-8

# ## Hello World

# In[1]:


print("Hello world")


# ## DATA TYPES
# ### INT

# In[3]:


a = 10


# In[4]:


print(a)


# In[5]:


print(type(a))


# ### FLOAT

# In[7]:


b = 10.5


# In[8]:


print(b)


# In[9]:


print(type(b))


# ### STRING

# In[10]:


My_String = "Hello"


# In[12]:


print(My_String)


# In[13]:


print(type(My_String))


# ### BOOLEAN

# In[14]:


bool_value = 100 < 50


# In[15]:


print(bool_value)


# In[16]:


print(type(bool_value))


# ### LIST

# In[20]:


my_list1 = [10, 20, 30]


# In[21]:


print(my_list1)


# In[22]:


print(type(my_list1))


# In[24]:


my_list2 = [10, 20.5, "hello", True]


# In[25]:


print(my_list2)


# In[26]:


print(type(my_list2))


# In[140]:


my_list03 = [1, 2, 3, 1, 2, 3]


# In[141]:


print(my_list03)


# In[142]:


print(type(my_list03))


# In[143]:


my_list03[0]


# In[144]:


my_list03[2]



# In[145]:


my_list03[-1]


# In[146]:


my_list03[1:5] #Range


# In[147]:


my_list03[2:5]


# In[148]:


my_list03[0] = 10 #Replace


# In[149]:


print(my_list03)


# In[150]:


my_list03.append(100) #append list with 100


# In[151]:


print(my_list03)


# In[152]:


my_list03.extend(my_list1) #extend list with other list


# In[153]:


my_list03


# In[154]:


my_list03.index(1) #Gives the index number of respective number from the list 


# In[155]:


my_list03.insert(2, 1) #Index number,the number to be inserted


# In[156]:


my_list03


# In[157]:


my_list03.pop(10) #pop-up the element and delete it, if no elment is specified it deletes last number in the list


# In[158]:


my_list03


# In[159]:


my_list03.remove(1)


# In[160]:


my_list03


# In[164]:


my_list03.sort() #Sorth the values in ascending order


# In[165]:


my_list03


# In[167]:


my_list03.count(2) #Give the count of value present in the list


# In[168]:


my_list03.reverse() #arrange in descending order


# In[169]:


my_list03


# In[170]:


my_list03.copy()


# In[174]:


my_list03.clear()


# In[172]:


my_list03

