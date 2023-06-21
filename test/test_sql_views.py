#! /usr/bin/env python3
import psycopg2
import pandas as pd
import unittest
import re

import warnings
warnings.filterwarnings(action='once')


def create_view(path, conn):
    with open(path, 'r') as file:
        view_create = file.read().strip()
        with conn.cursor() as cursor:
            cursor.execute(view_create)
        view_name = re.search('VIEW (.+?) AS', view_create).group(1)
    return f'SELECT * FROM {view_name};'

sql = dict()

with open('../scripts/ddl.sql') as query:
    sql['ddl'] = query.read().strip()

with open('../scripts/inserts.sql') as query:
    sql['inserts'] = query.read().strip()



conn = psycopg2.connect(dbname="postgres", host="localhost",
                        user="postgres", password="postgres", port="5432")
with conn.cursor() as cursor:
    cursor.execute(sql['ddl'])
    cursor.execute(sql['inserts'])

for query_num in range(1, 7):
    sql[f'read_view_{query_num}'] = create_view(f'../scripts/views/view_{query_num}.sql', conn)


class TestSelectQueries(unittest.TestCase):
    def test_select_1(self):
        df = pd.read_sql(sql[f'read_view_{1}'], con=conn)
        self.assertEqual(list(df.columns), ['nick', 'blured_email', 'rank', 'faction'])
        self.assertTrue(
            df['blured_email'].str.match(r'\w{3}\*{4}\d\d\@.*\..*').astype(bool).all()
        )

    def test_select_2(self):
        df = pd.read_sql(sql[f'read_view_{2}'], con=conn)
        self.assertEqual(list(df.columns), ['leader', 'description', 'units', 'magic_damage', 'total_phys_damage', 'total_health'])
        self.assertTrue(
            df.apply(lambda raw: len(raw.description) <= 23, axis=1).all()
        )

    def test_select_3(self):
        df = pd.read_sql(sql[f'read_view_{3}'], con=conn)
        self.assertEqual(list(df.columns), ['owner', 'tower', 'description', 'magic_damage', 'physical_damage', 'cordinates'])
        self.assertTrue(
            df.apply(lambda raw: len(raw.description) <= 23, axis=1).all()
        )

    def test_select_4(self):
        df = pd.read_sql(sql[f'read_view_{4}'], con=conn)
        self.assertEqual(list(df.columns), ['name', 'successful_attacks_percents'])
        self.assertEqual(df.shape[0], 10)
        self.assertEqual(
            list(df['successful_attacks_percents']),
            list(reversed(sorted(list(df['successful_attacks_percents']))))
        )


    def test_select_5(self):
        df = pd.read_sql(sql[f'read_view_{5}'], con=conn)
        self.assertEqual(list(df.columns), ['faction', 'league'])
        self.assertEqual(df.shape[0], 4)
        self.assertTrue((
            df.groupby('league').count().max() <=
            df.groupby('league').count().min() + 1
        ).all())

    def test_select_6(self):
        df = pd.read_sql(sql[f'read_view_{6}'], con=conn)
        self.assertEqual(list(df.columns), ['player', 'faction', 'status'])
        self.assertTrue(df.shape[0] <= 10)
        self.assertTrue(len(df['faction'].unique()) <= 4)
        self.assertTrue({status for status in df['status'].unique()}.issubset( {'strong', 'medium', 'trash'}))


unittest.main()
conn.close()
