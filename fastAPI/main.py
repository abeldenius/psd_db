from fastapi import FastAPI
from typing import List
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
async def receive_texts(texts: List[str]):
    for text in texts:
        print(f"Received text: {text}")
    return {"message": "Texts received"}
