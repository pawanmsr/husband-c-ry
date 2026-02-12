from fastapi import FastAPI
from dotenv import load_dotenv

from agency import Agent
from agency import NIRMA, HEMA, REKHA, JAYA, SUSHMA

load_dotenv() # access values from os.environ

api = FastAPI()
agent = Agent()

@api.get("/")
async def root() -> dict:
    return {
        "message": "Washing Powder"
    }

@api.get("/agent/nirma/{result}")
async def nirma(result: str) -> dict:
    return {
        "message": "I am Nirma."
    }

@api.get("/agent/hema/{result}")
async def hema(result: str) -> dict:
    return {
        "message": "My name is Hema."
    }

@api.get("/agent/rekha/{result}")
async def rekha(result: str) -> dict:
    return agent.respond(result, REKHA)

    return {
        "message": "Most people know me by Rekha.",
    }

@api.get("/agent/jaya/{result}")
async def jaya(result: str) -> dict:
    return agent.respond(result, JAYA)

    return {
        "message": "People usually call me Miss Jaya, but you can call me MJ."
    }

@api.get("/agent/sushma/{result}")
async def sushma(result: str) -> dict:
    return {
        "message": "Hush up and call me Su."
    }
