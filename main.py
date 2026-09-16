from fastapi import FastAPI, APIRouter

app = FastAPI()

@app.get("/")
def entry_point():
    return "Not yet implemented."

@app.get("/healthz")
def healthz():
    return "ok"
