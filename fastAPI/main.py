from fastapi import FastAPI
from typing import Dict
from fastapi.middleware.cors import CORSMiddleware


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
    for key, value in texts.items():
        print(f"Received {key}: {value}")
    return {"message": "Data received"}
