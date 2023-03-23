from typing import Union
import time
import asyncio
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.responses import HTMLResponse
from starlette.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from .tweet_service import ArtificialTweetService
from .message_manager import MessageManager
from .message import Message

app = FastAPI()

# Added from the hack 22 repo to ensure we don't run into CORS errors
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)


class IncomingMessage(BaseModel):
    message: str
    username: str


html = """
<!DOCTYPE html>
<html>
    <head>
        <title>Chat</title>
    </head>
    <body>
        <h1>WebSocket Chat</h1>
        <form action="" onsubmit="sendMessage(event)">
            <input type="text" id="messageText" autocomplete="off"/>
            <button>Send</button>
        </form>
        <ul id='messages'>
        </ul>
        <script>
            var ws = new WebSocket("ws://localhost:8000/ws");
            ws.onmessage = function(event) {
                var messages = document.getElementById('messages')
                var message = document.createElement('li')
                var content = document.createTextNode(event.data)
                if(content != ""){
                    
                    message.appendChild(content)
                    messages.appendChild(message)
                }
            };
            function sendMessage(event) {
                var input = document.getElementById("messageText")
                ws.send(input.value)
                input.value = ''
                event.preventDefault()
            }
        </script>
    </body>
</html>
"""


@app.get("/")
async def get():
    return HTMLResponse(html)


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}


@app.post("/messages/")
async def post_messages(incoming_message: IncomingMessage):
    tweet_service.add_tweet(
        Message(incoming_message.message, incoming_message.username))


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket, chat: bool = False):
    if chat:
        global tweet_service
    await websocket.accept()
    while True:
        await websocket.receive_text()
        start_time = time.time()
        message_manager = MessageManager(start_time)
        tweet_service = ArtificialTweetService(start_time)
        while True:
            message, min, volume = tweet_service.next_tweet()
            if message is None:
                await asyncio.sleep(2)
                continue

            result_json = message_manager.new_message(message, min, volume)
            await websocket.send_text(result_json)

            await asyncio.sleep(2)
