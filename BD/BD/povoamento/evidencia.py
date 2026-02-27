import datetime
import mysql.connector
import pandas as pd

def process_evidencia_data(data, connection):

    for index, row in data.iterrows():
        
        desc = row['Descricao']
        tipo = row['Tipo']
        obs = row['Obs'] if pd.notna(row['Obs']) else None
        dataR = row['Data de Registo'].timestamp()
        loc = row['Localizacao']
        idCaso = row['Caso']
        idSus = row['Suspeito']

        query = "CALL insert_evidencia(%s,%s,%s,%s,%s,%s,%s);"
        
        cursor = connection.cursor()
        try:
            cursor.execute(query, (
                desc,
                tipo,
                obs,
                datetime.date.fromtimestamp(dataR).strftime('%Y-%m-%d'),
                loc,
                idCaso,
                idSus,
                ))
            connection.commit()
        except mysql.connector.Error as error:
            print("(Evidencia) Erro durante a execução do comando SQL:", error)
        
        cursor.close()
