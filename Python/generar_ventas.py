import pandas as pd
import random
from datetime import datetime, timedelta

# Cargar datasets existentes

clientes = pd.read_csv("../Dataset/clientes.csv")
productos = pd.read_csv("../Dataset/productos.csv")

ventas = []

fecha_inicio = datetime(2024, 1, 1)
fecha_fin = datetime(2026, 5, 31)

dias = (fecha_fin - fecha_inicio).days

metodos_pago = [
    "Tarjeta Crédito",
    "Tarjeta Débito",
    "Transferencia",
    "Efectivo",
    "PSE"
]

canales = [
    "Tienda Física",
    "Página Web",
    "Marketplace",
    "WhatsApp"
]

for id_venta in range(1, 10001):

    cliente = clientes.sample(1).iloc[0]
    producto = productos.sample(1).iloc[0]

    fecha = fecha_inicio + timedelta(
        days=random.randint(0, dias)
    )

    cantidad = random.randint(1, 5)

    precio_unitario = producto["precio_base"]

    descuento = random.choice(
        [0, 0, 0, 0, 5, 10, 15, 20]
    )

    ventas.append({
        "id_venta": id_venta,
        "fecha": fecha.date(),
        "id_cliente": cliente["id_cliente"],
        "id_producto": producto["id_producto"],
        "cantidad": cantidad,
        "precio_unitario": precio_unitario,
        "descuento": descuento,
        "metodo_pago": random.choice(metodos_pago),
        "canal_venta": random.choice(canales)
    })

df_ventas = pd.DataFrame(ventas)

df_ventas.to_csv(
    "../Dataset/ventas.csv",
    index=False,
    encoding="utf-8-sig"
)

print("Archivo ventas.csv generado correctamente")
print(df_ventas.head())
print(f"Total registros: {len(df_ventas)}")