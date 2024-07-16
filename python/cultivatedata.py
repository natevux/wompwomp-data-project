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
curr_time = time.time()

while True:
    if time.time() > curr_time + 5: #10 seconds
        break
    try:
        res = requests.get("https://randomuser.me/api/?format=csv&nat=us,gb,fr,ca&exc=cell,picture").content
        data = pd.read_csv(io.StringIO(res.decode('utf-8')))
        data['created_at']=datetime.datetime.now()
        data['updated_at']=datetime.datetime.now()
        df = pd.concat([df,data])
        print('added ' + data['name.first'] + ' ' + data['name.last'])

    except Exception as e:
            logging.error(f'An error occured: {e}')
            continue

df.to_csv('raw_users_' + str(datetime.datetime.now()) + '.csv',index=False)
print('Data saved!')
