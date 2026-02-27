import datetime
import mysql.connector
import pandas as pd

def process_cc_data(data, connection):

    for index, row in data.iterrows():

        tipo = row['Tipo']
        desc = row['Descricao']
        data =  row['Data'].timestamp()
        idEvidencia = int(row['Evidencia'])
        
        
        query = "CALL insert_cadeia_de_custodia(%s, %s, %s, %s);"

        cursor = connection.cursor()
        try:
            cursor.execute(query, (
                tipo,
                desc,
                datetime.date.fromtimestamp(data).strftime('%Y-%m-%d'),
                idEvidencia,
            ))
            connection.commit()
        except mysql.connector.Error as error:
            print("(CC) Erro durante a execução do comando SQL:", error)
        
        cursor.close()
