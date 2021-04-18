from typing import Any, Optional

from fastapi import FastAPI
from uvicorn import run

app = FastAPI()


@app.get("/")
def read_root() -> dict[str, str]:
    return {"Hello": "World"}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Optional[str] = None) -> dict[str, Any]:
    return {"item_id": item_id, "q": q}


if __name__ == "__main__":
    run(app)
