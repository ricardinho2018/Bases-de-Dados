import mysql.connector

def process_cliente_data(data, connection):

    for index, row in data.iterrows():
        
        password = str(row['Password'])
        nome = row['Nome']
        idade = int(row['Idade'])
        email = row['Email']
        tel = str(row['Telefone'])
        idAdmin = int(row['Admin'])

        query = "CALL insert_cliente(%s,%s,%s,%s,%s,%s);"
        
        cursor = connection.cursor()
        try:
            cursor.execute(query, (password,nome,idade,email,tel,idAdmin))
            connection.commit()
        except mysql.connector.Error as error:
            print("(Cliente) Erro durante a execução do comando SQL:", error)
        
        cursor.close()
