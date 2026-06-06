import pandas as pd
import random

categorias = {
    "Laptops": ["Dell", "HP", "Lenovo", "Asus"],
    "Smartphones": ["Samsung", "Xiaomi", "Motorola", "Apple"],
    "Tablets": ["Samsung", "Apple", "Lenovo"],
    "Monitores": ["LG", "Samsung", "Dell"],
    "Audífonos": ["Sony", "JBL", "Logitech"],
    "Teclados": ["Logitech", "Redragon", "HP"],
    "Mouse": ["Logitech", "HP", "Microsoft"],
    "Impresoras": ["HP", "Epson", "Canon"],
    "Almacenamiento": ["Kingston", "Samsung", "WD"],
    "Accesorios": ["Genius", "Logitech", "TP-Link"]
}

productos = []

id_producto = 1

for categoria, marcas in categorias.items():

    for i in range(10):

        marca = random.choice(marcas)

        productos.append({
            "id_producto": id_producto,
            "producto": f"{categoria[:-1]} {i+1}",
            "categoria": categoria,
            "marca": marca,
            "precio_base": random.randint(50000, 5000000)
        })

        id_producto += 1

df_productos = pd.DataFrame(productos)

df_productos.to_csv(
    "../Dataset/productos.csv",
    index=False,
    encoding="utf-8-sig"
)

print("Archivo productos.csv generado correctamente")
print(df_productos.head())