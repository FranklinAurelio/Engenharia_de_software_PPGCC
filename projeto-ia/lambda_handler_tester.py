import json
from lambda_function import lambda_handler

payload = {
    "genero": "F",
    "faixa_etaria": "Adultos",
    "uf": "São Paulo",
    "regiao": "Sudeste"
}

body = payload
context = None

lambda_handler(body, context)