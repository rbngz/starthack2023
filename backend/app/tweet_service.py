import time
from copy import deepcopy
from .message import Message
from .message_manager import MessageManager

messages = [
    {
    "second": 2,
    "message": "That is great! #HCC",
    "username": "pucklover492",
},
{
    "second": 4,
    "message": "How did he not save that??? #HCC",
    "username": "BayStr33tBully"
},
{
    "second": 6,
    "message": "Finally a win! #HCC",
    "username": "pucklover492"
}
]

# TODO account for start_second - probably in aggregate service too
class ArtificialTweetService:
    def __init__(self, 
                 start_time):
        self.start_time = start_time
        self.messages = deepcopy(messages)
        self.last_batch = self.start_time
        self.index = 0
    
    def next_tweet(self):
        if len(messages) == 0:
            return None
        
        message_json = messages.pop(0)
        return Message(message_json["message"], message_json["username"])
                    
                
        
        
