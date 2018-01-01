
# coding: utf-8

# In[18]:


from collections import defaultdict
import numpy as np


# In[54]:


with open('data/rewards.txt') as f:
    temp=f.read().strip().split()
    rewards = np.zeros((81,1),dtype=np.float)
    for i in enumerate(temp):
        rewards[int(i[0])]=int(i[1])


# In[33]:


with open('data/prob_a1.txt') as f:
    temp=f.readlines()
    proba1 = np.zeros((81,81),dtype=np.float)
    for i in temp:
        t=i.strip().split()
        proba1[int(t[0])-1,int(t[1])-1]=float(t[2])


# In[34]:


with open('data/prob_a2.txt') as f:
    temp=f.readlines()
    proba2 = np.zeros((81,81),dtype=np.float)
    for i in temp:
        t=i.strip().split()
        proba2[int(t[0])-1,int(t[1])-1]=float(t[2])


# In[35]:


with open('data/prob_a3.txt') as f:
    temp=f.readlines()
    proba3 = np.zeros((81,81),dtype=np.float)
    for i in temp:
        t=i.strip().split()
        proba3[int(t[0])-1,int(t[1])-1]=float(t[2])


# In[36]:


with open('data/prob_a4.txt') as f:
    temp=f.readlines()
    proba4 = np.zeros((81,81),dtype=np.float)
    for i in temp:
        t=i.strip().split()
        proba4[int(t[0])-1,int(t[1])-1]=float(t[2])


# In[149]:


policy=np.zeros((81,1),dtype=np.int)
gamma=0.9925
vp=np.zeros((81,1),dtype=np.float)
vpbefore=np.ones((81,1),dtype=np.float)
ind=1
while(max(abs(vp-vpbefore))>0.0001):
    print ind
    ind+=1
    
    ppi=np.zeros((81,81),dtype=np.float)
    for s in range(81):
        for sd in range(81):
            if policy[s]==0:
                ppi[s,sd]=proba1[s,sd]
            if policy[s]==1:
                ppi[s,sd]=proba2[s,sd]
            if policy[s]==2:
                ppi[s,sd]=proba3[s,sd]
            if policy[s]==3:
                ppi[s,sd]=proba4[s,sd]

    vpbefore=vp.copy()
    vp=np.linalg.inv(np.identity(81)-ppi*gamma).dot(rewards)

    for s in range(81):
        temp=[]    

        sump=0
        for sd in range(81):
            sump+=proba1[s,sd]*vp[sd,0]
        temp.append(sump)

        sump=0
        for sd in range(81):
            sump+=proba2[s,sd]*vp[sd,0]
        temp.append(sump)

        sump=0
        for sd in range(81):
            sump+=proba3[s,sd]*vp[sd,0]
        temp.append(sump)

        sump=0
        for sd in range(81):
            sump+=proba4[s,sd]*vp[sd,0]
        temp.append(sump)

        policy[s,0]=temp.index(max(temp))


# In[137]:


vt=vp.reshape((9,9)).transpose()
for i in range(9):
    for j in range(9):
        print '{:7.2f}'.format(vt[i,j]),
    print


# In[118]:


for i in vp.reshape((9,9)).transpose().tolist():
    for j in i:
        print '{0:.3f}'.format(j),
    print '\n'


# In[104]:


for i in range(vp.shape[0]):
    print i+1,'\t',vp[i,0],'\t\t',policy[i,0]


# In[101]:


for i in policy.reshape((9,9)).transpose().tolist():
    print map(int,i)


# In[151]:


policy=np.zeros((81,1),dtype=np.int)
gamma=0.9925
vp=np.zeros((81,1),dtype=np.float)
vpbefore=np.ones((81,1),dtype=np.float)
ind=1

while(max(abs(vp-vpbefore))>0.00001):
    print ind
    ind+=1
    
    vpbefore=vp.copy()
    for s in range(81):
            
        temp=[]    

        sump=0
        for sd in range(81):
            sump+=proba1[s,sd]*vp[sd,0]
        temp.append(sump)

        sump=0
        for sd in range(81):
            sump+=proba2[s,sd]*vp[sd,0]
        temp.append(sump)

        sump=0
        for sd in range(81):
            sump+=proba3[s,sd]*vp[sd,0]
        temp.append(sump)

        sump=0
        for sd in range(81):
            sump+=proba4[s,sd]*vp[sd,0]
        temp.append(sump)

        vp[s,0]=rewards[s,0]+gamma*max(temp)
    


# In[148]:


vt=vp.reshape((9,9)).transpose()
for i in range(9):
    for j in range(9):
        print '{:7.4f}'.format(vt[i,j]),
    print


# In[150]:


vt=vp.reshape((9,9)).transpose()
for i in range(9):
    for j in range(9):
        print '{:7.4f}'.format(vt[i,j]),
    print

