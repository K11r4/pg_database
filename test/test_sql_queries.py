#! /usr/bin/env python3
import psycopg2
import pandas as pd
import unittest

import warnings
warnings.filterwarnings(action='once')

sql = dict()

with open('../scripts/ddl.sql') as query:
    sql['ddl'] = query.read().strip()

with open('../scripts/inserts.sql') as query:
    sql['inserts'] = query.read().strip()

for query_num in range(1, 7):
    with open(f'../scripts/complex_queries/select_{query_num}.sql') as query:
        sql[f'select_{query_num}'] = query.read().strip()

conn = psycopg2.connect(dbname="postgres", host="localhost",
                        user="postgres", password="postgres", port="5432")
with conn.cursor() as cursor:
    cursor.execute(sql['ddl'])
    cursor.execute(sql['inserts'])


class TestSelectQueries(unittest.TestCase):
    def test_select_1(self):
        df = pd.read_sql(sql[f'select_{1}'], con=conn)
        self.assertEqual(list(df.columns), ['name', 'members_count'])
        self.assertTrue(df.shape[0] <= 4)
        self.assertTrue(
            {status for status in df['name'].unique()}.issubset( {'Sacred Order Of Light', 'Undead Horde 3000', 'Wrath Of Fire', 'No Mercy Players'} )
        )

    def test_select_2(self):
        df = pd.read_sql(sql[f'select_{2}'], con=conn)
        self.assertEqual(list(df.columns), ['name', 'successful_attacks'])
        self.assertEqual(df.shape[0], 10)
        self.assertEqual(
            list(df['successful_attacks']),
            list(reversed(sorted(list(df['successful_attacks']))))
        )

    def test_select_3(self):
        df = pd.read_sql(sql[f'select_{3}'], con=conn)
        self.assertEqual(list(df.columns), [
                         'player', 'faction', 'place_in_faction'])
        self.assertTrue(df.shape[0] <= 10)
        self.assertTrue((
            df.groupby('faction')['place_in_faction'].max() ==
            df.groupby('faction')['place_in_faction'].count()
        ).all())

    def test_select_4(self):
        df = pd.read_sql(sql[f'select_{4}'], con=conn)
        self.assertEqual(list(df.columns), ['palyer', 'faction', 'avg_rank'])
        self.assertTrue(df.shape[0] <= 10)
        self.assertTrue((
            df.groupby('faction')['avg_rank'].nunique()
        ).all())

    

    def test_select_5(self):
        df = pd.read_sql(sql[f'select_{5}'], con=conn)
        self.assertEqual(list(df.columns), ['faction', 'league'])
        self.assertTrue(df.shape[0] == 4)
        self.assertTrue((
            df.groupby('league').count().max() <=
            df.groupby('league').count().min() + 1
        ).all())

    def test_select_6(self):
        df = pd.read_sql(sql[f'select_{6}'], con=conn)
        self.assertEqual(list(df.columns), ['player', 'faction', 'status'])
        self.assertTrue(df.shape[0] <= 10)
        self.assertTrue(len(df['faction'].unique()) <= 4)
        self.assertTrue({status for status in df['status'].unique()}.issubset( {'strong', 'medium', 'trash'}))
        


unittest.main()
conn.close()
