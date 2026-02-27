import datetime
import mysql.connector
import pandas as pd

def process_suspeito_data(data, connection):

    for index, row in data.iterrows():

        nome = row['Nome']
        idade = int(row['Idade'])
        tel = str(row['Telefone'])
        nif = str(row['NIF'])
        
        
        query = "CALL insert_suspeito(%s, %s, %s, %s);"

        cursor = connection.cursor()
        try:
            cursor.execute(query, (
                nome,
                idade,
                tel,
                nif,
            ))
            connection.commit()
        except mysql.connector.Error as error:
            print("(Suspeito) Erro durante a execução do comando SQL:", error)
        
        cursor.close()
