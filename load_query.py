import pandas as pd

# 1. Función para leer el archivo SQL
def load_query(file_path: str) -> str:
    """Lee el contenido completo de un archivo SQL y lo devuelve como una cadena."""
    try:
        with open(file_path, 'r') as f:
            return f.read()
    except FileNotFoundError:
        print(f"ERROR: No se encontró el archivo de consulta en la ruta: {file_path}")
        return ""