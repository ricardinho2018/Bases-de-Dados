import datetime
import mysql.connector


def process_detetive_data(data, connection):

    for index, row in data.iterrows():
        
        dataR = row['Data Reg'].timestamp()
        nome = row['Nome']
        password = str(row['Password'])
        idade = int(row['Idade'])
        tel = str(row['Telefone'])
        email = row['Email']
        morada = row['Morada']
        especialidade = row['Especialidade']
        horario = row['Horario']
        idAdmin = int(row['Admin'])

        query = "CALL insert_detetive(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);"
        
        cursor = connection.cursor()
        try:
            cursor.execute(query, (
                datetime.date.fromtimestamp(dataR).strftime('%Y-%m-%d'),
                nome,
                password,
                idade,
                tel, 
                email,
                morada,
                especialidade,
                horario,
                idAdmin
                ))
            connection.commit()
        except mysql.connector.Error as error:
            print("(Detetive) Erro durante a execução do comando SQL:", error)
        
        cursor.close()
