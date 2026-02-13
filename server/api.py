from fastapi import FastAPI
from dotenv import load_dotenv, find_dotenv

from agency import Agent
from agency import NIRMA, HEMA, REKHA, JAYA, SUSHMA

# access values from os.environ
load_dotenv(find_dotenv(usecwd=True), override=True)

api = FastAPI()
agent = Agent()

@api.get("/")
async def root() -> dict:
    return {
        "suggestion": "Washing Powder"
    }

@api.get("/agent/nirma/{result}")
async def nirma(result: str) -> dict:
    return agent.respond(result, NIRMA)

    return {
        "suggestion": "I am Nirma."
    }

@api.get("/agent/hema/{result}")
async def hema(result: str) -> dict:
    return agent.respond(result, HEMA)

    return {
        "suggestion": "My name is Hema."
    }

@api.get("/agent/rekha/{result}")
async def rekha(result: str) -> dict:
    return agent.respond(result, REKHA)

    return {
        "suggestion": "Most people know me by Rekha.",
    }

@api.get("/agent/jaya/{result}")
async def jaya(result: str) -> dict:
    return agent.respond(result, JAYA)

    return {
        "suggestion": "People usually call me Miss Jaya, but you can call me MJ."
    }

@api.get("/agent/sushma/{result}")
async def sushma(result: str) -> dict:
    return agent.respond(result, SUSHMA)

    return {
        "suggestion": "Hush up and call me Su."
    }
