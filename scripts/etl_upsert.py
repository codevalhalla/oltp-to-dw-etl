#!/usr/bin/env python
# coding: utf-8

# In[2]:


import pandas as pd 
from sqlalchemy import create_engine


# In[3]:


#initializing oracle client with a path to instant client
connection_string_oltp = f"oracle+oracledb://oltp:oracle@192.168.56.101:1521/?service_name=orcl"
connection_string_dw    =f"oracle+oracledb://dw_database:oracle@192.168.56.101:1521/?service_name=orcl"


# In[4]:


oltp_engine = create_engine(connection_string_oltp)
dw_engine=create_engine(connection_string_dw)


# In[5]:


#store_dim_table
source_data = pd.read_sql('''
                        SELECT store_id,
                        store_name,
                        phone,
                        store_manager,
                        city_name,
                        state_name,
                        country_name
                    FROM store,city,state,country
                    WHERE store.city_id=city.city_id
                    AND city.state_id=state.state_id
                    AND state.country_id=country.country_id
                    ''',con=oltp_engine)


# In[6]:


source_data.set_index('store_id',inplace=True)


# In[7]:


# Read dw_warehouse table
dw_data = pd.read_sql('select * from store_dimension',con=dw_engine)
dw_data.set_index('store_id',inplace=True)


# In[8]:


target_data=dw_data.copy()       #to know the rows thats changed 


# In[9]:


target_data[target_data.index.isin(source_data.index)]


# In[10]:


# lets update data which index already available in dw_data
target_data.update(source_data)


# In[11]:


# new rows to be updated in the dw_data
incoming_update_from_oltp = target_data[(target_data!=dw_data).any(axis=1)]


# In[12]:


# rows in dw_warehouse that will be affected by the source 
previous_data_of_dw_store_id = dw_data[(dw_data!=target_data).any(axis=1)]
previous_data_of_dw_store_id 


# In[13]:


log_file_updated=pd.merge(left=incoming_update_from_oltp,right=previous_data_of_dw_store_id ,left_index=True,right_index=True,suffixes=("_oltp_for_update","_previous_value"))


# In[14]:


log_file_updated['Timestamp']=pd.Timestamp.now()
log_file_updated.reset_index(inplace=True)
log_file_updated['Timestamp']=log_file_updated['Timestamp'].astype(str)
log_file_updated


# In[15]:


log_file_updated


# In[16]:


log_file_updated.to_csv('../logs/logfile_updated.csv',index=False,mode='a',header=False)
log_file_updated.to_sql('log_updated',con=dw_engine,if_exists='append',index=False)


# In[17]:


#check for any new rows to be inserted in dw_data

# check source_data index not in dw_data index using boolean mask and get the source rows to be inserted 

rows_to_insert=source_data[~(source_data.index.isin(dw_data.index))]


# In[18]:


log_inserted=rows_to_insert.copy()
log_inserted.reset_index(inplace=True)
log_inserted['Timestamp']=pd.Timestamp.now()
log_inserted['Timestamp']=log_inserted['Timestamp'].astype(str)

log_inserted.to_sql('log_inserted',con=dw_engine,if_exists='append',index=False)


# In[19]:


log_inserted.to_csv("../logs/logfile_inserted.txt",index=False,mode='a',header=False)


# In[20]:


dw_data=pd.concat([target_data,rows_to_insert])


# In[21]:


dw_data.reset_index(inplace=True)
dw_data.to_sql('store_dimension',con=dw_engine,if_exists='replace',index=False)


# In[ ]:




