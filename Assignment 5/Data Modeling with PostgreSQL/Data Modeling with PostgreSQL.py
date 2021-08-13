import pandas as pd
from sqlalchemy import create_engine
import json
from pandas import json_normalize

# connection string to connect with postgreSql Server
engine = create_engine("postgresql://postgres:devraj@localhost:5432/demo")

#a. List each aircraft type, a separate list of seats is supported.
query = 'select * from aircrafts_data;'
df = pd.read_sql_query(query, engine)
print(type(df['model'][1]))
for model in df['model']:
    print(model['en'])


#c. Which cities have more than one airport?
query = 'select city , count(airport_name) from airports_data group by city having count(airport_name) > 1'
df = pd.read_sql_query(query, engine)
print(df)

#e. Find top 5-spending customers
query = '''select t.passenger_id as ID, t.passenger_name as Passenger_Name, sum(tf.amount) as Total_Money_Spend from tickets t
inner join ticket_flights tf
on t.ticket_no = tf.ticket_no group by t.passenger_id, t.passenger_name order by sum(tf.amount) desc
limit 5;'''
df = pd.read_sql_query(query, engine)
print(df)

#3. Show the record count of each table.
query = '''SELECT schemaname as schema_name,relname as table_name,n_live_tup as total_record_count
  FROM pg_stat_user_tables 
  ORDER BY n_live_tup DESC;'''
df = pd.read_sql_query(query, engine)
print(df)

#5. Define Index on tables
query = '''CREATE INDEX idx_seat_no ON seats(seat_no);'''
df = pd.read_sql_query(query, engine)
print(df)

#show command to find and index
query = '''SELECT * FROM pg_indexes where tablename = 'seats';'''
df = pd.read_sql_query(query, engine)
print(df)

#Update City Ulyanovsk to Volga
query = '''UPDATE airports_data SET city = city || '{"en": "Volga", "ru": "Volga"}' where city->>'en' = 'Ulyanovsk';'''
df = pd.read_sql_query(query, engine)
print(df)

query = '''insert into bookings values('000001',NOW(),1) RETURNING *;'''
df = pd.read_sql_query(query, engine)
print(df)


query='''insert into tickets values('1','000001','1234','Text','{"phone":"+1234"}') RETURNING *;'''
df = pd.read_sql_query(query, engine)
print(df)



