from fastapi import FastAPI
from typing import Dict
from fastapi.middleware.cors import CORSMiddleware
from db.id_generator import generate_id
from datetime import datetime
from db.main import insertion



app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.post("/receive_texts/")
async def receive_texts(texts: Dict[str, str]):
    for key, values in texts.items():
        print(key, values)
    texts['ID'] = generate_id(texts["Enhed"], texts["Sagsnummer"])
    texts["Tid og dato"] = datetime.now().strftime("%d-%m-%Y %H:%M")
    insertion(texts)

    return {"message": "Data received"}
