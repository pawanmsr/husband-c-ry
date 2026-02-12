from os import path
from pathlib import Path
from hashlib import sha1
from random import shuffle
from datetime import datetime
from pydantic import BaseModel
from typing import List, TypedDict

from langchain.agents import create_agent
from langchain.agents.middleware import dynamic_prompt, ModelRequest
from langchain.agents.structured_output import ToolStrategy

from langchain_core.output_parsers import PydanticOutputParser
from langchain_core.output_parsers import JsonOutputParser
from langchain_core.messages import SystemMessage, HumanMessage
from langchain_core.prompts import ChatPromptTemplate

from langchain.tools import tool

from langchain_community.utilities import OpenWeatherMapAPIWrapper

from langchain_openai import ChatOpenAI
from langchain_anthropic import ChatAnthropic
from langchain_google_genai import ChatGoogleGenerativeAI
# from langchain_mistral import ChatMistralAI

DIRECTORY = "data"

NIRMA = "nirma"
HEMA = "hema"
JAYA = "jaya"
REKHA = "rekha"
SUSHMA = "sushma"


class Suggestion(BaseModel):
    suggestion: str
    tools_used: list[str]

# JSON for APIs and Pydantic for testing within python environment
parser = JsonOutputParser(pydantic_object=Suggestion)
# parser = PydanticOutputParser(pydantic_object=Suggestion)

BASIC = "Be a counsellor and provide suggestions based on relationship results."
ABILITY = "Use tools if necessary."
RESPONSE = f"The output must be formatted as\n{parser.get_format_instructions()}."

class Context(TypedDict):
    person: str

@dynamic_prompt
def attitude(request: ModelRequest) -> str:
    who = request.runtime.context.get("person", NIRMA)

    if who == NIRMA:
        return "Be short and concise."
    elif who == HEMA:
        return "Be formal."
    elif who == REKHA:
        return "Answer in third person."
    elif who == JAYA:
        return "Be sassy."
    elif who == SUSHMA:
        return "Use short forms."
    
    return ""

@tool("notes", description="search from consultation")
def notes(keyword: str, limit=2) -> List[str]:
    results = list()
    
    files = [f for f in Path(DIRECTORY).iterdir() if f.is_file()]
    for path in files:
        try:
            with open(path, "r", encoding="utf-8") as f:
                lines = f.read().split('\n')
                # Possible optimization: implement KMP search while
                #   maintaining count, and select based on frequency
                results = [line for line in lines if keyword in line]
        except:
            pass
    shuffle(results)
    
    return results[:limit]

# TODO: write custom tool for weather

@tool("save", description="store results that were obtained during previous session")
def save(result: str, suggestion: str) -> bool:
    text = f"Result:\n{result}\n\nSuggestion:\n{suggestion}\n"
    
    hash = sha1(text.encode("utf-8"))
    session = datetime.now().strftime("%Y-%m-%d_%H:%M:%S")
    filename = f"{session}-{hash.hexdigest()}.txt"

    try:
        with open(path.join(DIRECTORY, filename), 'a', encoding="utf-8") as f:
            f.write(text)
    except:
        return False
    
    return True

class Agent:
    claude = ChatAnthropic(
        model="claude-haiku-4-5-20251001",
        timeout=32,
        max_tokens=128
    )
    
    def __init__(self, model: str = ""):
        self.agent = create_agent(
            model=self.claude,
            system_prompt=SystemMessage(f"{BASIC} {ABILITY} {RESPONSE}"),
            middleware=[attitude],
            tools=[notes, save],
            context_schema=Context,
            response_format=ToolStrategy(Suggestion)
        )
    
    def respond(self, result: str, endpoint: str = ""):
        response = self.agent.invoke({
            "messages": [HumanMessage(result)]
        }, context={"person": endpoint})

        return response.get("structured_response", {})
