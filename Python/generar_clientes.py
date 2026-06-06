from faker import Faker
import pandas as pd
import random

fake = Faker('es_CO')

ciudades = [
    "Bogotá",
    "Medellín",
    "Cali",
    "Barranquilla",
    "Cartagena",
    "Bucaramanga",
    "Pereira",
    "Manizales",
    "Cúcuta",
    "Villavicencio"
]

segmentos = [
    "Corporativo",
    "Pyme",
    "Premium",
    "Estándar"
]

clientes = []

for i in range(1, 501):

    clientes.append({
        "id_cliente": i,
        "nombre": fake.first_name(),
        "apellido": fake.last_name(),
        "sexo": random.choice(["M", "F"]),
        "edad": random.randint(18, 70),
        "ciudad": random.choice(ciudades),
        "fecha_registro": fake.date_between(
            start_date='-5y',
            end_date='today'
        ),
        "segmento_cliente": random.choice(segmentos)
    })

df_clientes = pd.DataFrame(clientes)

df_clientes.to_csv(
    "../Dataset/clientes.csv",
    index=False,
    encoding="utf-8-sig"
)

print("Archivo clientes.csv generado correctamente")
print(df_clientes.head())