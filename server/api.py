from fastapi import FastAPI

from agency import agent
# from agency import nirma, hema, rekha, jaya, sushma

api = FastAPI()

@api.get("/")
async def root():
    return {
        "message": "Washing Powder"
    }

@api.get("/agent/nirma/{result}")
async def nirma(result: str):
    return {
        "message": "I am Nirma."
    }

@api.get("/agent/hema/{result}")
async def hema(result: str):
    return {
        "message": "My name is Hema."
    }

@api.get("/agent/rekha/{result}")
async def rekha(result: str):
    return {
        # "message": "Most people know me by Rekha.",
        "message": agent.respond(result)
    }

@api.get("/agent/jaya/{result}")
async def jaya(result: str):
    return {
        "message": "People usually call me Miss Jaya, but you can call me MJ."
    }

@api.get("/agent/sushma/{result}")
async def sushma(result: str):
    return {
        "message": "Hush up and call me Su."
    }
