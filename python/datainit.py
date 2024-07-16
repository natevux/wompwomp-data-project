import requests
import pandas as pd
import io
import time
import datetime
import logging

res = requests.get("https://randomuser.me/api/?format=csv&nat=us,gb,fr,ca&exc=cell,picture").content
df = pd.read_csv(io.StringIO(res.decode('utf-8')))
df['created_at']=datetime.datetime.now()
df['updated_at']=datetime.datetime.now()

df.info()
df.to_csv('raw_users.csv',index=False)