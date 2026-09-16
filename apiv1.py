from datetime import datetime
from fastapi import APIRouter 

router = APIRouter(prefix="/api/v1/")

# datetime router will return now
@router.get("/datetime")
def datetime_delay():
    return {"serverTime": f"{datetime.now()}"}
