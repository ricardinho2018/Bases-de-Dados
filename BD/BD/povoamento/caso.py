import mysql.connector
import datetime
import pandas as pd

def process_caso_data(data, connection):

    for index, row in data.iterrows():
        
        titulo = row['Titulo']
        dataA = row['Data de Abertura'].timestamp()
        dataF = row['Data de Fechamento'].timestamp()
        descricao = row['Descricao']
        obs = row['Observacoes'] if pd.notna(row['Observacoes']) else None
        status = row['Status']
        especialidade = row['Especialidade']
        idAdmin = int(row['Admin'])
        idCliente = int(row['Cliente'])


        query = "CALL insert_caso(%s,%s,%s,%s,%s,%s,%s,%s,%s);"
        
        cursor = connection.cursor()
        try:
            cursor.execute(query, (
                titulo,
                datetime.date.fromtimestamp(dataA).strftime('%Y-%m-%d'),
                datetime.date.fromtimestamp(dataF).strftime('%Y-%m-%d'),
                descricao,
                obs,
                status,
                especialidade,
                idAdmin,
                idCliente
                ))
            connection.commit()
        except mysql.connector.Error as error:
            print("(Caso) Erro durante a execução do comando SQL:", error)
        
        cursor.close()
