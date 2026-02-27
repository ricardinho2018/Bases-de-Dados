import mysql.connector

def process_admin_data(data, connection):

    for index, row in data.iterrows():
        
        email = row['Email']
        password = str(row['Password'])
        nome = row['Nome']

        query = "CALL insert_administrador(%s,%s,%s);"
        
        cursor = connection.cursor()
        try:
            cursor.execute(query, (email,password,nome))
            connection.commit()
        except mysql.connector.Error as error:
            print("(Admin) Erro durante a execução do comando SQL:", error)
        
        cursor.close()
