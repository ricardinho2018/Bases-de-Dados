import datetime
import mysql.connector
import pandas as pd

def process_detetive_caso_data(data, connection):

    for index, row in data.iterrows():

        idCaso = int(row['Caso'])
        idDetetive = int(row['Detetive'])
        
        query = "CALL insert_detetive_caso(%s, %s);"

        cursor = connection.cursor()
        try:
            cursor.execute(query, (
                idCaso,
                idDetetive,
            ))
            connection.commit()
        except mysql.connector.Error as error:
            print("(Detetive Caso) Erro durante a execução do comando SQL:", error)
        
        cursor.close()
