from datetime import datetime
from fastapi import APIRouter 

api_v1_router = APIRouter(prefix="/api/v1")

# datetime router will return now
@api_v1_router.get("/datetime")
def datetime_delay():
    return {"serverTime": f"{datetime.now()}"}
