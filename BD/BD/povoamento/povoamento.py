import pandas as pd
import mysql.connector

from admin import process_admin_data
from cliente import process_cliente_data
from caso import process_caso_data
from detetive import process_detetive_data
from suspeito import process_suspeito_data
from evidencia import process_evidencia_data
from CC import process_cc_data
from detetivecaso import process_detetive_caso_data


# Connect to database
cnx = mysql.connector.connect(
    host="localhost",
    user="root",
    password="bduniversidade",
    database="agencia",
    port=3306,
    autocommit=True
)

if cnx.is_connected():
    print("Conectado ao servidor MySQL.")
else:
    print("Falha na conexão ao servidor MySQL.")

cursor = cnx.cursor()

# Open excel
file_path = 'bd.xlsx'

admin_data = pd.read_excel(file_path, sheet_name='Admin')
process_admin_data(admin_data,cnx)

cliente_data = pd.read_excel(file_path,sheet_name='Cliente')
process_cliente_data(cliente_data,cnx)

caso_data = pd.read_excel(file_path,sheet_name='Caso')
process_caso_data(caso_data,cnx)

detetive_data = pd.read_excel(file_path, sheet_name='Detetive')
process_detetive_data(detetive_data,cnx)

suspeito_data = pd.read_excel(file_path, sheet_name='Suspeito')
process_suspeito_data(suspeito_data,cnx)

evidencia_data = pd.read_excel(file_path,sheet_name='Evidencia')
process_evidencia_data(evidencia_data,cnx)

cc_data = pd.read_excel(file_path,sheet_name='CC')
process_cc_data(cc_data,cnx)

detetive_caso_data = pd.read_excel(file_path,sheet_name='DetetiveCaso')
process_detetive_caso_data(detetive_caso_data,cnx)

print("Povoamento no servidor MySQL realizado com sucesso!")
