from fastapi import FastAPI, APIRouter
from fastapi.middleware.cors import CORSMiddleware

from apiv1 import api_v1_router

app = FastAPI()

# tempovarily add all origins
origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def entry_point():
    return "Not yet implemented."

@app.get("/healthz")
def healthz():
    return "ok"

# add router
app.include_router(api_v1_router)