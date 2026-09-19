from datetime import datetime
from fastapi import APIRouter 

api_v1_router = APIRouter(prefix="/api/v1")

# datetime router will return now
@api_v1_router.get("/datetime")
def datetime_server():
    return {"serverTime": f"{datetime.now()}"}

@api_v1_router.get("/datetimeh")
def datetime_server_human_readable():
    return {"Time_human_readable_format": f"{datetime.now().strftime("%A, %B %d, %Y")}"}
